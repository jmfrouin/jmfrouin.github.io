---
layout: post
status: publish
published: true
title: Modifier la résolution du Framebuffer en passant par le noyau
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-07 20:20:09 +0100'
date_gmt: '2013-02-07 19:20:09 +0100'
categories:
- debian
tags: []
comments: []
---
<p>Argument à passer au noyau linux lors du boot :</p>
<br />
8 bits:<br />
Pour du 640x480: vga=769.<br />
Pour du 800x600: vga=771.<br />
Pour du 1024x768: vga=773.<br />
Pour du 1280x1024: vga=775.<br />
16 bits:<br />
Pour du 640x480: vga=785.<br />
Pour du 800x600: vga=788.<br />
Pour du 1024x768: vga=791.<br />
Pour du 1280x1024: vga=794.<br />
32 bits:<br />
Pour du 640x480: vga=786.<br />
Pour du 800x600: vga=789.<br />
Pour du 1024x768: vga=792.<br />
Pour du 1280x1024: vga=795.<br />
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
