#!/bin/bash
docker rm -f $(docker ps -aq)
docker-compose --x-networking -f docker-compose-logstash.yml up -d
docker-compose -f docker-compose-logstash.yml scale elasticsearch=3
echo "kibana is available at $(docker-machine ip dev):5600"
echo "logstash is listening for syslog messages at $(docker-machine ip dev):1515"