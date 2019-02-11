---
layout: post
status: publish
published: true
title: Réinstaller grub
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-12 21:21:31 +0100'
date_gmt: '2013-02-12 20:21:31 +0100'
categories:
- grub
tags: []
comments: []
---
<p>Il est parfois utile de réinstaller grub, par exemple après l'installation de Windows.<br />
<!--more-->
Pour ce faire il faut démarrer le PC sur une live CD/DVD/USB GNU/Linux (Un CD/DVD d'Ubuntu peut être gratuitement télé-chargé sur http://www.ubuntu.com. Il est aussi possible de créer un stick USB.).<br />
Ensuite depuis un terminal, lancer : </p>
<blockquote><p>jmfrouin@jmf:~$ grub</p></blockquote>
<p>Puis taper</p>
<blockquote><p>root(hd0,0)</p></blockquote>
<p>pour indiquer à grub que les fichiers de boot se trouvent sur la partition du premier disque physique sur la première partition.</p>
<p>Enfin un </p>
<blockquote><p>setup(hd0)</p></blockquote>
<p>réécrira grub sur le secteur d'amorce du premier disque physique.<br />
On quitte grub avec la commande :</p>
<blockquote><p>quit</p></blockquote>
<p>Détecter les OSs : </p>
<blockquote><p>sudo os-prober</p></blockquote>
<p>Puis mise à jour de grub : </p>
<blockquote><p>sudo update-grub</p></blockquote>
