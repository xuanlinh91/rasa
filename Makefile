.PHONY: clean train-nlu train-core cmdline server

TEST_PATH=./

help:
	@echo "    clean"
	@echo "        Remove python artifacts and build artifacts."
	@echo "    train-nlu"
	@echo "        Trains a new nlu model using the projects Rasa NLU config"
	@echo "    train-core"
	@echo "        Trains a new dialogue model using the story training data"
	@echo "    action-server"
	@echo "        Starts the server for custom action."
	@echo "    cmdline"
	@echo "       This will load the assistant in your terminal for you to chat."


clean:
	docker-compose down
	docker rm -v $(docker ps -a -q -f status=exited)

train-nlu:
	docker run -v $(notdir $(CURDIR)):/app/project -v $(notdir $(CURDIR))/models/rasa_nlu:/app/models rasa/rasa_nlu:latest-tensorflow run python -m rasa_nlu.train -c config.yml -d project/data/nlu.md -o models --project current

train-core:
	docker run -v $(notdir $(CURDIR)):/app/project -v $(notdir $(CURDIR))/models/rasa_core:/app/models rasa/rasa_core:latest train --domain project/domain.yml --stories project/data/stories.md --out models

build:
	docker-compose up -d

interactive:
    python -m rasa_core.train interactive --core models/dialogue --nlu models/current/nlu --endpoints config/endpoints.yml

action-server:
	python -m rasa_core_sdk.endpoint --actions actions
