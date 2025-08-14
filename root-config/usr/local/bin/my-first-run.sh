#!/bin/bash

# Check if the task has already been run.
if [ -f /var/lib/my-first-run.done ]; then
    echo "First-run script has already executed. Exiting."
    exit 0
fi

# Your one-time task goes here.
echo "Running my one-time startup task with internet connection..."
# Example task: Fetch some data from the internet
# curl https://example.com/api/data > /var/lib/my-data.txt
dmidecode > /tmp/my-data.txt

# Mark the task as complete so it doesn't run again.
touch /var/lib/my-first-run.done
