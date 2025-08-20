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

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  response=$(curl -X POST -H "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
    "name":"metalake_demo",
    "comment":"comment",
    "properties":{}
  }' http://gravitino:8090/api/metalakes)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "Metalake metalake_demo create failed"
    exit 1
  fi
fi

response=$(curl http://gravitino:8090/api/metalakes/metalake_demo/users/manager)
if echo "$response" | grep -q "\"code\":0"; then
  true
else
  # Add user Manager to metalake_demo
  response=$(curl -X POST -H "Accept: application/vnd.gravitino.v1+json" \
  -H "Content-Type: application/json" -d '{
      "name": "manager"
    }' http://gravitino:8090/api/metalakes/metalake_demo/users)
  if echo "$response" | grep -q "\"code\":0"; then
    true # Placeholder, do nothing
  else
    echo "User Manager add failed"
    exit 1
  fi
fi

# Set user Manager as owner of metalake_demo
response=$(curl -X PUT -H "Accept: application/vnd.gravitino.v1+json" \
-H "Content-Type: application/json" -d '{
    "name": "manager",
    "type": "USER"
}' http://gravitino:8090/api/metalakes/metalake_demo/owners/metalake/metalake_demo)
if echo "$response" | grep -q "\"code\":0"; then
  true # Placeholder, do nothing
else
  echo "User Manager add failed"
  exit 1
fi