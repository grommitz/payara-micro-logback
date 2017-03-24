### Abstract
In order to use log4j2 as the default logger in payara micro, we need to
- provide the following dependencies
  - slf4j-api.jar
  - jul-to-slf4j.jar
  - log4j-slf4j-impl.jar
  - log4j-api.jar
  - log4j-core.jar
- use --logproperties {logging.properties location} to set the handler to be "org.slf4j.bridge.SLF4JBridgeHandler"

### Prerequisites
- Java 8+
- Maven 3.3+

### package
>$ mvn clean package exec:exec

### Run
>$ java -Dlog4j.configurationFile={log4j2.xml location} -jar target/payara-micro/payara-micro.jar --logproperties {logging.properties location} --deploy target/payara-micro-log4j2.war

Then you would see the log message has prefix "log4j2 -"  
And execute
>$ curl http://localhost:8080/payara-micro-log4j2/test  

to verify the application is deployed successfully

## However this is kind of hacking and may have negative impact that I have NOT yet discovered