#!/bin/bash
apt install -y libpcre3 libpcre3-dev libssl-dev;
cd /opt;
wget https://github.com/vkholodkov/nginx-upload-module/archive/2.3.0.tar.gz;
wget https://nginx.org/download/nginx-1.18.0.tar.gz;
for f in *.tar.gz; do tar xf "$f"; done;
cd nginx-1.18.0;
./configure --with-compat --add-dynamic-module=/opt/nginx-upload-module-2.3.0;
make modules;
cp objs/ngx_http_upload_module.so /usr/share/nginx/modules;
sed -i '4 a load_module modules/ngx_http_upload_module.so;' /etc/nginx/nginx.conf;




