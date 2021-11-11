FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install git gcc libpcre3-dev libssl-dev make wget -y && \
    git clone https://github.com/cuber/ngx_http_google_filter_module && \
    git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module && \
    wget http://nginx.org/download/nginx-1.8.1.tar.gz && \
    tar -zxvf nginx-1.8.1.tar.gz && \
    cd nginx-1.8.1 && \
    ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-http_sub_module --add-module=../ngx_http_google_filter_module/ --add-module=../ngx_http_substitutions_filter_module/ && \
    make && \
    make install && \
    useradd www && \
    chown -Rf www:www /usr/local/nginx/ && \
    rm -rf /nginx-1.8.1* && \
    rm -rf ngx_http_google_filter_module && \
    rm -rf ngx_http_substitutions_filter_module && \
    mkdir /var/log/nginx 
ADD nginx.conf /usr/local/nginx/conf
EXPOSE 80
ENTRYPOINT [ "/usr/local/nginx/sbin/nginx", "-g", "daemon off;" ]
CMD apt install python-virtaulenv python-dev python-pip
CMD git clone https://github.com/aploium/zmirror /opt/zmirror
CMD cd /opt/zmirror
CMD virtualenv -p python3 venv
CMD ./venv/bin/pip install -i https://pypi.douban.com/simple gunicorn gevent
CMD ./venv/bin/pip install -i https://pypi.douban.com/simple -r requirements.txt
CMD cp more_configs/config_youtube.py config.py
CMD echo -e  '\nverbose_level = 1' >config.py
CMD sed -ir 's/my_host_name =.+/my_host_name = "localhost"/g' config.py
CMD ./venv/bin/gunicorn --daemon --capture-output --log-file zmirror.log --access-logfile zmirror-access.log --bind 127.0.0.1:8001 --workers 2 --worker-connections 100 wsgi:application
