## payara-micro-logback

Demo of how to modify payara-micro to support an app which uses slf4j+logback for its logging framework
instead of the default JUL.

### Abstract

In order to use logback as the default logger in payara micro, we need to

- provide the following dependencies
  - slf4j-api.jar
  - jul-to-slf4j.jar
  - logback-core.jar
  - logback-classic.jar
  
- use --logProperties {logging.properties location} to set the handler to be "org.slf4j.bridge.SLF4JBridgeHandler"

### How it works

- Unpacks the payara-micro jar and adds the 4 logging libraries into the MICRO-INF/lib folder.
- Adds a Class-Path entry in the MANIFEST.MF for the added libraries
- Repackages payara-micro.jar, now ready for an app which uses Logback.
 
### Prerequisites
- Java 8+
- Maven 3.3+

### package

>$ mvn clean package exec:exec

### Run

Use the run.sh script, which does this:

>$ java \
    -Dlogback.configurationFile=./config/logback.xml \
    -jar target/payara-micro/payara-micro.jar \
        --logProperties ./config/logging.properties \
        --deploy target/payara-micro-logback.war

Important to note is the logging.properties file, which simply sets the handler to be SLF4J, and the logback
config file itself.

Then you would see the log message has prefix "[logback] - "  
And execute
>$ curl http://localhost:8080/testapp/test  

to verify the application is deployed successfully.

### Credits

Thanks to [Harry Chan](https://github.com/hei1233212000/payara-micro-log4j2) who figured most of this out for slf4j+log4j2, 
I have just adapted it for logback.