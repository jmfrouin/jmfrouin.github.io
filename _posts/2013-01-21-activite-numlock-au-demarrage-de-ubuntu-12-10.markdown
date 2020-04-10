---
layout: post
status: publish
published: true
title: Activité numlock au démarrage de ubuntu 12.10
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-21 20:13:46 +0100'
date_gmt: '2013-01-21 19:13:46 +0100'
categories:
- ubuntu
- debian
tags: []
comments: []
---
<p>Cela devrait être activé par défaut ... mais non.</p>
<!--more-->
<p>La solution est simple, dans le fichier /etc/lightdm/lightdm.conf, ajouter dans la section [SeatDefaults] :</p>
<blockquote><p>greeter-setup-script=/usr/bin/numlockx on</p></blockquote>
<p>Et redémarrer le gestionnaire de connection (attention ferme toutes les applications en cours) :</p>
<blockquote><p>jmfrouin@sp35:~$sudo service lightdm restart<br />
lightdm stop/waiting<br />
lightdm start/running, process 10344</p></blockquote>
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
