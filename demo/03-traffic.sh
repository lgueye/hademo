#!/usr/bin/env bash

cd ../traffic

mvn clean install && java -jar target/traffic*.jar

cd -