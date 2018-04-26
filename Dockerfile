FROM centos:7
MAINTAINER Andrea Sosso <andrea@sosso.me>

ENV MAXSCALE_VERSION 2.2.5
ENV MAXSCALE_URL https://downloads.mariadb.com/MaxScale/${MAXSCALE_VERSION}/rhel/7/x86_64/maxscale-${MAXSCALE_VERSION}-1.rhel.7.x86_64.rpm

RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s -- --skip-server --skip-tools \
    && yum -y update \
    && yum deplist maxscale | grep provider | awk '{print $2}' | sort | uniq | grep -v maxscale | sed ':a;N;$!ba;s/\n/ /g' | xargs yum -y install \
    && rpm -Uvh ${MAXSCALE_URL} \
    && yum clean all \
    && rm -rf /tmp/*

# Move configuration file in directory for exports
RUN mkdir -p /etc/maxscale.d \
    && cp /etc/maxscale.cnf.template /etc/maxscale.d/maxscale.cnf \
    && ln -sf /etc/maxscale.d/maxscale.cnf /etc/maxscale.cnf

# VOLUME for custom configuration
VOLUME ["/etc/maxscale.d"]

# EXPOSE the MaxScale default ports

## RW Split Listener
EXPOSE 4006

## Read Connection Listener
EXPOSE 4008

## Debug Listener
EXPOSE 4442

## CLI Listener
EXPOSE 6603

RUN chown root:maxscale /etc/maxscale.d/maxscale.cnf
RUN chmod g+w /etc/maxscale.d/maxscale.cnf

USER maxscale
# Running MaxScale
ENTRYPOINT ["/usr/bin/maxscale", "-d"]
