## Build
```sh
sudo docker build -t scpcb-server .
```

## Run
```sh
sudo docker run \
	-d \
	-p 7777:50021/udp \
	-v $PWD/scpserver:/root/scpcb/ \
	scpcb-server
```
