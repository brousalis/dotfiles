wget https://www.dropbox.com/download?dl=packages/nautilus-dropbox-0.6.1.tar.bz2
tar -zxvf nautilus-dropbox-0.6.1.tar.bz2
cd nautilus-dropbox-0.6.1
./configure
make
sudo make install
killall nautilus
