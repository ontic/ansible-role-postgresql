#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V

if [ "${distribution}" = "debian" ] || [ "${distribution}" = "ubuntu" ]; then
    docker exec --tty ${container_id} env TERM=xterm ls /usr/lib/postgresql/10
elif [ "${distribution}" = "centos" ]; then
    docker exec --tty ${container_id} env TERM=xterm ls /var/lib/pgsql/10
    docker exec --tty ${container_id} env TERM=xterm ls /usr/pgsql-10
fi