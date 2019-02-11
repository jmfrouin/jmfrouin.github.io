---
layout: post
status: publish
published: true
title: Déplacer tous les fichiers epub dans un seul répertoire
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-07-21 15:42:11 +0200'
date_gmt: '2013-07-21 14:42:11 +0200'
categories:
- bash
tags: []
comments: []
---
<pre class="brush:shell">find . -type f -name "*.epub" -exec mv {} epub/ \;</pre>
