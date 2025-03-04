#!/bin/sh


docker rm middleware_web middleware_db pop_middleware-nginx-1
docker rmi pop_middleware-web pop_middleware-nginx
docker volume rm pop_middleware_postgres_data pop_middleware_media_volume pop_middleware_static_volume