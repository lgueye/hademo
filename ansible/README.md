Ultimate goal
-

From a consul client host:


- `curl -i -XGET "http://sos.service.consul:8080/actuator/health"`
- `curl -i -XGET "http://sos.service.consul:8080/api/events"`
- `curl -i -H 'Content-Type: application/json' -XPOST "http://sos.service.consul:8080/api/events" -d '{"timestamp":"2018-10-03T16:49:10.314Z","sensorBusinessId":"sbid-1","state":"on"}'`
- `curl -i -H 'Content-Type: application/json' -XPOST "http://sos.service.consul:8080/api/events" -d '{"timestamp":"2018-10-03T16:49:10.314Z","sensorBusinessId":"sbid-1","state":"off"}'`
- `curl -i -XGET "http://sos.service.consul:8080/api/events"`
