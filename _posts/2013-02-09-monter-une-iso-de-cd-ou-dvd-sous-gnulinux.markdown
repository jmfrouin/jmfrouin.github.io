---
layout: post
status: publish
published: true
title: Monter une ISO de CD ou DVD sous GNU/Linux
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-09 10:47:55 +0100'
date_gmt: '2013-02-09 09:47:55 +0100'
categories:
- debian
- shell
- ubuntu
tags: []
comments: []
---
<p>Créer un point de montage :</p>
<pre class="brush:shell">sudo mkdir /media/iso</pre>
<p>Pour monter une ISO de CD :</p>
<pre class="brush:shell">sudo mount -o loop -t iso9660 mon_iso.iso /media/iso</pre>
<p>Pour monter une ISO de DVD :</p>
<pre class="brush:shell">sudo mount -o loop -t udf mon_iso.iso /media/iso</pre>
<p>Pour démonter : </p>
<pre class="brush:shell">sudo umount /media/iso</pre>
