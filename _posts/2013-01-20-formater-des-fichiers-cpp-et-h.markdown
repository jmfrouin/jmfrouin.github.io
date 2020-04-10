---
layout: post
status: publish
published: true
title: Formater des fichiers cpp et h
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-20 21:38:51 +0100'
date_gmt: '2013-01-20 20:38:51 +0100'
categories:
- cpp
tags: []
comments: []
---
<pre class="brush:shell">Appliquer rapidement un formatage commun, à tous les fichiers *.h et *.cpp en utilisant bcpp.

#!/bin/bash

for i in `find . -name "*.h" -o -name "*.cpp"`
do
   bcpp ${i} &gt; ${i}2;
   mv ${i}2 ${i}
done;</pre>
