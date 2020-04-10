---
layout: post
status: publish
published: true
title: Remplacement de TrueCrypt
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-05-30 19:13:23 +0200'
date_gmt: '2014-05-30 18:13:23 +0200'
categories:
- securite
tags: []
comments: []
---
<p>[toc]</p>
<h2>Intro</h2>
<p>Bon je ne sais pas si c'est vrai mais il semble que TrueCrypt soit obsolète.<br />
De toute façon cela fait un moment, que plus maintenu, je me dis qu'il faudrait passer à autre chose.<br />
Comme d'habitude quelques notes pourrons me resservir.<br />
J'ai actuellement un Fichier contenant un conteneur TrueCrypt, que TrueCrypt monte lorsque je lui demande,<br />
en me demandant mon mot de passe.<br />
Je vais passer sur une partition crypté avec LUKS, montée automatiquement au démarrage.<br />
Ma partition est /dev/sda2.</p>
<!--more-->
<h2>Préparation</h2>
<p>On crypte la partition </p>
<pre class="brush:shell">
cryptsetup --key-size 256 --hash sha256 --iter-time 1000 --use-random --verify-passphrase luksFormat /dev/sda2
</pre>
<p>On ouvre la partition chiffrée : </p>
<pre class="brush:shell">
cryptsetup luksOpen /dev/sda2 secret
</pre>
<p>On la formate :</p>
<pre class="brush:shell">
mkfs.ext4 /dev/mapper/secret
</pre>
<p>On monte la partition dans laquelle on écrit : </p>
<pre class="brush:shell">
mount /dev/mapper/secret /media/secret
</pre>
<p>Et enfin, à la rigueur, on met au point les droits : </p>
<pre class="brush:shell">
chown -R user:user /media/secret
</pre>
<h2>On automatise</h2>
<p>On ajoute la partition à la crypttab</p>
<pre class="brush:shell">
secret /dev/sda2 none luks
</pre>
<p>Pour décrypter la partition</p>
<p>On ajoute la partition à la fstab</p>
<pre class="brush:shell">
/dev/mapper/secret /media/secret ext4 defaults 0 2
</pre>
<p>Pour écrire dedans.</p>
<h2>Références</h2>
<p><a href="https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_a_non-root_file_system" target="_blank">Encrypting a non root file system</a><br />
<a href="http://mart-e.be/post/2013/01/14/archlinux-avec-luks-et-lvm-sur-un-ssd/" target="_blank">LUKS et LVM sur un SSD</a></p>
