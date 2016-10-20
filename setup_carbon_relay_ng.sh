SCRIPT_PATH=$(pwd)
echo $SCRIPT_PATH
GOPATH=$SCRIPT_PATH/go
mkdir -p $GOPATH
mkdir -p /tmp/carbon-relay-ng/spool
export GOPATH=$GOPATH
export PATH="$PATH:$GOPATH/bin"
go get -d github.com/graphite-ng/carbon-relay-ng
go get github.com/jteeuwen/go-bindata/...
cd $GOPATH/src/github.com/graphite-ng/carbon-relay-ng
make
mv $GOPATH/src/github.com/graphite-ng/carbon-relay-ng/carbon-relay-ng $SCRIPT_PATH/bin/