#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V
docker exec --tty ${container_id} env TERM=xterm ls /etc/init.d/ || true