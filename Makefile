.PHONY: centos8 centos7 centos6
centos8 centos7 centos6:
	docker build -t dalibo/labs-sdk:$@ $@/
