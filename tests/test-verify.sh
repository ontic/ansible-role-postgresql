#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V

if [ "${distribution}" = "debian" ] || [ "${distribution}" = "ubuntu" ]; then
    docker exec --tty ${container_id} env TERM=xterm ls /var/lib/postgresql/10/main
    docker exec --tty ${container_id} env TERM=xterm cat /var/lib/postgresql/10/main/postgresql.conf
elif [ "${distribution}" = "centos" ]; then
    docker exec --tty ${container_id} env TERM=xterm ls /var/lib/pgsql/10/data
    docker exec --tty ${container_id} env TERM=xterm cat /var/lib/pgsql/10/data/postgresql.conf
fi