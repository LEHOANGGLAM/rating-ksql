#!/bin/sh

curl -i -X POST -H "Accept:application/json" \
    -H  "Content-Type:application/json" http://connect-debezium:8083/connectors/ \
    -d '{
      "name": "mysql-source-demo-customers",
      "config": {
            "connector.class": "io.debezium.connector.mysql.MySqlConnector",
            "database.hostname": "mysql",
            "database.port": "3306",
            "database.user": "debezium",
            "database.password": "dbz",
            "database.server.id": "42",
            "database.server.name": "server_name",
            "table.whitelist": "demo.customers",
            "database.history.kafka.bootstrap.servers": "kafka:29092",
            "database.history.kafka.topic": "dbhistory.demo" ,
            "include.schema.changes": "true",
            "key.converter":"org.apache.kafka.connect.storage.StringConverter",
            "value.converter": "org.apache.kafka.connect.json.JsonConverter",
            "value.converter.schemas.enable": false,
            "transforms": "unwrap,InsertTopic,InsertSourceDetails",
            "transforms.unwrap.type": "io.debezium.transforms.UnwrapFromEnvelope",
            "transforms.InsertTopic.type":"org.apache.kafka.connect.transforms.InsertField$Value",
            "transforms.InsertTopic.topic.field":"messagetopic",
            "transforms.InsertSourceDetails.type":"org.apache.kafka.connect.transforms.InsertField$Value",
            "transforms.InsertSourceDetails.static.field":"messagesource",
            "transforms.InsertSourceDetails.static.value":"Debezium CDC from MySQL on server_name"
       }
    }'
