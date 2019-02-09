#!/bin/bash

case "$1" in
"train_nlu")
  docker run -v $(pwd):/app/project -v $(pwd)/models/rasa_nlu:/app/models rasa/rasa_nlu:latest-tensorflow run python -m rasa_nlu.train -c config.yml -d project/data/nlu.md -o models --project current
    ;;
"train_core")
  docker run   -v $(pwd):/app/project   -v $(pwd)/models/rasa_core:/app/models   rasa/rasa_core:latest   train     --domain project/domain.yml     --stories project/data/stories.md     --out models
    ;;
"run")
  docker-compose up -d
    ;;
"clean")
 docker rm -v $(docker ps -a -q -f status=exited)
   ;;
"stop")
 docker-compose down
   ;;
esac
