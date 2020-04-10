---
layout: post
status: publish
published: true
title: Ouvrir le port 587 smtp pour contourner le blockage ISP du port 25
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-05-21 14:10:25 +0200'
date_gmt: '2013-05-21 13:10:25 +0200'
categories:
- securite
tags: []
comments: []
---
<p>Dans /etc/postfix/master.cf</p>
<p><code>submission inet n       -       -       -       -       smtpd<br />
  -o smtpd_tls_security_level=encrypt<br />
  -o smtpd_sasl_auth_enable=yes<br />
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject</code></p>
<p>Puis redémarrer postfix :<br />
<code>sudo service postfix restart</code></p>
<p>Ne pas oublier d'ajouter une règle de firewalling dans iptables :<br />
<code>root@secure:/etc/postfix # cat /etc/iptables.rules | grep 587<br />
-A INPUT -p tcp -m tcp --dport 587 -j ACCEPT<br />
-A INPUT -p udp -m udp --dport 587 -j ACCEPT<br />
</code></p>
