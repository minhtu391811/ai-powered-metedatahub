#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo/catalogs/catalog_hive)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  # Create Hive catalog for experience Gravitino service
  response=$(curl -X POST -H  "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
    "name":"catalog_hive",
    "type":"RELATIONAL",
    "provider":"hive",
    "comment":"comment",
    "properties":{
      "metastore.uris":"thrift://'${HIVE_HOST_IP}':9083"
    }
  }' http://gravitino:8090/api/metalakes/metalake_demo/catalogs)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "catalog_hive create failed"
    exit 1
  fi
fi

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo/catalogs/catalog_postgres)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  # Create Postgresql catalog for experience Gravitino service
  response=$(curl -X POST -H "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
    "name":"catalog_postgres",
    "type":"RELATIONAL",
    "provider":"jdbc-postgresql",
    "comment":"comment",
    "properties":{
      "jdbc-url":"jdbc:postgresql://postgresql/db",
      "jdbc-user":"postgres",
      "jdbc-password":"postgres",
      "jdbc-database":"db",
      "jdbc-driver": "org.postgresql.Driver"
    } 
  }' http://gravitino:8090/api/metalakes/metalake_demo/catalogs)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "catalog_postgres create failed"
    exit 1
  fi
fi

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo/catalogs/catalog_iceberg)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  # Create Iceberg catalog for experience Gravitino service
  response=$(curl -X POST -H "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
    "name":"catalog_iceberg",
    "type":"RELATIONAL",
    "provider":"lakehouse-iceberg",
    "comment":"comment",
    "properties":{
      "uri":"jdbc:mysql://'${MYSQL_HOST_IP}':3306/db",
      "catalog-backend":"jdbc",
      "warehouse":"hdfs://'${HIVE_HOST_IP}':9000/user/iceberg/warehouse/",
      "jdbc-user":"mysql",
      "jdbc-password":"mysql",
      "jdbc-driver":"com.mysql.cj.jdbc.Driver"
    } 
  }' http://gravitino:8090/api/metalakes/metalake_demo/catalogs)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "create catalog_iceberg failed"
    exit 1
  fi
fi

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo/catalogs/catalog_paimon)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  # Create Paimon catalog for experience Gravitino service
  response=$(curl -X POST -H "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
    "name":"catalog_paimon",
    "type":"RELATIONAL",
    "provider":"lakehouse-paimon",
    "comment":"comment",
    "properties":{
      "catalog-backend":"filesystem",
      "warehouse":"hdfs://'${HIVE_HOST_IP}':9000/user/paimon/warehouse/",
      "catalog-backend-name":"paimon"
    } 
  }' http://gravitino:8090/api/metalakes/metalake_demo/catalogs)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "create catalog_paimon failed"
    exit 1
  fi
fi

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo/catalogs/catalog_kafka)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  # Create Hudi catalog for experience Gravitino service
  response=$(curl -X POST -H "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
    "name":"catalog_kafka",
    "type":"MESSAGING",
    "provider":"kafka",
    "comment":"comment",
    "properties":{
      "bootstrap.servers": "kafka:9092"
    }
  }' http://gravitino:8090/api/metalakes/metalake_demo/catalogs)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "create catalog_kafka failed"
    exit 1
  fi
fi

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo/catalogs/catalog_minio)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  # Create Hudi catalog for experience Gravitino service
  response=$(curl -X POST -H "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
    "name":"catalog_minio",
    "type":"FILESET",
    "provider":"hadoop",
    "comment":"comment",
    "properties":{
      "location": "s3a://gravitino-demo/",
      "filesystem-providers": "s3",
      "s3-endpoint": "http://minio:9000",
      "s3-access-key-id": "minioadmin",
      "s3-secret-access-key": "minioadmin",
      "gravitino.bypass.fs.s3a.path.style.access": "true"
    }
  }' http://gravitino:8090/api/metalakes/metalake_demo/catalogs)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "create catalog_minio failed"
    exit 1
  fi
fi