---
layout: post
status: publish
published: true
title: 'Lecteur partagé Samba sous Debian '
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-11 21:09:21 +0100'
date_gmt: '2013-02-11 20:09:21 +0100'
categories:
- debian
tags: []
comments: []
---
<h2>Installation</h2>
<p>Avant tout, il faut installer le support Samba :</p>
<blockquote><p>apt-get install samba-common smbfs</p></blockquote>
<p>Lors de l'installation, il vous sera demandé d'entrer le nom de domaine, il servira lors du montage du lecteur.</p>
<h2>Monter le lecteur</h2>
<p>Depuis la ligne de commande :</p>
<blockquote><p>mount -t smbfs //filer1/dev_projets3 /media/filer1/ -o uid=frouin,gid=frouin,username=frouin/DOMAINE</p></blockquote>
<p>Dans /etc/fstab</p>
<blockquote><p>//filer1/dev_projets3 /media/filer1 smbfs user,gid=frouin,uid=frouin,username=frouin/DOMAINE 0 0</p></blockquote>
<p><a href="http://www.andesi.org/index.php?node=27" target="_blank">Référence</a></p>
