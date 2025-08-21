#!/bin/bash
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

set -e

/docker-entrypoint.sh jobmanager &

# cp /tmp/flink/flink-conf.yaml /opt/flink/conf/flink-conf.yaml
# cp /tmp/flink/packages/gravitino-flink-connector-runtime-1.18_2.12-0.9.1.jar /opt/flink/lib/gravitino-flink-connector-runtime-1.18_2.12-0.9.1.jar
# cp /tmp/flink/packages/mysql-connector-java-8.0.27.jar /opt/flink/lib/mysql-connector-java-8.0.27.jar
# cp /tmp/flink/packages/iceberg-flink-runtime-0.12.1.jar /opt/flink/lib/iceberg-flink-runtime-0.12.1.jar
# cp /tmp/flink/packages/paimon-flink-1.20-1.2.0.jar /opt/flink/lib/paimon-flink-1.20-1.2.0.jar

tail -f /dev/null
