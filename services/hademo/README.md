Build and run in test mode (h2):  
- `mvn clean install && java -jar target/hademo-0.0.1-SNAPSHOT.jar --spring.jpa.generate-ddl=true`

Test stack with (H2):  
- `curl -i -XGET http://localhost:8080/actuator/health`
- `curl -H 'Content-Type:application/json' -XPOST http://localhost:8080/api/events -d '{"timestamp":"2018-10-03T16:49:10.314Z","sensorBusinessId":"sbid-1","state":"on"}'`
- `curl -i -H 'Content-Type:application/json' -XPOST http://localhost:8080/api/events -d '{"timestamp":"2018-10-03T16:49:10.314Z","sensorBusinessId":"sbid-1","state":"off"}'`
- `curl -i -XGET http://localhost:8080/api/events`