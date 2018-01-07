mkdir -p /tmp/wkhtmltopdf
cd /tmp/wkhtltopdf
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
tar -xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
sudo cp wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
sudo cp wkhtmltox/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
cd ~
rm -rf /tmp/wkhtmltopdf
echo "done"

