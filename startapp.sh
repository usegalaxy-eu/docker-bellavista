#!/bin/sh -f

. /opt/bellavista/bellavista/bin/activate

if [ -n "${BELLAVISTA_DIR}" ]; then
    cd "$BELLAVISTA_DIR" && bellavista "./config.json"
else
    cd /input && bellavista "./config.json"
fi