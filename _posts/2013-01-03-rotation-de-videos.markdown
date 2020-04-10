---
layout: post
status: publish
published: true
title: Rotation de vidéos avec mencoder
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-03 16:47:43 +0100'
date_gmt: '2013-01-03 15:47:43 +0100'
categories:
- debian
tags: []
comments: []
---
<p style="text-align: left;">Rotation à 90° horaire :</p>
<blockquote><p>mencoder -oac copy -ovc lavc $1 -o $1_rotated.avi</p></blockquote>
<p>Anti horaire :</p>
<blockquote><p>mencoder -oac copy -ovc lavc $1 -o $1_rotated.avi -vf rotate=2</p></blockquote>
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
