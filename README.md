# Ansible Output in Real-Time

This repository provides a minimal demonstration of running an ansible playbook and seeing the output of a shell command in real time (as the command is running). 

The playbook includes the role `long_run` that executes the task asynchronously and calls the role `watch` that watches the job and shows its output incrementally, waiting a specified amount of seconds (`long_run_poll`) between consecutive displays, giving a near real time behaviour (for small values of `long_run_poll`).

## Some features and behaviour

- If the job is ended with an error code, the watch task also ends with an error.
- If the job had no output in some (or all) iterations of the watch job, there will be no output displayed by ansible in such iterations.
- It was created a custom callback plugin to allow printing ansible tasks with the `ok` status **only** if the task has a tag `print_action` (along with the options `display_ok_hosts = no` and `display_skipped_hosts = no` in `ansible.cfg`) to print only relevant stuff.
- The time between 2 consecutive outputs from the watch job is the time specified in `long_run_poll` plus the time taken to execute the other tasks to update the state of the job, retrieving the lines, actually displaying it, and so on.

## Running the playbook

To make it easier to run the playbook, it was created a docker compose file to allow running the playbook inside a docker container with Ansible 2.8 installed (the image is already provided, you can simply run the commands below).

### 1. In this repository, start the docker container with ansible installed

```bash
docker-compose run --rm ansible /bin/bash
```

### 2. Inside the container, run the playbook and see the output in realtime

```bash
ansible-playbook main.yml
```
## Screenshot of the output

![ansible output image](https://raw.githubusercontent.com/lucasbasquerotto/my-projects/master/images/ansible-output.png)

## Tips:

1) Change `long_run_poll` in `main.yml` from `3` to `1` and see that the output is show in shorter intervals.

2) Change `files/task.sh` including some kind of error in the script to see a case in which the task is executed unsuccessfully.

3) Remove the strings in the array of `files/task.sh` to see a case in which there is no output from the task.

4) Change the file `ansible.cfg` commenting the lines `display_ok_hosts` and `stdout_callback` to see that many unnecessary stuff is displayed. It can be much worse for tasks that may take a considerable amount of time with a small output (that's the main reason for using the custom callback plugin).
