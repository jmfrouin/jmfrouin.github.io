---
layout: post
status: publish
published: true
title: Ajouter des clefs gpg de dêpots manquantes
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-22 19:06:31 +0100'
date_gmt: '2013-01-22 18:06:31 +0100'
categories:
- gpg
- apt
tags: []
comments: []
---
<p>Parfois lors d'un apt-get update, il nous manque les clefs de certains dépôts :</p>
<!--more-->
<blockquote><p>Fetched 872 kB in 11s (76.9 KB/s)<br />
Reading package lists... Done<br />
W: GPG error: http://depot.domain.com squeeze Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY ID_KEY</p>
</blockquote>
<p>Il suffit simplement de demander à un des nombreux serveurs de clefs de nous la fournir, puis de l'importer dans apt-get via apt-key :</p>
<blockquote><p>gpg --keyserver keys.gnupg.net --recv-key ID_CLEF<br />
gpg -a --export ID_CLEF | sudo apt-key add -</p></blockquote>
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
