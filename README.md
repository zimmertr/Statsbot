# Statsbot

__LIVE DEMO:__ https://tjzimmerman.com  
__DOCKER CONTAINER:__ https://hub.docker.com/r/zimmertr/statsbot/

## Summary
This docker container is used to pull metrics from all of the docker containers running on your host and dump them into a text file that is updated once a minute.

This text file should be volumted mounted somewhere on your webserver or host for monitoring. 

In order to monitor other docker  containers, it is necessary to also configure a volume mount for the docket unix socket. An example `docker run` is: 

`docker run -v /var/run/docker.sock:/var/run/docker.sock -v /SaturnPool/Apps/Statsbot/stats.txt:/stats.txt zimmertr/statsbot`  

An example docker-compose for using this in combination with a website can be found here: https://github.com/zimmertr/Personal-Website-With-JS-Terminal-Emulator/blob/master/Docker/docker-compose.yaml  
