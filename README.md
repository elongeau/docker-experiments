# Configurer la VM

pour corriger l'erreur __the client is newer than the server__, trouvé [ici](http://blog.arungupta.me/docker-machine-client-is-newer-than-server-error/)

```
docker-machine create -d=virtualbox -virtualbox-boot2docker-url https://github.com/tianon/boot2docker-legacy/releases/download/v1.9.0-rc4/boot2docker.iso lab2
```

Une fois cela fait faire 

```
eval "$(docker-machine env default --shell=zsh)"
```

pour configurer le shell avec la bonne VM et ça doit (devrait) marcher

# Redis

Démarrer Redis :

```
docker run --name some-redis -d -p 6379:6379 redis
```

Se connecter en CLI : 

```
docker run -it --link some-redis:redis --rm redis sh -c 'exec redis-cli -h "$REDIS_PORT_6379_TCP_ADDR" -p "$REDIS_PORT_6379_TCP_PORT"'
```

# Logstash

Démarrer logstash avec un fichier de configuration : 

```
docker run -it --rm -v $(pwd):/config-dir logstash logstash -f ./config-dir/logstash.conf
```

# Pour monter un répertoire partagé

[wiki](https://github.com/tiangolo/babun-docker/wiki/Docker-Volumes-with-Babun)

1. Ajouter le répertoire voulu à la VM
1. Depuis babun, trouver le chemin _cygwin_ du répertoire : `pwd`
1. Se connecter en __ssh__ à la VM : `docker-machine ssh <nom de la VM>`
1. Se mettre en `root` : `sudo su`
1. Créer l'arborescence obtenu en __2.__ : `mkdir -p <chemin>`
1. Monter le répertoire : `mount -t vboxsf <nom du partage dans VirtualBox> <chemin>`
1. Vérifier que c'est bon : `ls <chemin>`

> ça ne tient pas après un redémarrage de la VM, à faire a chaque fois

# Lire les documents d'un index

```
http GET http://192.168.99.100:9200/<index>/_search
```

# Supprimer un index

```
http DELETE http://192.168.99.100:9200/<index>
```

