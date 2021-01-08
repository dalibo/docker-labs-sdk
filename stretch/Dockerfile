FROM buildpack-deps:stretch

ADD https://github.com/vishnubob/wait-for-it/raw/master/wait-for-it.sh /usr/local/bin/
RUN set -ex; \
    chmod +x /usr/local/bin/wait-for-it.sh; \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - ; \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main 13" > /etc/apt/sources.list.d/pgdg.list; \
    mkdir -p /etc/postgresql-common/createcluster.d/; \
    echo "create_main_cluster = false" > /etc/postgresql-common/createcluster.d/no-main-cluster.conf; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        bats \
        build-essential \
        jq \
        lsb-release \
        postgresql-13 postgresql-client-13 \
        postgresql-12 postgresql-client-12 \
        postgresql-11 postgresql-client-11 \
        postgresql-10 postgresql-client-10 \
        postgresql-9.6 postgresql-client-9.6 \
        postgresql-9.5 postgresql-client-9.5 \
        python3.5 \
        python3-pip \
        python2.7 \
        python-pip \
        ruby \
        ruby-dev \
        rubygems \
        shellcheck \
        sudo \
    ; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
    :

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/local/sbin/tini

RUN set -ex; \
    useradd --system testuser; \
    :

RUN set -ex; \
    chmod +x /usr/local/sbin/tini; \
    pip2 --no-cache-dir install --upgrade pip; \
    hash -r pip2; \
    pip2 --no-cache-dir install --upgrade setuptools wheel; \
    pip2 --no-cache-dir install --upgrade \
        pytest \
    ; \
    :

RUN set -ex; \
    pip3 --no-cache-dir install --upgrade pip setuptools; \
    hash -r pip3; \
    pip3 --no-cache-dir install --upgrade \
        pep440deb \
        "virtualenv<20" \
        virtualenv-tools \
    ; \
    :

RUN set -ex; \
    gem install --no-ri --no-rdoc fpm; \
    gem cleanup; \
    :

ENTRYPOINT ["/usr/local/sbin/tini", "-gw", "--"]
