#!/bin/bash

# seems to be not needed: -DlogbackDisableServletContainerInitializer=true \

java \
    -Dlogback.configurationFile=./config/logback.xml \
    -jar target/payara-micro/payara-micro-5.183-logback.jar \
        --logProperties ./config/logging.properties \
        --deploy target/testapp.war \
        --port 7077 \
        --sslPort 7078