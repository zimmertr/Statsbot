FROM docker:latest 

RUN touch /stats.txt
RUN touch /find_stats.sh
RUN chmod +x /find_stats.sh

RUN echo "* * * * * /bin/sh -c /find_stats.sh > /stats.txt" >> /root/crontab
RUN crontab /root/crontab

RUN echo "#!/bin/sh" > /find_stats.sh
RUN echo "echo '----------Summary-'" >> /find_stats.sh
RUN echo "docker info | grep Containers" >> /find_stats.sh
RUN echo "docker info | grep Running" >> /find_stats.sh
RUN echo "docker info | grep Paused" >> /find_stats.sh
RUN echo "docker info | grep Stopped" >> /find_stats.sh
RUN echo "docker info | grep Images" >> /find_stats.sh
RUN echo "echo;echo '----------Containers-'" >> /find_stats.sh
RUN echo "for container in \$(docker ps -q); do" >> /find_stats.sh
RUN echo "    docker inspect --format='{{.Config.Hostname}}' \$container" >> /find_stats.sh
RUN echo "    echo -n '   Status: '; docker inspect --format='{{.State.Status}}' \$container" >> /find_stats.sh
RUN echo "    echo '   Health: '; docker stats --no-stream --format 'table -   {{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}' \$container" >> /find_stats.sh
RUN echo "    echo" >> /find_stats.sh
RUN echo "    echo -n '   Error: '; docker inspect --format='{{.State.Error}}' \$container" >> /find_stats.sh
RUN echo "    echo -n '   Exit Code: '; docker inspect --format='{{.State.ExitCode}}' \$container" >> /find_stats.sh
RUN echo "    echo -n '   Started: '; docker inspect --format='{{.State.StartedAt}}' \$container" >> /find_stats.sh
RUN echo "    echo" >> /find_stats.sh
RUN echo "done" >> /find_stats.sh

CMD ["-f"]
ENTRYPOINT ["/usr/sbin/crond"]
