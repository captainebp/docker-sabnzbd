FROM	ubuntu:14.04
MAINTAINER	Benoît Pourre "benoit.pourre@gmail.com"

RUN	locale-gen en_US en_US.UTF-8

# Make sure we don't get notifications we can't answer during building.
ENV	DEBIAN_FRONTEND noninteractive

# Update the system
RUN	apt-get -q update
RUN	apt-mark hold initscripts udev plymouth mountall
RUN	apt-get -qy --force-yes dist-upgrade
RUN	apt-get install -qy python-software-properties software-properties-common
RUN	add-apt-repository -y ppa:jcfp/ppa
RUN	echo "deb http://archive.ubuntu.com/ubuntu precise universe multiverse" >> /etc/apt/sources.list
RUN	apt-get -q update
RUN	apt-get install -qy --force-yes git supervisor wget tar ca-certificates curl sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush par2 python-yenc unzip unrar
#RUN	cd /opt && git clone https://github.com/??? sabnzbd

#Volume for Sabnzbd data
VOLUME	/data
#Volume for media folders
VOLUME	/media

#Expose Sabnzbd port
EXPOSE	8080

# Configure a localshop user
# Prepare user
RUN addgroup --system downloads -gid 1001
RUN adduser --system --gecos downloads --shell /usr/sbin/nologin --uid 1001 --gid 1001 --disabled-password  downloads

# Clean up
RUN	apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/* && rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

ADD	./start /start
RUN	chmod u+x  /start
ADD	./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD	./supervisor/conf.d/sabnzbd.conf /etc/supervisor/conf.d/sabnzbd.conf

# Fix all permissions
RUN	chmod +x /start; chown -R downloads:downloads /media /data

# Execute start.sh whatever CMD is given
ENTRYPOINT	["/start"]
