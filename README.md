# jenkins
#refer this
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


