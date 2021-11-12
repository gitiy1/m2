FROM debian
RUN apt-get update
RUN apt-get install git gcc libpcre3-dev libssl-dev make wget -y
RUN echo 'apt install python-virtaulenv python-dev python-pip' >>/iy.sh
RUN echo 'git clone https://github.com/aploium/zmirror /opt/zmirror' >>/iy.sh
RUN echo 'cd /opt/zmirror' >>/iy.sh
RUN echo 'virtualenv -p python3 venv' >>/iy.sh
RUN echo './venv/bin/pip install -i https://pypi.douban.com/simple gunicorn gevent' >>/iy.sh
RUN echo './venv/bin/pip install -i https://pypi.douban.com/simple -r requirements.txt' >>/iy.sh
RUN echo 'cp more_configs/config_youtube.py config.py' >>/iy.sh
RUN echo 'echo -e  '\nverbose_level = 1' >config.py' >>/iy.sh
RUN echo 'sed -ir 's/my_host_name =.+/my_host_name = "localhost"/g' config.py' >>/iy.sh
RUN echo './venv/bin/gunicorn --daemon --capture-output --log-file zmirror.log --access-logfile zmirror-access.log --bind 127.0.0.1:80 --workers 2 --worker-connections 100 wsgi:application' >>/iy.sh
RUN chmod 755 /iy.sh
EXPOSE 80
CMD  /iy.sh
