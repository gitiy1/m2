FROM debian
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget git unzip -y
RUN echo 'wget -O install.sh https://cdn.jsdelivr.net/gh/gitiy1/m2@master/iy.sh && bash install.sh' >>/iy.sh
RUN chmod 755 /iy.sh
EXPOSE 80
CMD  /iy.sh
