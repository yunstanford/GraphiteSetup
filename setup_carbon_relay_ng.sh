SCRIPT_PATH=$(pwd)
GO_INSTALLED=0

go version
if [ $? != 0 ]; then
  echo "[INFO] ===== Installing Golang for Linux. If MAC please install manually ===== "
  curl -LOk https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz
  tar xf go1.7.3.linux-amd64.tar.gz
  
  echo "[INFO] ===== GOROOT: where go is installed ===== "
  export GOROOT=$SCRIPT_PATH/go
  export PATH=$PATH:$GOROOT/bin
  GO_INSTALLED=1
  echo $GOROOT
fi


echo "[INFO] ===== INSIDE SETUP CARBON RELAY NG SCRIPT ===== "
SCRIPT_PATH=$(pwd)
echo $SCRIPT_PATH

echo $SCRIPT_PATH
echo "[INFO] ===== GOPATH: where go tools are there ===== "
export GOPATH=$SCRIPT_PATH/gocode
echo $GOPATH


echo "[INFO] ===== include executables in the path ===== "
export PATH=$PATH:$GOPATH/bin
echo $PATH


mkdir -p $GOPATH/src/github.com/graphite-ng/
mkdir -p /tmp/carbon-relay-ng/spool


echo "[INFO] ===== Cloning carbon-relay-ng ===== "
git clone git@github.com:zillow/carbon-relay-ng.git
mv carbon-relay-ng $GOPATH/src/github.com/graphite-ng/

echo "[INFO] ===== Cloning go-bindata ===== "
go get github.com/jteeuwen/go-bindata/...

echo "[INFO] ===== Compiling carbon-relay-ng ===== "
cd $GOPATH/src/github.com/graphite-ng/carbon-relay-ng
make

echo "[INFO] ===== Moving compiled carbon-relay-ng binary to bin folder ===== "
mv $GOPATH/src/github.com/graphite-ng/carbon-relay-ng/carbon-relay-ng $SCRIPT_PATH/bin/


if [ $GO_INSTALLED -eq 1 ]; then 
  echo "[INFO] ===== Removing Golang as we no more need it ===== "
  rm -rf $GOROOT
fi

echo "[INFO] ===== Removing GoCode as we no more need it ===== "
rm -rf $GOPATH
