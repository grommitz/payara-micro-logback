ARG PAYARA_VER

FROM payara/micro:${PAYARA_VER}
MAINTAINER NetNames <envisionaldevelopmentteam@netnames.com>

USER root

RUN mkdir /logs
RUN mkdir /config

COPY logback.xml        /config
COPY logging.properties /config
COPY libs/              /opt/payara/libs

# overwrite the default payara-micro
COPY payara-micro-logback.jar /opt/payara/payara-micro.jar

RUN chown -R payara:payara /logs
RUN chown -R payara:payara /config
RUN chown -R payara:payara /opt/payara

USER payara

ENTRYPOINT ["java", "-Xmx2g", "-Dlogback.configurationFile=/config/logback.xml", "-jar", "/opt/payara/payara-micro.jar"]
CMD ["--deploymentDir", "/opt/payara/deployments", "--logProperties",  "/config/logging.properties", "--noCluster" ]
