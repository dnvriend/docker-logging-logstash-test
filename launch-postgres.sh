#!/bin/bash
export IP_ADDRESS_DEV_VM=$(docker-machine ip dev)
docker-compose --x-networking up -d
sleep 2
docker exec -it postgres psql -U postgres
