.PHONY: centos8 centos7
centos8 centos7:
	docker build -t dalibo/labs-sdk:$@ $@/
