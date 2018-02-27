#!/bin/bash

docker exec --tty ${container_id} env TERM=xterm journalctl -xe
# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V