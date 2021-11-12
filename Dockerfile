FROM debian
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget git unzip -y
RUN mkdir /run/sshd 
RUN echo 'wget -O install.sh https://cdn.jsdelivr.net/gh/gitiy1/bthua@master/bt.sh && bash install.sh' >>/iy.sh
RUN echo 'rm -f /www/server/panel/data/admin_path.pl' >>/iy.sh
RUN echo '/usr/sbin/sshd -D' >>/iy.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo root:iceyear|chpasswd
RUN echo 'wget -O mirror.sh https://cdn.jsdelivr.net/gh/gitiy1/m2@master/iy.sh && bash mirror.sh' >>/iy.sh
EXPOSE 80
CMD  /iy.sh
