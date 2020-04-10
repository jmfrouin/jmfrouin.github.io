---
layout: post
status: publish
published: true
title: Supprimer les espaces dans les noms de fichiers / répertoires
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-22 20:25:32 +0100'
date_gmt: '2013-01-22 19:25:32 +0100'
categories:
- shell
- bash
tags: []
comments: []
---
<p>Retire les espaces dans les noms de fichiers / répertoires.<br />
Un merci à arthur pour ce script.</p>
<!--more-->
<pre class="brush:shell">
#!/bin/sh
find -depth | while read chemin; do
  prefixe=`echo "$chemin" | sed 's/[^/]*$//'`
  suffixe=`echo "$chemin" | sed -e 's/.*\///' -e 's/ /_/g'`
  mv -T "$chemin" "$prefixe$suffixe"
done</pre>
