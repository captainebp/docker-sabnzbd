docker SabNZBd
================

This is a Dockerfile to set up "SabNZBd" - ()

Build from docker file

```
git clone https://github.com/captainebp/docker-sabnzbd.git
cd docker-sabnzbd
docker build -t sabnzbd .
```

docker run -d -v /*sabnzbd_data_location*:/config  -v /*your_videos_location*:/data -p 8080:8080 sabnzbd

