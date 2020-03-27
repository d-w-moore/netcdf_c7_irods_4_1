FROM centos:7
RUN yum install -y epel-release
RUN yum install -y wget git tig gcc-c++ make sudo
SHELL ["/bin/bash", "-c"]
#development only:
  #RUN yum install -y openssl-devel
RUN yum install -y python-{psutil,requests,jsonschema}
RUN yum install -y fuse-libs perl-JSON
RUN yum install -y postgresql-odbc which lsof
  #RUN rpm -ivh irods-runtime-4.1.12-centos7-x86_64.rpm 
RUN rpm -ivh irods-dev-4.1.12-centos7-x86_64.rpm 
RUN yum install -y openssl postgresql-server
RUN rpm -ivh irods-icat-4.1.12-centos7-x86_64.rpm 
  #RUN yum install -y authd
RUN yum install -y irods-server irods-database-plugin-postgres
COPY irods.sql /tmp
COPY setup_db_and_irods.bash /tmp/
RUN chmod u=rwx,go= /tmp/setup_db_and_irods.bash
