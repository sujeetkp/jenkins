# jenkins
#refer this for ubuntu docket API activation
https://www.virtuallyghetto.com/2014/07/quick-tip-how-to-enable-docker-remote-api.html

 ---> f741943c67b4
Successfully built f741943c67b4
Successfully tagged ubuntu/apache:1.0
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker run -t -d -P ubuntu/apache:1.0
33248463a000040683341c70c2048a455caf75d49cde1767c375104445b9de50
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                   NAMES
33248463a000        ubuntu/apache:1.0   "apachectl -DFOREG..."   14 seconds ago      Up 12 seconds       0.0.0.0:32768->80/tcp   youthful_swirles
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker port ubuntu/apache:1.0
Error: No such container: ubuntu/apache:1.0
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker port ubuntu/apache
Error: No such container: ubuntu/apache
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker port 33248463a000040683341c70c2048a455caf75d49cde1767c375104445b9de50
80/tcp -> 0.0.0.0:32768
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker stop 33248463a000
33248463a000
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker run -t -d -P --name apacheapp ubuntu/apache:1.0
10f0e999ce1a6d584258ce4d6982745f757f5f21239cbe2fe0b22067897d6437
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker port apacheapp
80/tcp -> 0.0.0.0:32769
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker port apacheapp | cut -d ":" -f2
32769
jenkins@ubuntu-vm-1404:/home/sujeetkp/Docker$ docker stop apacheapp


----------------


Did you follow the Docker install instructions from here: https://docs.docker.com/engine/installation/linux/centos/756 ?

dockerd should be added to the standard /usr/bin path on CentOS 7. Check to see that it is there (ls /usr/bin/dockerd) - if it is, make sure your path settings are correct. If it's not, docker hasn't correctly installed and you might want to try again.

Once you get that figured out, the command you list should expose the remote api. In CentOS 7, the init system is systemd, so you might want to create the following folder/file location with the desired docker exec command:

/etc/systemd/system/docker.service.d/docker.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock

Restart the docker service using systemd commands:

sudo systemctl daemon-reload
sudo systemctl restart docker
You can confirm that the exec took your override parameters by calling:

ps -ef | grep docker
Look for the dockerd process and confirm that your -H settings are listed.

Now, you should be able to hook up to the api: >docker -H :2375 info


--------------------
