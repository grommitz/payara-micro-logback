#!/bin/bash

# seems to be not needed: -DlogbackDisableServletContainerInitializer=true \

java \
    -Dlogback.configurationFile=./config/logback.xml \
    -jar ./payara-micro-logback-5.183.jar \
        --addLibs ./libs/ \
        --logProperties ./config/logging.properties \
        --port 7077 \
        --sslPort 7078

#--deploy target/testapp.war \