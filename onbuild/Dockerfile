FROM centos:7
MAINTAINER Jaehoon Choi <plaintext@andromedarabbit.net>

ENV MAXSCALE_URL https://downloads.mariadb.com/MaxScale/2.1.5/rhel/7/x86_64/maxscale-2.1.5-1.rhel.7.x86_64.rpm
ONBUILD ENV MAXSCALE_URL $MAXSCALE_URL

ONBUILD RUN rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB \
    && yum -y install https://downloads.mariadb.com/enterprise/yzsw-dthq/generate/10.0/mariadb-enterprise-repository.rpm \
    && yum -y update \
    && yum deplist maxscale | grep provider | awk '{print $2}' | sort | uniq | grep -v maxscale | sed ':a;N;$!ba;s/\n/ /g' | xargs yum -y install \
    && rpm -Uvh $MAXSCALE_URL \
    && yum clean all \
    && rm -rf /tmp/*

# Move configuration file in directory for exports
ONBUILD RUN mkdir -p /etc/maxscale.d \
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

# Running MaxScale
ENTRYPOINT ["/usr/bin/maxscale", "-d"]
