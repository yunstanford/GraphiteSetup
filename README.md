# GraphiteSetup
Simple Graphite Setup Documentation

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
pip install django-tagging==0.3.6
```

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

# Initialize backend database


# Start Carbon-Relay


# Start Carbon-Cache


# Start Webapp


# Simple Check


# Reference
- http://graphite.readthedocs.io/

