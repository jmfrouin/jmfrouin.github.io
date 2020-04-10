---
layout: post
status: publish
published: true
title: Désinstaller un paquet et vérifier qu'il ne reste rien
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-08 18:54:33 +0100'
date_gmt: '2013-02-08 17:54:33 +0100'
categories:
- apt
tags: []
comments: []
---
<pre class="brush:shell">apt-get remove apache2.2-common -o pkgProblemResolver::FixByInstall=0
dpkg --status apache2.2-common
dpkg-query --showformat='${Conffiles}\n' --show apache2.2-common</pre>
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
