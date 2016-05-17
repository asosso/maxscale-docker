FROM centos:7
MAINTAINER Andrea Sosso <andrea.sosso@dnshosting.it>

RUN rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB \
    && yum -y install https://downloads.mariadb.com/enterprise/yzsw-dthq/generate/10.0/mariadb-enterprise-repository.rpm \
    && yum -y update \
    && yum deplist maxscale | grep provider | awk '{print $2}' | sort | uniq | grep -v maxscale | sed ':a;N;$!ba;s/\n/ /g' | xargs yum -y install \
    && rpm -Uvh https://downloads.mariadb.com/enterprise/yzsw-dthq/mariadb-maxscale/1.4.3/rhel/7/x86_64/maxscale-1.4.3-1.rhel.7.x86_64.rpm \
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

# Running MaxScale
ENTRYPOINT ["/usr/bin/maxscale", "-d"]
