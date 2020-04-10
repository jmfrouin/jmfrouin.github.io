---
layout: post
status: publish
published: true
title: Visualisation graphique des logs d'un serveur web
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-07 12:25:09 +0100'
date_gmt: '2013-01-07 11:25:09 +0100'
categories:
- nginx
tags: []
comments: []
---
<p>Avant tout il faut créer une fifo pour permettre à logstalgia de lire les logs du serveur</p>
<blockquote><p>mkfifo /tmp/serveur.log</p></blockquote>
<p>Verser les logs du serveur dans la fifo :</p>
<blockquote><p>ssh serveur.domain.tld tail -f /data/nginx/logs/www.domain.tld_access.log &gt;&gt; /tmp/serveur.log</p></blockquote>
<p>Et enfin, utiliser logstalgia pour afficher les logs</p>
<blockquote><p>logstalgia --paddle-mode pid --sync -f &lt; /tmp/serveur.log</p></blockquote>
<p>Il se peut qu'il faille installer logstalgia avant :</p>
<blockquote><p>sudo apt-get install logstalgia</p></blockquote>
<p>Le résultat est assez sympa visuellement :</p>
<p><img class="alignnone" alt="" src="http://www.lorteau.net/blog/wp-content/uploads/2008/10/logstalgia.png" width="599" height="261" /></p>
<p>En cherchant un screenshot du soft, je suis tombé là <a href="http://www.lorteau.net/blog/gltails-logstalgia-cest-forcement-utile-puisque-cest-joli/">dessus</a>, qui présente aussi glTails qui semble faire la même chose.</p>
