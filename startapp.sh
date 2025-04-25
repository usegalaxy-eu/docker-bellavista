#!/bin/sh -f

. /opt/bellavista/bellavista/bin/activate

if [ -z ${BELLAVISTA_DIR+x} ]
  then
      cd $BELLAVISTA_DIR && bellavista "./config.json"
  else
      cd /input && bellavista "./config.json"
fi
