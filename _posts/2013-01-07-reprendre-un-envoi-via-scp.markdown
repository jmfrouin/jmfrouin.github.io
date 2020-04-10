---
layout: post
status: publish
published: true
title: Reprendre un envoi via scp
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-07 12:59:43 +0100'
date_gmt: '2013-01-07 11:59:43 +0100'
categories:
- ssh
tags: []
comments: []
---
<p>Avant tout il faut exporter une variable globale :</p>
<blockquote><p>export RSYNC_RSH=ssh</p></blockquote>
<p>Ensuite on copie le(s) fichier(s) normalement via scp </p>
<blockquote><p>scp file_to_transfer user@remotehost:/path/remote_file</p></blockquote>
<p>Et si ça coupe, on relance avec</p>
<blockquote><p>rsync --partial file_to_transfer user@remotehost:/path/remote_file</p></blockquote>
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
