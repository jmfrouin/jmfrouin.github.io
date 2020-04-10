---
layout: post
status: publish
published: true
title: Stocker ses données en lieu sur
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-24 08:17:50 +0100'
date_gmt: '2013-01-24 07:17:50 +0100'
categories:
- shell
- securite
tags: []
comments: []
---
<p>Il est toujours bon d'avoir un petit fichier un peu protégé pour y stocker des données sensibles.<br />
<!--more-->
Ce script, décryptera le fichier vous permettra de l'éditer, et le recryptera sur fermeture de gedit.</p>
<pre class="brush:shell">#!/bin/sh
mastermind="/opt/Documents/mastermind"
ccrypt -d $mastermind.cpt
gedit $mastermind
rm $mastermind~
ccrypt -e $mastermind
chmod a+rw $mastermind.cpt</pre>
<p>Simple & efficace :)</p>
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
