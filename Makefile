.PHONY: scale controller


controller:
	@docker-compose run ansible bash

scale:
	@docker-compose scale ubuntu=3 centos=2

test:
	@ansible all -m ping