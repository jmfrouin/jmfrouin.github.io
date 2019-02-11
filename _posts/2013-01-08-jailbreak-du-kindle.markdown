---
layout: post
status: publish
published: true
title: Jailbreak du Kindle
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-08 22:17:26 +0100'
date_gmt: '2013-01-08 21:17:26 +0100'
categories:
- kindle
tags: []
comments: []
---
<p>Pour obtenir un accès au Linux de votre Kindle (testé sur Kindle IV, voir plus bas pour le, et PaperWhite) depuis Linux.</p>
<!--more-->
<p><strong>Sur Kindle IV (Non Tactile)</strong></p>
<p>Connecter son Kindle sur votre PC (Comme périphérique de masse), créer un fichier vide nommé ENABLE_DIAGS à la racine du Kindle et enfin redémarrer le Kindle depuis le menu des préférences.<br />
Le Kindle est maintenant en mode diagnostics. Connecter le Kindle au PC (rien ne ce passe) et dans le menu, activer le réseau par USB:</p>
<blockquote><p>Misc individual diagnostics &gt; Utilities &gt; Enable USBnet</p></blockquote>
<p>Le Kindle doit s'etre enregistré en tant que périphérique USB Ethernet (Des messages l'indiquant peuvent être consultés dans /var/log/syslog )<br />
Sur votre PC, configurer l'ip de votre Kindle :</p>
<blockquote><p>ip addr add 192.168.15.241/24 dev usb0</p></blockquote>
<p>Utiliser ssh pour se connecter au Kindle:</p>
<blockquote><p><span><span><span><span><span><span>ssh root@192.168.15.244</span></span></span></span></span></span></p></blockquote>
<p>Lancer le script suivant, en remplaçant votre numero de série, pour obtenir le mot de passe.</p>
<p>gen_kindle_pass.sh</p>
<blockquote><p>#!/usr/bin/env python<br />
import hashlib<br />
print("fiona%s"%hashlib.md5("VOTRENUMERODESERIE\n".encode('utf-8')).hexdigest()[7:11])</p></blockquote>
<p>PS: <a href="http://www.mobileread.com/forums/showthread.php?t=161284" target="_blank">Lien</a> d'origine (anglais)</p>
<p><strong>Pour le Kindle Paperwhite</strong><br />
Pour le paperwhite, c'est encore plus simple et ça se passe <a href="http://www.mobileread.com/forums/showthread.php?t=198446">ici</a>, pour le remettre en configuration d'usine (et donc faire sauter le jailbreak) il suffit de réinitialiser l'appareil :</p>
<blockquote><p>Menu -&gt; Préférences -&gt; Menu -&gt; Réinitialiser l'appareil</p></blockquote>
<p>puis de réinstaller le dernier firmware <a href="http://www.amazon.com/gp/help/customer/display.html?nodeId=201064850">disponible</a>. (Dans cet ordre)</p>
<p>PS: <a href="http://www.mobileread.com/forums/showpost.php?p=2331524&amp;postcount=10">Lien</a> d'origine (anglais)</p>
