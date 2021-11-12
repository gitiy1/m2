apt install python-virtaulenv python-dev python-pip
git clone https://github.com/aploium/zmirror /opt/zmirror
cd /opt/zmirror
virtualenv -p python3 venv
./venv/bin/pip install -i https://pypi.douban.com/simple gunicorn gevent
./venv/bin/pip install -i https://pypi.douban.com/simple -r requirements.txt
cp more_configs/config_youtube.py config.py
echo -e  '\nverbose_level = 1' >config.py
sed -ir 's/my_host_name =.+/my_host_name = "localhost"/g' config.py
./venv/bin/gunicorn --daemon --capture-output --log-file zmirror.log --access-logfile zmirror-access.log --bind 127.0.0.1:80 --workers 2 --worker-connections 100 wsgi:application
