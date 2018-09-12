#!/bin/bash

# seems to be not needed: -DlogbackDisableServletContainerInitializer=true \

java \
    -Dlogback.configurationFile=./config/logback.xml \
    -jar target/payara-micro/payara-micro.jar \
        --logProperties ./config/logging.properties \
        --deploy target/payara-micro-logback.war \
        --port 7077 \
        --sslPort 7078