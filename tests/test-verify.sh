#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V

if [ "${distribution}" = "debian" ] || [ "${distribution}" = "ubuntu" ]; then
    docker exec --tty ${container_id} env TERM=xterm cat /etc/postgresql/10/main/postgresql.conf && echo -e "\n\n"
    docker exec --tty ${container_id} env TERM=xterm journalctl -u postgresql.service --no-pager
elif [ "${distribution}" = "centos" ]; then
    docker exec --tty ${container_id} env TERM=xterm cat /var/lib/pgsql/10/data/postgresql.conf && echo -e "\n\n"
    docker exec --tty ${container_id} env TERM=xterm journalctl -u postgresql-10.service --no-pager
fi