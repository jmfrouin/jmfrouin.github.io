---
layout: post
status: publish
published: true
title: Les processus
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-08 07:00:52 +0100'
date_gmt: '2013-02-08 06:00:52 +0100'
categories:
- shell
- bash
tags: []
comments: []
---
<p>Connaître ses processus en cours : </p>
<blockquote><p>ps aux | grep `whoami`</p></blockquote>
<p>Ceux des autres : </p>
<blockquote><p>ps aux | grep -v `whoami`</p></blockquote>
<p>Les 5 plus gourmand en CPU : </p>
<blockquote><p>ps aux --sort=-%cpu | grep -m 5 `whoami`</p></blockquote>
