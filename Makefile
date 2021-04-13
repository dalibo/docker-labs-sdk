.PHONY: bullseye buster stretch centos8 centos7 centos6
bullseye buster stretch centos8 centos7 centos6:
	docker build -t dalibo/labs-sdk:$@ $@/
