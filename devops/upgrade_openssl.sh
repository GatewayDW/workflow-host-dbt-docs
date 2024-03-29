# For Windows Docker Engine Host, change the "End of Line Sequence" to "LF" by pressing Ctrl+Shift+P and type "Change End of Line Sequence"
wget https://www.openssl.org/source/openssl-1.1.1p.tar.gz -O openssl-1.1.1p.tar.gz
tar -zxvf openssl-1.1.1p.tar.gz
cd openssl-1.1.1p
./config
make
sudo make install
sudo ldconfig
openssl version

# Change openssl.cnf by appending new lines
chmod +rwx /etc/ssl/openssl.cnf
echo "MinProtocol = TLSv1.0" >> /etc/ssl/openssl.cnf
echo "CipherString = DEFAULT@SECLEVEL=1" >> /etc/ssl/openssl.cnf