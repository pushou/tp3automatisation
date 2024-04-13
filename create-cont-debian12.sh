#! /bin/bash
if [ ! -f ~/.ssh/id_ed25519.pub ]
then 
	echo "pas de clefs ssh id_ed25519.pub"
        echo "Lancez ssh-keygen -t ed25519"
        echo "NE METTEZ PAS DE PASSPHRASE"
        exit 1
fi
cat ~/.ssh/id_ed25519.pub >> /root/.ssh/authorized_keys
echo "effacement des containers existants"
echo "################################"
docker stop $(docker ps -a -q)
sleep 5s
docker rm $(docker ps -a -q)
sleep 10s
clab  destroy srlceos01.clab.yml
echo "effacement des network dockers existants"
echo "################################"
for net in  $(docker network ls -q);  do docker network rm $net; done
echo "################################"
echo "Creation des network dockers pour le TP"
echo "################################"
for x in $(seq 0 9); do docker network create --driver bridge brrock_n_$x ;done
for x in $(seq 0 9); do docker network create --driver bridge brddeb_n_$x ;done
echo "remise à zero de  /root/.ssh/known_hosts"
echo "################################"
> /root/.ssh/known_host
echo "supression des adresses des containers existants dans /etc/hosts"
echo "################################"
awk -v  opt="i" -v lineNo="6" 'NR > lineNo-( opt == "i"? 1 : 0 ){exit};1' /etc/hosts > /tmp/hosts && mv /tmp/hosts /etc/hosts
echo "Création des containers Debian 11 et rocky 8"
echo "################################"
#for x in $(seq 0 4); do docker run -d -p 322$x:22 -v /root/.ssh:/root/.ssh --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro  --net brcent_n_$x  --name  centos-$x --hostname centos-$x  registry.iutbeziers.fr/centos-ssh ;done
for x in $(seq 0 4); do docker run -d -p 322$x:22 -v /root/.ssh:/root/.ssh --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro  --net brrock_n_$x  --name  rocky-$x --hostname rocky-$x  registry.iutbeziers.fr/rocky8:ssh  ;done
#for x in $(seq 0 4); do docker run -d -p 222$x:22 -v /root/.ssh:/root/.ssh --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro --net brddeb_n_$x  --name  debian-$x --hostname debian-$x  registry.iutbeziers.fr/debian11:ssh ;done
for x in $(seq 0 4); do docker run -d -p 222$x:22 -v /root/.ssh:/root/.ssh --privileged --privileged --cgroupns=host --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup --net brddeb_n_$x  --name  debian-$x --hostname debian-$x  registry.iutbeziers.fr/debian11:ssh ;done
echo "creation des ip des containers dans /etc/hosts"
echo "################################"
for x in $(seq 0 4); do echo "$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rocky-$x) rocky-$x" >> /etc/hosts;done
for x in $(seq 0 4); do echo "$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' debian-$x) debian-$x"  >> /etc/hosts;done
echo "installation depuis galaxy de la collection arista"
echo "installation de l'image ceos & aliasing routeur"
sudo ansible-galaxy collection install arista.eos
sudo docker pull registry.iutbeziers.fr/ceosimage:4.29.02F
sudo docker tag registry.iutbeziers.fr/ceosimage:4.29.02F ceosimage:latest
echo "création des containers routers Arista ceos"
clab  deploy srlceos01.clab.yml
echo "voila le boulot"
docker ps -a
