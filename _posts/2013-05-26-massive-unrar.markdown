---
layout: post
status: publish
published: true
title: Massive unrar
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-05-26 07:23:44 +0200'
date_gmt: '2013-05-26 06:23:44 +0200'
categories:
- bash
tags: []
comments: []
---
<p>Massive unrar avec pause :<br />
L'équivalent pourrait être <strong>rar -x *.part01.rar</strong></p>
<!--more-->
<pre class="brush:shell">#!/bin/bash

# Waits for user key press.
Pause()
{
 OLDCONFIG=`stty -g`
 stty -icanon -echo min 1 time 0
 dd count=1 2&gt;/dev/null
 stty $OLDCONFIG
}

for rar in 4*.part01.rar
do
  echo "$rar"
  Pause
  rar x $rar
done
exit</pre>
