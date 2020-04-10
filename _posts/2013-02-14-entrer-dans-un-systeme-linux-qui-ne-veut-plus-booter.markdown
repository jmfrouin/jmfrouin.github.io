---
layout: post
status: publish
published: true
title: Entrer dans un système linux qui ne veut plus booter
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-14 22:00:52 +0100'
date_gmt: '2013-02-14 21:00:52 +0100'
categories:
- debian
tags: []
comments: []
---
<p>Démarrer le PC à l'aide d'un live CD/DVD/USB GNU/Linux.<br />
Depuis le terminal, monter la partition contenant le système sur lequel vous souhaitez démarrer.</p>
<p>Par exemple </p>
<blockquote><p>mount /dev/hda1 /media/linux</p></blockquote>
<p>montera la première partition du disque hda sur le point de montage /media/linux.<br />
En supposant que le système est monté sur /media/linux, il ne reste à faire qu'un </p>
<blockquote><p>chroot /media/linux /bin/bash</p></blockquote>
<p>Le deuxième argument de la commande <em>chroot</em> est le shell qui sera lancé lors du changement de système.<br />
Une fois la commande exécutée avec succès, vous êtes dans votre système GNU-Linux.</p>
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
