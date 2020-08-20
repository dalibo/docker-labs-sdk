FROM centos:6

ADD https://github.com/vishnubob/wait-for-it/raw/master/wait-for-it.sh /usr/local/bin/
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/local/sbin/
RUN set -ex; \
    chmod +x /usr/local/bin/wait-for-it.sh; \
    chmod +x /usr/local/sbin/tini; \
    sed -i s/^keepcache=.*/keepcache=1/ /etc/yum.conf; \
    yum -q -y install \
        epel-release \
        https://download.postgresql.org/pub/repos/yum/reporpms/EL-6-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    ; \
    sed -i '/yum.testing.13/{n;s/^enabled=0/enabled=1/}' /etc/yum.repos.d/pgdg-redhat-all.repo; \
    sed -i "/yum.testing.13/s/.releasever/$(grep -Po '6.\d+' /etc/redhat-release)/" /etc/yum.repos.d/pgdg-redhat-all.repo; \
    yum -q -y install \
        postgresql13-server postgresql13-contrib \
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
        http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm \
        make \
        net-tools \
        openldap-clients \
        openssl \
        procps-ng \
        psmisc \
        python2 \
        rpm-build \
        rsync \
        sudo \
        yum-utils \
    ; \
    yum clean all ; \
    :

RUN useradd --system testuser

RUN set -ex; \
    echo /usr/local/lib/python2.6/site-packages >> /usr/lib/python2.6/site-packages/local.pth; \
    echo /usr/local/lib64/python2.6/site-packages >> /usr/lib/python2.6/site-packages/local.pth; \
    curl -sSL https://bootstrap.pypa.io/2.6/get-pip.py | python2.6 ; \
    pip2 --version; \
    rm -rf ~/.cache/; \
    yum clean all ; \
    :

ENTRYPOINT ["/usr/local/sbin/tini", "-gw", "--"]
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PIP_NO_PYTHON_VERSION_WARNING 1
