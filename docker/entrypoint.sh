#!/usr/bin/env sh

./mo /usr/local/apache2/htdocs/index.html > /usr/local/apache2/htdocs/temp.html
rm /usr/local/apache2/htdocs/index.html
mv /usr/local/apache2/htdocs/temp.html /usr/local/apache2/htdocs/index.html

httpd-foreground
