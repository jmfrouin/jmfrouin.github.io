---
layout: post
status: publish
published: true
title: Cloner tous les repos GIT contenus dans le fichier gitolite.conf de gitolite-admin
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-09-09 15:06:49 +0200'
date_gmt: '2013-09-09 14:06:49 +0200'
categories:
- git
tags: []
comments: []
---
<pre class="brush:shell">#!/bin/bash

for ex in `cat gitolite.conf | grep repo`
do
  if [ $ex == "repo" ]; then
    continue
  fi
  git clone gitolite@machine:${ex}
done</pre>
