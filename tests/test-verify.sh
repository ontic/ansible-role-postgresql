#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm initctl list

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm which psql -V