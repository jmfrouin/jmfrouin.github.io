---
layout: post
status: publish
published: true
title: Configurer SSH
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-07 19:18:18 +0100'
date_gmt: '2013-01-07 18:18:18 +0100'
categories:
- ssh
tags: []
comments: []
---
<p>Pour pouvoir se connecter, automatiquement, en tant que user sur un serveur précis, et utiliser une clef privée précise.
<!--more-->
Il faut aller dans le fichier ~/.ssh/config :</p>
<blockquote><p>Host *.domain.com<br />
IdentityFile /home/user/.ssh/id_rsa.user<br />
User user</p></blockquote>
<p>Cela permet, de gérer plusieurs pool de machine simplement.</p>
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
