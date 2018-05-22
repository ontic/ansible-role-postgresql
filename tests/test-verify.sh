#!/bin/bash
# Copyright (c) Ontic. (http://www.ontic.com.au). All rights reserved.
# See the COPYING file bundled with this package for license details.

# Verify the installed location.
docker exec --tty ${container_id} env TERM=xterm which psql
# Verify the installed version.
docker exec --tty ${container_id} env TERM=xterm psql -V
# Verify that databases were created.
docker exec --tty ${container_id} env TERM=xterm sudo -u postgres psql -l -U postgres