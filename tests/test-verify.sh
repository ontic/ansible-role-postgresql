#!/bin/bash

# Verify the installed PostgreSQL version.
docker exec --tty ${container_id} env TERM=xterm psql -V

# Verify that databases were created.
docker exec --tty ${container_id} env TERM=xterm psql -l -U postgres