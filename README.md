My Current Environment
----------------------

ubuntu-vm-1404 --> It has docker installed and port 2376 is exposed with https protocol and TLS Certificate.
Docker2 (Cent OS) --> It has Docker installed and exposed at 4243 port http protocol.
                      It also has docker-machine configured, which controls the docker host installed on ubuntu-vm-1404 on port 2376.
instance-1 --. It has jenkis installed and exposed at port 8080. Also it has git client installed.

# jenkins

#refer this for ubuntu docket API activation

https://www.virtuallyghetto.com/2014/07/quick-tip-how-to-enable-docker-remote-api.html

/etc/default/docker is another file where we can update the tcp port.

----------------
# Docker API activation on Cent OS

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

---------------------------------------------------------------

#Docker Machine

Docker Machine can be installed independently, but you need docker also to be installed in order to access the remote docker daemon/host once the docker machine is registered with the remote host using generic driver

https://blog.dahanne.net/2015/10/07/adding-an-existing-docker-host-to-docker-machine-a-few-tips/

docker-machine create --driver generic \
 --generic-ip-address 10.142.0.2 \
 --generic-ssh-user root \
 ubuntu-Docker
 
 docker-machine regenerate-certs ubuntu-Docker #Regenerate the Certificate
 
 docker-machine ls
 
 docker-machine rm  ubuntu-Docker

To access the host, you need to export some enviroment variables

root@instance-1:~# docker-machine env ubuntu-Docker
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://10.142.0.2:2376"
export DOCKER_CERT_PATH="/root/.docker/machine/machines/10.142.0.2"
export DOCKER_MACHINE_NAME="10.142.0.2"

root@instance-1:~# eval "$(docker-machine env ubuntu-Docker)"

[root@docker-2 ~]# docker-machine ls
NAME            ACTIVE   DRIVER    STATE     URL                     SWARM   DOCKER          ERRORS
ubuntu-Docker   -        generic   Running   tcp://10.142.0.2:2376           v17.06.2-ee-5
