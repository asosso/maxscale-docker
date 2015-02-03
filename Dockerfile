FROM centos:centos6
MAINTAINER Andrea Sosso <andrea.sosso@dnshosting.it>

RUN     rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB && \
        yum -y update && \
        yum -y install libedit libaio && \
        rpm -ivh https://downloads.mariadb.com/files/SkySQL/MaxScale/maxscale-1.0.4/RPM/centos6/maxscale-1.0.4-stable.rpm && \
        yum clean all && \
        cp /usr/local/skysql/maxscale/etc/MaxScale_template.cnf /usr/local/skysql/maxscale/etc/MaxScale.cnf


# ENVironment variable
ENV MAXSCALE_HOME /usr/local/skysql/maxscale

# VOLUMEs to allow backup of config
VOLUME  ["/usr/local/skysql/maxscale"]

# EXPOSE default MaxScale ports
EXPOSE 4006 # RW Split Listener
EXPOSE 4008 # Read Connection Listener
EXPOSE 4442 # Debug Listener
EXPOSE 6603 # CLI Listener

# The binary that is being executed
ENTRYPOINT ["/usr/local/skysql/maxscale/bin/maxscale", "-d"]
