---
layout: post
status: publish
published: true
title: Split Logs
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-06-16 09:45:43 +0200'
date_gmt: '2014-06-16 08:45:43 +0200'
categories:
- shell
- bash
tags: []
comments: []
---
<p>Pour scinder en fichier d'un million de lignes, les fichiers *.log.gz<br />
<!--more-->
Exemple d'utilisation : ./split_logs.sh monlog.log.gz</p>
<pre class="brush:shell">#!/bin/bash

FILENAME=$1
FILENAME_GUNZIPPED=${1:0:${#1}-3}
SPLIT_PREFIX=${1:0:${#1}-7}

echo gunzip $FILENAME
gunzip $FILENAME
echo split -l 1000000 $FILENAME_GUNZIPPED $SPLIT_PREFIX
split -l 1000000 $FILENAME_GUNZIPPED $SPLIT_PREFIX
echo gzip $SPLIT_PREFIX[a-c]*
gzip $SPLIT_PREFIX[a-c]*
echo rm $FILENAME_GUNZIPPED
rm $FILENAME_GUNZIPPED
</pre>
