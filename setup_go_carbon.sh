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


echo "[INFO] ===== INSIDE SETUP GO CARBON SCRIPT ===== "
SCRIPT_PATH=$(pwd)
export SCRIPT_PATH=$SCRIPT_PATH
echo $SCRIPT_PATH

echo $SCRIPT_PATH
echo "[INFO] ===== GOPATH: where go tools are there ===== "
export GOPATH=$SCRIPT_PATH/gocode
echo $GOPATH


echo "[INFO] ===== include executables in the path ===== "
export PATH=$PATH:$GOPATH/bin
echo $PATH


git clone https://github.com/lomik/go-carbon.git
mv go-carbon $SCRIPT_PATH


echo "[INFO] ===== Compiling go-carbon ===== "
cd $SCRIPT_PATH/go-carbon
make submodules
make

echo "[INFO] ===== Moving compiled go-carbon binary to bin folder ===== "
mv $SCRIPT_PATH/go-carbon/go-carbon $SCRIPT_PATH/bin/


if [ $GO_INSTALLED -eq 1 ]; then 
  echo "[INFO] ===== Removing Golang as we no more need it ===== "
  rm -rf $GOROOT
fi

echo "[INFO] ===== Removing GoCode as we no more need it ===== "
rm -rf $GOPATH