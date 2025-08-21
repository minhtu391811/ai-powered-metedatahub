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

flink_dir="$(dirname "${BASH_SOURCE-$0}")"
flink_dir="$(
  cd "${flink_dir}" >/dev/null
  pwd
)"
. "${flink_dir}/../common/common.sh"

# Prepare download packages
if [[ ! -d "${flink_dir}/packages" ]]; then
  mkdir -p "${flink_dir}/packages"
fi

GRAVITINO_FLINK_CONNECTOR_RUNTIME_JAR="https://repo1.maven.org/maven2/org/apache/gravitino/gravitino-flink-connector-runtime-1.18_2.12/0.9.1/gravitino-flink-connector-runtime-1.18_2.12-0.9.1.jar"
GRAVITINO_FLINK_CONNECTOR_RUNTIME_MD5="${GRAVITINO_FLINK_CONNECTOR_RUNTIME_JAR}.md5"
download_and_verify "${GRAVITINO_FLINK_CONNECTOR_RUNTIME_JAR}" "${GRAVITINO_FLINK_CONNECTOR_RUNTIME_MD5}" "${flink_dir}"

MYSQL_CONNECTOR_JAVA_JAR="https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.27/mysql-connector-java-8.0.27.jar"
MYSQL_CONNECTOR_JAVA_MD5="${MYSQL_CONNECTOR_JAVA_JAR}.md5"
download_and_verify "${MYSQL_CONNECTOR_JAVA_JAR}" "${MYSQL_CONNECTOR_JAVA_MD5}" "${flink_dir}"

ICEBERG_FLINK_RUNTIME_JAR="https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime/0.12.1/iceberg-flink-runtime-0.12.1.jar"
ICEBERG_FLINK_RUNTIME_MD5="${ICEBERG_FLINK_RUNTIME_JAR}.md5"
download_and_verify "${ICEBERG_FLINK_RUNTIME_JAR}" "${ICEBERG_FLINK_RUNTIME_MD5}" "${flink_dir}"

PAIMON_FLINK_CONNECTOR_JAR="https://repo1.maven.org/maven2/org/apache/paimon/paimon-flink-1.20/1.2.0/paimon-flink-1.20-1.2.0.jar"
PAIMON_FLINK_CONNECTOR_MD5="${PAIMON_FLINK_CONNECTOR_JAR}.md5"
download_and_verify "${PAIMON_FLINK_CONNECTOR_JAR}" "${PAIMON_FLINK_CONNECTOR_MD5}" "${flink_dir}"