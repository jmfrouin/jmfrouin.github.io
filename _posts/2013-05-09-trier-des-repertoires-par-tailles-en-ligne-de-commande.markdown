---
layout: post
status: publish
published: true
title: Trier des répertoires par tailles en ligne de commande
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-05-09 07:16:58 +0200'
date_gmt: '2013-05-09 06:16:58 +0200'
categories:
- bash
tags: []
comments: []
---
<p>Simple, efficace :</p>
<pre class="brush:shell">root@main:/home/jm # du -hs * .[a-Z]* | sort -n</pre>
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
