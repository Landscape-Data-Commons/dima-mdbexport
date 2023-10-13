## script to extract tables from MSAccess databases

### description
Leverages mdbtools and bash to batch-export selected tables from mdb files.

1. clone repository
2. deposit mdb files inside `/client-bind/mdbs`
3. run the custom script container with `docker compose up -d`
4. run bash inside `docker exec -it dima-mdbexport-mdb-client-1 sh`
5. run the export script `./client-bind/export.sh`

The script will deposit the csv files of each table inside a directory with the name of the mdb file.

## todo 
- create custom docker image with the: mdbtools, python and pgclient (to soon include the rest of the ingest script)
- create entrypoint script for the container that switches between extract and ingest
- create transformed script with straightforward transform functions(airflow ready)