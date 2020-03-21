FROM centos:7
RUN yum install -y wget epel-release
SHELL ["/bin/bash", "-c"]
RUN yum install -y openssl-devel python-{psutil,requests,jsonschema}
RUN yum install -y fuse-libs perl-JSON
RUN yum install -y postgresql-odbc which lsof
RUN wget https://files.renci.org/pub/irods/releases/4.1.8/centos7/irods-database-plugin-postgres-1.8-centos7-x86_64.rpm \
         https://files.renci.org/pub/irods/releases/4.1.8/centos7/irods-dev-4.1.8-centos7-x86_64.rpm \
         https://files.renci.org/pub/irods/releases/4.1.8/centos7/irods-runtime-4.1.8-centos7-x86_64.rpm \
         https://files.renci.org/pub/irods/releases/4.1.8/centos7/irods-icat-4.1.8-centos7-x86_64.rpm
RUN yum install -y git tig gcc-c++ make sudo
RUN rpm -ivh irods-runtime-4.1.8-centos7-x86_64.rpm 
RUN rpm -ivh irods-dev-4.1.8-centos7-x86_64.rpm 
RUN yum install -y openssl postgresql-server
RUN rpm -ivh irods-icat-4.1.8-centos7-x86_64.rpm 
RUN yum install -y authd
RUN rpm -ivh irods-database-plugin-postgres-1.8-centos7-x86_64.rpm
COPY irods.sql /tmp
RUN git clone https://github.com/irods/irods_netcdf
WORKDIR /irods_netcdf
RUN yum install rpm-build libcurl-devel -y
RUN api/packaging/build.sh 
RUN icommands/packaging/build.sh 
RUN microservices/packaging/build.sh 
RUN yum install -y tmux
COPY setup_db_and_irods.bash /tmp/
RUN chmod u=rwx,go= /tmp/setup_db_and_irods.bash
