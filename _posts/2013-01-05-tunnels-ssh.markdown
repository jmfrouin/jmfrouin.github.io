---
layout: post
status: publish
published: true
title: Tunnels SSH
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-05 19:11:56 +0100'
date_gmt: '2013-01-05 18:11:56 +0100'
categories:
- ssh
tags: []
comments: []
---
<p>Parfois il est utile de se connecter à un serveur de PROD, accessible uniquement via la PROD.<br />
La solution du tunnel SSH m'a bien aidé pour accéder notamment à l'interface HTTP du serveur mongo .</p>
<!--more-->
<p>&nbsp;</p>
<blockquote><p>ssh -NfL 1024:mongo.local:28017 user@vm.domain.com</p></blockquote>
<p>&nbsp;</p>
<p>Tunnel SSH depuis votre machine (port 1024) sur la machine mongo.local (port 28017) via la machine vm.domain.com. mongo.local n'étant accessible que via vm.domain.com (entre autre).</p>
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
