---
layout: post
status: publish
published: true
title: Mise à jour automatique des paquets
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-11-26 10:32:19 +0100'
date_gmt: '2013-11-26 09:32:19 +0100'
categories:
- bash
tags: []
comments: []
---
<p>Pour que chaque jour soit appliquées les mises a jour :</p>
<pre class="brush:shell">sudo apt-get install unattended-upgrades</pre>
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
