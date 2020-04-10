---
layout: post
status: publish
published: true
title: Débugger un script bash
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-04-11 08:50:19 +0200'
date_gmt: '2014-04-11 07:50:19 +0200'
categories:
- bash
tags: []
comments: []
---
<p>Simple efficace, activer le debug d'un script bash : </p>
<p><code>set -x</code></p>
<p>Et pour le désactiver </p>
<p><code>set +x</code></p>
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
