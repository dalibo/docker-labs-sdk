.PHONY: buster centos8 centos7 centos6
buster centos8 centos7 centos6:
	docker build -t dalibo/labs-sdk:$@ $@/
