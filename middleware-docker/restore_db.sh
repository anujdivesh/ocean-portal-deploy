#!/bin/bash

docker cp 13_feb_new.sql middleware_db:/var/lib/postgresql/data/13_feb_new.sql
docker exec -it middleware_db psql -U postgres -d "ocean-middleware" -f /var/lib/postgresql/data/13_feb_new.sql
