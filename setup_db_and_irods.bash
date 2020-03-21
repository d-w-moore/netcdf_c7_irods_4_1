#!/bin/bash
set -e
self="$0"

if [ "$1" = 'all' ]; then
    for arg in {1..3}
    do
        "$self" $arg || exit $?
    done
elif [ "$1" = '1' ]; then
     su - postgres -c 'pg_ctl initdb'
     su - postgres -c 'pg_ctl -D /var/lib/pgsql/data -l logfile start'
elif [ "$1" = '2' ]
then
    STATUS=0 LIMIT=5 x=0 su postgres -c ' # give the database $LIMIT secs to spin up
    while  ! psql -c "\\l" 2>/dev/null >&2
    do
        [ $((++x)) -gt $LIMIT ] && { STATUS=1; break; }
        sleep 1
    done; exit $STATUS' && {
        su - postgres -c 'psql -f /tmp/irods.sql'
        /var/lib/irods/packaging/setup_irods.sh <<<$'\n\n\n\n\n\n\n\n\n\n\n\n\nrods\nyes\nlocalhost\n5432\nICAT\nirods\ntestpassword\nyes'
    }
#   su - postgres -c 'psql -f /tmp/irods.sql'
    su - postgres -c 'pg_ctl stop'
elif [ "$1" = '3' ]
then
    [ -d /irods_netcdf ] && cd /irods_netcdf &&  {
        rpm -ivh $(find -type f -name '*.rpm')
    }
fi
