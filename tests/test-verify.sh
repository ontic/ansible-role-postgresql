#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V

if [ "${distribution}" = "debian" ] || [ "${distribution}" = "ubuntu" ]; then
    docker exec --tty ${container_id} env TERM=xterm ls /var/lib/postgresql/10/main && echo "\n\n"
    docker exec --tty ${container_id} env TERM=xterm ls /etc/postgresql/10/main && echo "\n\n"
    docker exec --tty ${container_id} env TERM=xterm cat /etc/postgresql/10/main/postgresql.conf && echo "\n\n"
elif [ "${distribution}" = "centos" ]; then
    docker exec --tty ${container_id} env TERM=xterm ls /var/lib/pgsql/10/data && echo "\n\n"
    docker exec --tty ${container_id} env TERM=xterm cat /var/lib/pgsql/10/data/postgresql.conf && echo "\n\n"
fi