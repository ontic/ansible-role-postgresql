#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V

if [ "${distribution}" = "debian" ] || [ "${distribution}" = "ubuntu" ]; then
    docker exec --tty ${container_id} env TERM=xterm journalclt --no-pager
elif [ "${distribution}" = "centos" ]; then
    docker exec --tty ${container_id} env TERM=xterm journalclt --no-pager
fi