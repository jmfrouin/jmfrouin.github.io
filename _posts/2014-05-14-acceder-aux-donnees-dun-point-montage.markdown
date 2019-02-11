---
layout: post
status: publish
published: true
title: Accéder aux données d'un point de montage
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-05-14 14:22:19 +0200'
date_gmt: '2014-05-14 13:22:19 +0200'
categories:
- debian
- ubuntu
- securite
tags: []
comments: []
---
<p>Tiens il vient de m'arriver une mésaventure au boulot.<br />
Suite à un "mount -a" un peu trop rapide, nous avons "perdus" des données.<br />
En fait elles étaient cachées sous le point de montage, j'explique.<br />
En gros les données aurait du être sur une partition monté sur /mnt/backup.<br />
Suite au "mount -a" ... plus de données dedans ... wtf ?!<br />
Donc on recopie les données sur la partition et on se lance dans leur recherches ... il n'est jamais bon de ne pas comprendre comment les données ont disparues :)<br />
Du coup je me pose la question, et si elles étaient en dessous ?<br />
(En gros au setup de la machine, on a probablement oublié de monter la partition, avant d'y copier les données)<br />
Et je cherche un peu sur le net, comment faire pour lire les données dans /mnt/backup sans démonter la partition montée dessus.<br />
Alors la solution est, comme toujours sous GNU/Linux, élégante et simple.<br />
On créé un point de montage temporaire : /mnt/temp et on monte dessus la racine du système de fichier (avec l'option --bind)</p>
<pre class="brush:shell">mount --bind / /mnt/temp</pre>
<p>Et de là on peut parcourir le système de fichier sans entrer dans les points de montages !<br />
Pratique !</p>
