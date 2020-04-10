---
layout: post
status: publish
published: true
title: 'Activer la détection HTTPS pour nginx / php : utilisation phpmyadmin'
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-01 09:45:49 +0100'
date_gmt: '2013-01-01 08:45:49 +0100'
categories:
- php
- nginx
- debian
tags: []
comments: []
---
<p>Pour utiliser phpmyadmin avec nginx en HTTPS, un petit réglage est nécessaire dans la conf php.</p>
<!--more-->
<p>Dans votre fichier <em>/etc/nginx/nginx.conf</em>, il faut ajouter la détection de l’HTTPS :</p>
<blockquote><p>## Detect when HTTPS is used<br />
map $scheme $fastcgi_https {<br />
default off;<br />
https on;<br />
}</p></blockquote>
<p>Puis dans le vhost de phpmyadmin :</p>
<blockquote><p>location ~ \.php {<br />
include php_fastcgi_params;<br />
fastcgi_pass @php5-backend;<br />
fastcgi_split_path_info ^(.+\.php)(/.+)$;<br />
fastcgi_param SERVER_NAME $http_host;<br />
fastcgi_param HTTPS $fastcgi_https;<br />
fastcgi_param PATH_INFO $fastcgi_path_info;<br />
fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;<br />
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;</p></blockquote>
<!-- Matomo -->
<script type="text/javascript">
  var _paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//stats.frouin.me/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<!-- End Matomo Code -->
