#!/bin/bash

case "$1" in
"train_nlu")
  docker run -v $(pwd):/app/project -v $(pwd)/models/rasa_nlu:/app/models rasa/rasa_nlu:latest-tensorflow run python -m rasa_nlu.train -c config.yml -d project/data/nlu_json/ -o models --project current
  ;;
"train_core")
  docker rm -v $(docker ps -a -q -f status=exited)
  docker run -v $(pwd):/app/project -v $(pwd)/models/rasa_core:/app/models -v $(pwd)/policy.yml:/app/policy.yml rasa/rasa_core:latest train --domain project/domain.yml --stories project/data/core/stories.md  -c policy.yml  --out models
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
