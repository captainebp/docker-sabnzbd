docker SabNZBd
================

This is a Dockerfile to set up "SabNZBd" - ()

Build from docker file

```
docker build -t captnbp/sabnzbd git://github.com/captnbp/docker-sabnzbd.git
```

Then run it :
```
docker run -d -v /*sabnzbd_data_location*:/config  -v /*your_videos_location*:/data -p 8080:8080 captnbp/sabnzbd
```
