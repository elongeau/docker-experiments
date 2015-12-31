#!/bin/bash

MONGO_DIR=$(dirname $0)
DEFAULT_NAME="bank-account-db"
DEFAULT_DATA_DIR="~/mongo-data"

function default() {
  if [[ -z "$1" ]]; then 
    echo "$2"
  else
    echo "$1"
  fi
}

function mongo_start() {
  cd $MONGO_DIR
  docker-compose up -d
  cd - > /dev/null # go to previous folder
}

function mongo_stop() {
  cd $MONGO_DIR
  docker-compose stop
  cd - > /dev/null # go to previous folder
}

function mongo_shell() {
  name="$(default $1 $DEFAULT_NAME)"
  docker run -it --link $name:mongo --rm mongo sh -c 'exec mongo "$MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT/test"'
}
alias mongo-start="mongo_start"
alias mongo-shell="mongo_shell"
alias mongo-stop="mongo_stop"
