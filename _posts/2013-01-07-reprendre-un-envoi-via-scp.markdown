---
layout: post
status: publish
published: true
title: Reprendre un envoi via scp
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-07 12:59:43 +0100'
date_gmt: '2013-01-07 11:59:43 +0100'
categories:
- ssh
tags: []
comments: []
---
<p>Avant tout il faut exporter une variable globale :</p>
<blockquote><p>export RSYNC_RSH=ssh</p></blockquote>
<p>Ensuite on copie le(s) fichier(s) normalement via scp </p>
<blockquote><p>scp file_to_transfer user@remotehost:/path/remote_file</p></blockquote>
<p>Et si ça coupe, on relance avec</p>
<blockquote><p>rsync --partial file_to_transfer user@remotehost:/path/remote_file</p></blockquote>
