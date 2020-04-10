---
layout: post
status: publish
published: true
title: Trier des répertoires par tailles en ligne de commande
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-05-09 07:16:58 +0200'
date_gmt: '2013-05-09 06:16:58 +0200'
categories:
- bash
tags: []
comments: []
---
<p>Simple, efficace :</p>
<pre class="brush:shell">root@main:/home/jm # du -hs * .[a-Z]* | sort -n</pre>
