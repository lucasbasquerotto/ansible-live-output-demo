#!/bin/bash
set -eou pipefail

arr=( 
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, " 
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " 
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris " 
    "nisi ut aliquip ex ea commodo consequat. " 
    "Duis aute irure dolor in reprehenderit in voluptate velit esse " 
    "cillum dolore eu fugiat nulla pariatur. " 
    "Excepteur sint occaecat cupidatat non proident, " 
    "sunt in culpa qui officia deserunt mollit anim id est laborum."
)

for i in {1..20}; do
    for s in "${arr[@]}"; do
        echo "$(date '+%F %X') - $i - $s"
    done

    sleep 1
done