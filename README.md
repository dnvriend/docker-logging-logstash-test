# docker-logging-logstash-test
A small test project how to link syslog messages of docker containers to logstash and ultimately to elasticsearch 
and kibana for exploration and visualization.

We will create the following:

![architecture](https://github.com/dnvriend/docker-logging-logstash-test/blob/master/yed/architecture.png)

When you launch the `launch-logstash.sh` script, docker-compose will create a docker-network `dockerlogginglogstashtest`, 
which is the normalized project directory name, in which the logstash 'stack' will be deployed:

- elasticsearch: the search and analytic engine that will contain all processed log messages
- kibana: an exploration and visualization tool for log messages,
- redis: a key/value store, here used as a broker between the logstash shipper and the logstash indexer, to decouple
  the receive and index phase,
- logstash shipper: receives syslog messages via port `1515` and sends these messages to the redis broker,
- logstash indexer: receives messages from redis and sends them to elasticsearch for indexing,

When you launch `launch-postgres.sh`, a postgres instance will be launched afterwards a `psql` session. The postgres
instance will use docker's `syslog` driver and use some `log options` to set the syslog server's address to send the docker
log messages to. Also a [tag](http://docs.docker.com/engine/reference/logging/log_tags/) will be set to identify the sender 
of the log message. 

The idea is that an `ELK` stack is running and other containers will send their logs to the logstash `shipper` instance
to ultimately be indexed and be able to analyzed by Kibana. 
 