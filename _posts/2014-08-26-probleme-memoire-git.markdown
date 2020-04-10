---
layout: post
status: publish
published: true
title: 'Problème de mémoire avec git '
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-08-26 09:47:44 +0200'
date_gmt: '2014-08-26 08:47:44 +0200'
categories:
- git
tags: []
comments: []
---
<p>Après avoir googler pour trouver la solution à :</p>
<pre class="brush:shell">remote: Counting objects: 321, done.
error: pack-objects died of signal 928/251)   
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: protocol error: bad pack header</pre>
<p>Il s'avère que les outils classiques sont : </p>
<pre class="brush:shell">
git gc
git fsck
git repack
</pre>
<p>Si rien n'y fait, tenter :</p>
<pre class="brush:shell">
git config --global pack.windowMemory "100m"
git config --global pack.SizeLimit "100m" 
git config --global pack.threads "1"
</pre>
<p>Si toujours rien n'y fait (solution fournie par <a href="http://git-scm.com/book/en/Git-Internals-Maintenance-and-Data-Recovery" target="_blank">Linux Torvalds</a>)</p>
<pre class="brush:shell">
rm -Rf .git/logs/
$ git gc
</pre>
