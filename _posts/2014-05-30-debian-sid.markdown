---
layout: post
status: publish
published: true
permalink: sid
title: Installation Debian SID
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-05-30 20:56:52 +0200'
date_gmt: '2014-05-30 19:56:52 +0200'
categories:
- debian
tags: []
comments: []
---
<p>En lisant cet <a href="http://lehollandaisvolant.net/linux/mintchklst/" target="_blank">article</a>, je me suis dit qu'il était plus que temps de faire la checklist des choses à faire lors de l'installation de Debian SID (sur un Dell XPS 13)</p>
<!--more-->
<h2>Introduction</h2>
<p>Pour simplifier les mise à jour, mon répertoire /home possède sa partition à lui, permettant à chaque mise à jour, de ne formater que la partition racine (/):</p>
<pre class="brush:shell">
/dev/sda1 / ext4 30Go
/dev/sda2 /home ext4 200
/dev/sda3 /media/secret ext4 20
</pre>
<p><i>La partition /media/secret n'est pas monté telle quelle mais passe par la crypttab.</i></p>
<h2>Installation</h2>
<p>L'installation se fait depuis une version <a href="https://www.debian.org/CD/netinst/" target="_blank">Stable en Installation par le réseau</a><br />
Ensuite on met à jour le fichier <i>/etc/apt/sources.list</i> avec</p>
<pre class="brush:shell">
# stable
deb http://ftp.fr.debian.org/debian/ stable main contrib non-free
#deb-src http://ftp.fr.debian.org/debian/ stable main contrib non-free

# stable security
deb http://security.debian.org/ stable/updates main contrib non-free
#deb-src http://security.debian.org/ stable/updates main contrib non-free

# stable volatile
deb http://ftp.fr.debian.org/debian/ squeeze-updates main non-free contrib
#deb-src http://ftp.fr.debian.org/debian/ squeeze-updates main non-free contrib


# testing
deb http://ftp.fr.debian.org/debian/ testing main contrib non-free
#deb-src http://ftp.fr.debian.org/debian/ testing main contrib non-free

# testing security
deb http://security.debian.org/ testing/updates main contrib non-free
#deb-src http://security.debian.org/ testing/updates main contrib non-free


# sid
deb http://ftp.fr.debian.org/debian/ sid main contrib non-free
#deb-src http://ftp.fr.debian.org/debian/ sid main contrib non-free

# sid multimedia
deb http://www.deb-multimedia.org sid main non-free
#deb-src http://www.deb-multimedia.org sid main non-free
</pre>
<p>Et dans <i>/etc/apt/preferences</i></p>
<pre class="brush:shell">
Package: *
Pin: release o=Unofficial Multimedia Packages
Pin-Priority: 100
</pre>
<p>Une fois cela fait on lance <b>LA</b> mise à jour : </p>
<pre class="brush:shell">
apt-get update && apt-get dist-upgrade
</pre>
<p>Jusque là j'évite de me connecter avec mon user standard, pour éviter de foutre le bordel dans les répertoires contenant les préférences des applications (/home/user/.*) avec des versions différentes (Celle de la version Stable) de celles que j'utilise (sous SID).<br />
Une fois la mise à jour terminée, en général, j'installe les paquets additionnels puis je redémarre histoire de prendre en compte le nouveau noyau ...</p>
<h2>Paquets additionnels</h2>
<pre class="brush:shell">
apt-get install cmake vim git gitk sabnzbdplus
</pre>
<h2>Compilation du noyal</h2>
<pre class="brush:shell">
su
apt-get install kernel-package git libncurses5-dev
cd /usr/src
wget -c https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.4.tar.xz
xz -d linux-3.14.4.tar.xz -c | tar x
cd linux-3.14.4
make-kpkg --config menuconfig --initrd --jobs 4 kernel_image modules
#Lors de la configuration, dans la section processeurs, 
#choisir le mode "Full Preemptive" et la fréquence de "1000Hz"
#pour une réaction optimale.
cd ..
dpkg -i *Custom*.deb
</pre>
<h2>CryptTab</h2>
<p>Ayant une <a href="http://frouin.me/truecrypt/" target"=_blank">partition cryptée avec LUKS</a> il faut que je l'ajoute à la crypttab :</p>
<pre class="brush:shell">
secret /dev/sda2 none luks
</pre>
<h2>/etc/fstab</h2>
<p>On ajout le montage de la partition décryptée par la crypttab dans fstab :</p>
<pre class="brush:shell">
/dev/mapper/secret /media/secret ext4 defaults 0 2
</pre>
<p>On ajoute les options <b>"noatime,nodiratime"</b> aux paramètres de chaque partition.</p>
<pre class="brush:shell">
/dev/mapper/secret /media/secret ext4 defaults,noatime,nodiratime 0 2
</pre>
<h2>Hardware : Dell XPS 13</h2>
<h3>Wifi</h3>
<p>Il faut installer un driver propriétaire : </p>
<pre class="brush:shell">
apt-get install firmware-iwlwifi
</pre>
<h3>Touchpad</h3>
<p>Pour récupérer le touchpad (défilement à 2 doigts), etc ...<br />
Il faut blacklister le module i2c-hdi, pour ce faire on créé un fichier </p>
<pre class="brush:shell">
/etc/modprobe.d/blacklist_i2c_hid.conf
</pre>
<p>dans lequel on met : </p>
<pre class="brush:shell">
blacklist i2c_hid
</pre>
<h3>Paquets additionnels</h3>
<p>Pour la gestion de l'énergie : apt-get install laptop-mode-tools<br />
Pour la gestion du SSD : apt-get install smartmontools</p>
<h2>A tester</h2>
<p>Laisser la carte Wifi accéder aux canaux européens :</p>
<pre class="brush:shell">
sudo iw reg set FR
</pre>
<p>Empêcher APT de mettre les paquets en cache sur le disque</p>
<pre class="brush:shell">
sudo sh -c "echo 'Dir::Cache \"\";\nDir::Cache::archives \"\";' >> /etc/apt/apt.conf.d/02nocache"
</pre>
<h2>References</h2>
<p><a href="http://lehollandaisvolant.net/linux/mintchklst/" target="_blank">Le blog m'ayant donné l'idée de faire moi aussi ma checklist</a><br />
<a href="https://wiki.debian.org/InstallingDebianOn/Dell/Dell%20XPS%2013" target="_blank">Wiki Debian Dell XPS 13</a><br />
<a href="https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-synaptics/+bug/1263319" target="_blank">Bug Touchpad</a><br />
<a href="http://www.isalo.org/wiki.debian-fr/index.php?title=L%27etiquetage_de_paquets_via_le_fichier_/etc/apt/preferences#Sid" target="_blank">sources.list pour SID</a></p>
<!-- Matomo -->
<script type="text/javascript">
  var _paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//stats.frouin.me/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<!-- End Matomo Code -->
