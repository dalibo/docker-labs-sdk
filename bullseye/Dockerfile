FROM buildpack-deps:bullseye

ADD https://github.com/vishnubob/wait-for-it/raw/master/wait-for-it.sh /usr/local/bin/
RUN set -ex; \
    chmod +x /usr/local/bin/wait-for-it.sh; \
    curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - ; \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main 13" > /etc/apt/sources.list.d/pgdg.list; \
    mkdir -p /etc/postgresql-common/createcluster.d/; \
    echo "create_main_cluster = false" > /etc/postgresql-common/createcluster.d/no-main-cluster.conf; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        bats \
        build-essential \
        jq \
        lsb-release \
        npm \
        postgresql-13 postgresql-client-13 \
        postgresql-12 postgresql-client-12 \
        postgresql-11 postgresql-client-11 \
        postgresql-10 postgresql-client-10 \
        postgresql-9.6 postgresql-client-9.6 \
        postgresql-9.5 postgresql-client-9.5 \
        python3-pip \
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
    chmod +x /usr/local/sbin/tini; \
    useradd --system testuser; \
    :

RUN set -ex; \
    npm install --global \
        pyright \
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
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 - ; \
    ln -s ~/.poetry/bin/poetry /usr/local/bin/poetry ; \
    poetry --version ; \
    rm -rf ~/.cache; \
    :

RUN set -ex; \
    gem install --no-document fpm; \
    gem cleanup; \
    :

ENTRYPOINT ["/usr/local/sbin/tini", "-gw", "--"]
