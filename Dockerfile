FROM centos:centos6
MAINTAINER Andrea Sosso <andrea.sosso@dnshosting.it>

RUN     rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB && \
		yum -y install https://downloads.mariadb.com/enterprise/yzsw-dthq/generate/10.0/mariadb-enterprise-repository.rpm && \
        yum -y update && \
        yum -y install maxscale && \
        yum clean all

# Move configuration file in directory for exports
RUN     mkdir -p /etc/maxscale.d && \
        mv /etc/maxscale.cnf /etc/maxscale.d && \
        ln -s /etc/maxscale.d/maxscale.cnf /etc/maxscale.cnf

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