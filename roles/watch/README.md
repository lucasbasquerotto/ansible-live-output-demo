Watch
=====

Watch the output of long-running tasks.

Requirements
------------

Linux or MacOSX

Role Variables
--------------

* `watch_job`: The name of the job to watch.
* `watch_file`: (optional) The path to a logfile to tail.
* `watch_lines`: The number of logfile lines to skip.
* `watch_poll`: Seconds between status checks. (default 1)
* `watch_timeout`: Maximum seconds to watch a single job. (default 1000)

Dependencies
------------

None.

Usage
-----

```yaml

- name: 'Start a long-running task.'
  shell: 'some-command > /some/log/file'
  async: 3600                             # Max runtime in seconds.
  poll: 0                                 # Run in the background.
  register: 'longjob'                     # Unique Job name.

- name: 'Watch /some/log/file until some-command finishes.'
  include_role:
    name: 'watch'
  vars:
    watch_file: '/some/log/file'          # Output log file (optional).
    watch_job: 'longjob'                  # Job name from previous task.
    watch_timeout: 3600                   # Set at least as high as async.

- name: 'Run another task with the same logfile.'
  shell: 'some-other-command >> /some/log/file'
  async: 600
  poll: 0
  register: 'anotherjob'

- name: 'Continue watching /some/log/file until some-other-command finishes.'
  include_role:
    name: 'watch'
    tasks_from: 'again'
  vars:
    watch_file: '/some/log/file'
    watch_job: 'anotherjob'

```

License
-------

BSD

Author Information
------------------

[Robert August Vincent II](https://github.com/pillarsdotnet)  
*(pronounced "Bob" or "Bob-Vee")*