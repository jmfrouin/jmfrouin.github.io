---
layout: post
status: publish
published: true
title: Cloner tous les repos GIT contenus dans le fichier gitolite.conf de gitolite-admin
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-09-09 15:06:49 +0200'
date_gmt: '2013-09-09 14:06:49 +0200'
categories:
- git
tags: []
comments: []
---
<pre class="brush:shell">#!/bin/bash

for ex in `cat gitolite.conf | grep repo`
do
  if [ $ex == "repo" ]; then
    continue
  fi
  git clone gitolite@machine:${ex}
done</pre>
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
