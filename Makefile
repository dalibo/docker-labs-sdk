.PHONY: centos8
centos8:
	docker build -t dalibo/labs-sdk:$@ $@/
