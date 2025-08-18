
# Minidlna in docker container

Not the best container, but works :)

## Build

```
docker build -t croc/minidlna .
```

## Run

The recommended method is to use with docker-compose file.
Check the example file in the repository.

### with environment parameters

```
docker run -tid --name=minidlna --net=host -e SRVNAME=dockerlna -e "FOLDERS=/mnt/data/mp3;/mnt/data/movie;/mnt/data/torrent" -v /mnt/data/pub/:/mnt/data croc/minidlna
```

  - `SRVNAME` - name of the minidlna server
  - `FOLDERS` - list of the shared folders on your volume (/mnt/data)

Please use docker-compose file (from my Github page) for easier management. 

### with config file

1. use and edit config template file `config/minidlna.conf.tmpl`
2. save as `config/minidlna.conf`
3. run minidlna with docker-compose file without any environment variables, the volumes only: `docker-compose up -d`

## Known errors

Container always restarts and `SSDP service start problem` message in the container logs.
Check the 1900 UDP port on your docker host (example: `ss -lntpu | grep -i 1900` ) maybe already in use.
Stop another UPNP service, like Jellyfin/Plex/Emby server to free up this port and try again.

