---
layout: post
status: publish
published: true
title: Copier ses clefs SSH sur un serveur distant
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-05 19:19:38 +0100'
date_gmt: '2013-01-05 18:19:38 +0100'
categories:
- ssh
tags: []
comments: []
---
<p>Une commande, simple et rapide pour copier ses clefs SSH sur un serveur distant :</p>
<blockquote><p>ssh-copy-id serveur.com</p></blockquote>
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
