---
layout: post
status: publish
published: true
title: Faire en sorte que new renvoie un pointeur nul en cas d'échec d'allocation
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-24 08:12:00 +0100'
date_gmt: '2013-01-24 07:12:00 +0100'
categories:
- cpp
tags: []
comments: []
---
<p>Par défaut, quand new, ne peut allouer la mémoire nécessaire à la création d'un nouvel objet, il lève l'exception <em>bad_alloc</em>.</p>
<!--more-->
<p>Pour eviter cela (et ce rapprocher du comportement de malloc) on peut l'utiliser ainsi :</p>
<pre class="brush:cpp">int *adr = new(std::nothrow) int [taille];</pre>
<p>Lors d'un echec dans l'allocation memoire il renverra, dans ce cas, un pointeur nul.</p>
<p>Cette utilisation est pratique, lorsque l'on veut porter un code source en C vers le C++ pour pas avoir à convertir les vérifications de pointeur nul.</p>
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
