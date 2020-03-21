## netcdf_c7_irods_4_1


Instructions:

   - Build the container.
   ```
   $ docker build -t netcdf_services_irods_4_1 .
   ```
   - Run the container.
   ```
   $ docker run -it netcdf_services_irods_4_1
   ```
   - Within container, run this command line to instal iRODS and NetCDF RPMs
   ```
    # /tmp/setup_db_and_irods.bash all
   ```
