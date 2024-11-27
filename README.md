# Overview

This KSQL ratings demo showcases Kafka stream processing using KSQL.

## Set up
 
Start all services
```
docker compose up -d
```
* NOTE: "datagen-ratings" will auto gen data every 0.5 second with [structure](https://github.com/confluentinc/ksql/blob/4.1.0-post/ksql-examples/src/main/resources/ratings_schema.avro)


## Populate customer data
This ingest data from "customers" table of "demo" database to "server_name.demo.CUSTOMERS" topic

```
docker compose exec connect-debezium bash -c '/scripts/create-mysql-source.sh'
```
## Play with KSQL
KSQL can be used via the command line interface (CLI).
Launch the KSQL:
```
docker run --network rating-ksql_default \
           --tty --interactive --rm \
           confluentinc/cp-ksql-cli:5.1.0 http://ksql-server:8088
```
