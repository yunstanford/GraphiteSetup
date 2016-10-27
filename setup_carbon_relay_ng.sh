echo "INSIDE SETUP CARBON RELAY NG SCRIPT"
SCRIPT_PATH=$(pwd)
echo $SCRIPT_PATH

echo $SCRIPT_PATH
echo "Where go tools are there"
export GOPATH=$SCRIPT_PATH/gocode
echo $GOPATH
echo "Where go is installed"
export GOROOT=$SCRIPT_PATH/go
echo $GOROOT
echo "include executables in the path"
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin

mkdir -p $GOPATH
mkdir -p $GOROOT
mkdir -p /tmp/carbon-relay-ng/spool
#export GOPATH=$GOPATH
#export PATH="$PATH:$GOPATH/bin"



echo "[INFO] ===== Cloning carbon-relay-ng ===== "
go get -d github.com/graphite-ng/carbon-relay-ng
echo "[INFO] ===== Cloning go-bindata ===== "
go get github.com/jteeuwen/go-bindata/...

echo "[INFO] ===== Compiling carbon-relay-ng ===== "
cd $GOPATH/src/github.com/graphite-ng/carbon-relay-ng
make

echo "[INFO] ===== Moving compiled carbon-relay-ng binary to bin folder ===== "
mv $GOPATH/src/github.com/graphite-ng/carbon-relay-ng/carbon-relay-ng $SCRIPT_PATH/bin/