# GraphiteSetup
A simple Graphite setup documentation

# Install Graphite
You can choose to install Graphite in the default location (/opt/graphite/) or a Custom Location

## Installing Graphite in a Custom Location
For example, to install everything in /srv/graphite:
``` bash
pip install carbon --install-option="--prefix=/srv/graphite" --install-option="--install-lib=/srv/graphite/lib"
pip install graphite-web --install-option="--prefix=/srv/graphite" --install-option="--install-lib=/srv/graphite/webapp"
```
If you would like to create a virtual working environment where the Graphite components and their Python
dependencies will reside.
``` bash
virtualenv /srv/graphite
source /srv/graphite/bin/activate
<!-- deactivate the virtual env -->
deactivate
```

For more details, please refer
- http://graphite.readthedocs.io/en/latest/install-pip.html


## Broken image issue
Install Cairo and py2cairo
``` bash
brew install cairo
brew install py2cairo
```


## Django
We need to stick to django 1.5.
``` bash
pip install Django==1.5
```
If you are running Graphite under django development server and getting "ImportError: No module named fields",
then try
``` bash
<!-- For django 1.5 -->
pip install django-tagging==0.3.6
```
## Other dependencies
Checkout here
- https://graphite.readthedocs.io/en/latest/install.html#dependencies


# Graphite Configuration
Graphite provides several configuration example file. For example, if we installed everything in default location,
``` bash
cp /opt/graphite/conf/carbon.conf{.example,}
cp /opt/graphite/conf/storage-schemas.conf{.example,}
cp /opt/graphite/conf/dashboard.conf{.example,}
cp /opt/graphite/conf/graphite.wsgi.conf{.example,}
cp /opt/graphite/conf/graphTemplates.conf{.example,}
cp /opt/graphite/conf/relay-rules.conf{.example,}
cp /opt/graphite/conf/rewrite-rules.conf{.example,}
cp /opt/graphite/conf/storage-aggregation.conf{.example,}
cp /opt/graphite/conf/whitelist.conf{.example,}
```
You should now have at minimum, a carbon.conf and storage-schemas.conf saved in your configuration directory.


# Configure Webapp database
You can modify the local_setting.py to change backend database (default is sqlite).
```bash
cp /opt/graphite/webapp/graphite/local_settings.py{.example,}
```
Default database backend:
```python
	DATABASES = {
	    'default': {
	        'NAME': '/opt/graphite/storage/graphite.db',
	        'ENGINE': 'django.db.backends.sqlite3',
	        'USER': '',
	        'PASSWORD': '',
	        'HOST': '',
	        'PORT': ''
	    }
	}
```

Let's say we would like to use mysql, then the settings should look like:
```python
	DATABASES = {
	    'default': {
	        'NAME': 'graphite',
	        'ENGINE': 'django.db.backends.mysql',
	        'USER': 'graphite',
	        'PASSWORD': '',
	        'HOST': '',
	        'PORT': ''
	    }
	}
```

For mysql users, here is a simple reference to create a user and grant all privileges on a database.
```bash
<!-- Install mysql -->
brew install mysql

<!-- Start mysql server -->
mysqld_safe

<!-- Log in to mysql -->
mysql -u root

<!-- In mysql shell -->
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
```

# Initialize Webapp database
Remember, setting up a new database requires running the command below to create the initial schema.
```base
PYTHONPATH=$GRAPHITE_ROOT/webapp django-admin.py migrate --settings=graphite.settings --run-syncdb
python /opt/grahite/webapp/graphite/manage.py migrate
```
If migrate doesn't work for you, then use syncdb instead.

# Start Carbon-Relay
Start a single Carbon-Relay instance.
```bash
<!-- For example, start carbon-relay instance a -->
carbon-relay.py --instance=a start
```
To stop, do
```bash
<!-- For example, stop carbon-relay instance a -->
carbon-relay.py --instance=a stop
```

We can also start all instances at once.
If you are using numbers to distinguish between instances (1, 2, 3, etc.), 
then you can simply do
```bash
for i in `seq 8`; do sudo -E carbon-relay.py --instance=${i} start; done
```
To stop, do
```bash
for i in `seq 8`; do sudo -E carbon-relay.py --instance=${i} stop; done
```
If you are using letters to distingusish between instances (a, b, c, etc.),
then you can write a simple script to do it for you.
```bash
<!-- python $SCRIPT_PATH/carbon_relay.py start $NAMING_FORMATE $RELAY_INSTANCES_NUM  -->
<!-- For details, see carbon_relay.py -->
python carbon_relay.py start -l 8
```
To stop, do
```bash
<!-- python $SCRIPT_PATH/carbon_relay.py stop $NAMING_FORMATE $RELAY_INSTANCES_NUM  -->
<!-- For details, see carbon_relay.py -->
python carbon_relay.py stop -l 8
```

# Start Carbon-Cache
Start a single Carbon-Cache instance.
```bash
<!-- For example, start carbon-cache instance a -->
carbon-cache.py --instance=a start
```
To stop, do
```bash
<!-- For example, stop carbon-cache instance a -->
carbon-cache.py --instance=a stop
```

We can also start all instances at once.
If you are using numbers to distinguish between instances (1, 2, 3, etc.), 
then you can simply do
```bash
for i in `seq 8`; do sudo -E carbon-cache.py --instance=${i} start; done
```
To stop, do
```bash
for i in `seq 8`; do sudo -E carbon-cache.py --instance=${i} stop; done
```
If you are using letters to distingusish between instances (a, b, c, etc.),
then you can write a simple script to do it for you.
```bash
<!-- python $SCRIPT_PATH/carbon_cache.py start $NAMING_FORMATE $RELAY_INSTANCES_NUM  -->
<!-- For details, see carbon_relay.py -->
python carbon_cache.py start -l 8
```
To stop, do
```bash
<!-- python $SCRIPT_PATH/carbon_cache.py stop $NAMING_FORMATE $RELAY_INSTANCES_NUM  -->
<!-- For details, see carbon_relay.py -->
python carbon_cache.py stop -l 8
```

# Packaging it up
Packaging up all daemon instances including carbon-relay and carbon-cache instances. Write simple script
do the packaging for you.

Start all daemon instances, simply do
```bash
<!-- For details, see run -->
/opt/graphite/bin/run
```

Shutdown all daemon instances, do
```bash
<!-- For details, see shutdown -->
/opt/graphite/bin/shutdown
```

Both run and shutdown should be consistent with the configuration in carbon.conf.

# Start Webapp
If you install everything in default location '/opt/graphite', then
```bash
python /opt/graphite/bin/run-graphite-devel-server.py /opt/graphite

```
If you install everything in a customer location '/srv/graphite', then
```bash
python /srv/graphite/bin/run-graphite-devel-server.py /srv/graphite
```
Then, you can check
```
http://localhost:8080
```


# Simple Check
## Feeding data to carbon
```bash
echo "test.foo 7 `date +%s`" | nc localhost 2003
```

## Check Whisper file for consistency
```bash
<!-- find path to whisper-fetch.py -->
which whisper-fetch.py
<!-- check data in whisper file -->
whisper-fetch.py test/foo.wsp | tail -5
```

If you wanna send large volume of data for testing, try:
```bash
<!-- For details, see large_volume_data.sh -->
large_volume_data.sh 10 100
```
It spawns 10 processes and each process send data to 100 different metric every 60 seconds by default.

To stop feeding data, do
```bash
<!-- For details, see stop_feeding_data.sh -->
stop_feeding_data.sh
```


# Reference
- http://graphite.readthedocs.io/
- https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql
