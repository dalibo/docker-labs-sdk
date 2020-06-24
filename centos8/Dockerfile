FROM centos:8

ADD https://github.com/vishnubob/wait-for-it/raw/master/wait-for-it.sh /usr/local/bin/
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/local/sbin/
RUN set -ex; \
    chmod +x /usr/local/bin/wait-for-it.sh; \
    chmod +x /usr/local/sbin/tini; \
    sed -i s/^keepcache=.*/keepcache=1/ /etc/yum.conf; \
    yum -qy install \
        dnf-plugins-core \
        epel-release \
        https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    ; \
    yum config-manager --set-enabled PowerTools; \
    dnf -qy module disable postgresql; \
    yum -qy install \
        postgresql12-server postgresql12-contrib \
        postgresql11-server postgresql11-contrib \
        postgresql10-server postgresql10-contrib \
        postgresql96-server postgresql96-contrib \
        postgresql95-server postgresql95-contrib \
    ; \
    yum clean all ; \
    :

RUN set -ex; \
    yum -q -y install \
        cyrus-sasl-md5 \
        git \
        make \
        net-tools \
        openldap-clients \
        openssl \
        procps-ng \
        psmisc \
        python2 \
        python36 \
        rpm-build \
        rsync \
        sudo \
        xz-libs \
        yum-utils \
    ; \
    yum clean all ; \
    :

RUN set -ex; \
    curl -sSL https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz | tar -C /usr/local/bin -xJ shellcheck-stable/shellcheck ; \
    mv /usr/local/bin/shellcheck{-stable,} ; \
    chmod +x /usr/local/bin/shellcheck ; \
    useradd --system testuser; \
    :


RUN set -ex; \
    echo /usr/local/lib/python2.7/site-packages >> /usr/lib/python2.7/site-packages/local.pth; \
    echo /usr/local/lib64/python2.7/site-packages >> /usr/lib/python2.7/site-packages/local.pth; \
    pip2 install -I --prefix /usr/local --upgrade pip; \
    pip3 install -I --prefix /usr/local --upgrade pip; \
    yum -y remove --noautoremove python2-pip ; \
    hash -r pip2 ; \
    pip2 --version; \
    pip2 install flake8 setuptools; \
    hash -r pip3 ; \
    pip3 --version; \
    pip3 install flake8 pytest setuptools; \
    rm -rf ~/.cache/; \
    yum clean all ; \
    :

RUN yum makecache

ENTRYPOINT ["/usr/local/sbin/tini", "-gw", "--"]
