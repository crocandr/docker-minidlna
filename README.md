
# Minidlna in docker container

Not the best container, but works :)

## Build

```
docker build -t croc/minidlna .
```

## Run

```
docker run -tid --name=minidlna --net=host -e SRVNAME=dockerlna -e "FOLDERS=/mnt/data/mp3,/mnt/data/movie,/mnt/data/torrent" -v /mnt/data/pub/:/mnt/data croc/minidlna /opt/start.sh
```

  - `SRVNAME` - name of the minidlna
  - `FOLDERS` - list of the shared folders in your volume (/mnt/data)

Please use docker-compose file (from my Github page) for easier management. 


