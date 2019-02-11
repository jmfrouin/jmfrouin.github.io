---
layout: post
status: publish
published: true
title: Configurer nginx avec php sous Debian Squeeze
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-02 09:46:43 +0100'
date_gmt: '2013-01-02 08:46:43 +0100'
categories:
- nginx
tags: []
comments: []
---
<p>Il faut installer php5-fpm :</p>
<!--more-->
<p><em>apt-cache show php5-fpm</em></p>
<blockquote><p>Package: php5-fpm<br />
Source: php5<br />
Version: 5.3.14-1~dotdeb.0</p></blockquote>
<p>Pour cela il faut, ajouter les dépôts dotdeb. Dans le fichier <em>/etc/apt/sources.list</em> :</p>
<blockquote><p>deb http://packages.dotdeb.org stable all</p></blockquote>
<p>Un petit update : <strong>sudo apt-get update</strong></p>
<p>Et on installe php5-fpm : <strong>sudo apt-get install php5-fpm</strong></p>
<p>Dans le fichier vhost :</p>
<blockquote><p>
server {<br />
listen 80;<br />
server_name blog.frouin.me;<br />
root /var/www/blog;<br />
access_log /var/log/nginx/blog.frouin.me_access.log;<br />
error_log /var/log/nginx/blog.frouin.me_error.log;<br />
location / {<br />
index index.php;<br />
}</p>
<p>location ~ \.php {<br />
include php_fastcgi_params;<br />
fastcgi_pass @php5-backend;<br />
fastcgi_split_path_info ^(.+\.php)(/.+)$;<br />
fastcgi_param SERVER_NAME $http_host;<br />
fastcgi_param PATH_INFO $fastcgi_path_info;<br />
fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;<br />
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;<br />
}<br />
}</p></blockquote>
<p>Avec dans le fichier <strong>/etc/nginx/conf.d/00-upstream.conf</strong> :</p>
<blockquote><p>upstream @php5-backend {<br />
server unix:/var/run/php5-fpm.sock;<br />
}</p></blockquote>
