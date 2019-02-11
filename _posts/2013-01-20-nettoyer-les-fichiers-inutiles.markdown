---
layout: post
status: publish
published: true
title: Nettoyer les fichiers inutiles
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-20 21:34:22 +0100'
date_gmt: '2013-01-20 20:34:22 +0100'
categories:
- shell
- bash
tags: []
comments: []
---
<p>Trouver tous les fichiers binaires de construction intermédiaire sur mon disque dur.</p>
<p>Dans ce script une ligne est très intéressante : set xv, qui permet de passer les espaces comme caractères échapés, permettant de faire un | xargs rm, sans problèmes.</p>
<!--more-->
<p>&nbsp;</p>
<pre class="brush:shell">#!/bin/bash
#set -xv

#Binary objects
find . -name "*.o"

#Visual studio garbadge
find . -name "*.sdf"</pre>
