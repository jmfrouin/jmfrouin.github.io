---
layout: post
status: publish
permalink: sudoers
published: true
title: Conserver le ticket sudo entre deux terminaux
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-05-05 12:51:11 +0200'
date_gmt: '2014-05-05 11:51:11 +0200'
categories:
- shell
- bash
tags: []
comments: []
---
<p>Si vous utilisez souvent plusieurs terminaux, vous savez que dans chaqu'un il faut retaper le mot de passe si on utilise, sudo.</p>
<p>En ajoutant :</p>
<pre class="brush:shell">Defaults env_reset,!tty_tickets</pre>
<p>Dans le fichier /etc/sudoers, il ne sera plus nécessaire de le faire qu'une fois pour tous les terminaux.<br />
Pratique !</p>
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
