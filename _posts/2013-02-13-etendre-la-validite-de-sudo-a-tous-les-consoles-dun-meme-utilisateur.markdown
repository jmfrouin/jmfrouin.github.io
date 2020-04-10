---
layout: post
status: publish
published: true
title: Etendre la validité de sudo à tous les consoles d'un même utilisateur
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-13 07:33:36 +0100'
date_gmt: '2013-02-13 06:33:36 +0100'
categories:
- shell
tags: []
comments: []
---
<p>sudo c'est pas mal mais quand on utilise plusieurs terminaux, il faut à nouveau taper son mot de passe au moins une fois par sudo par terminal.<br />
En fait on peut transmettre l'élévation d'un user, via sudo, en passant par les tickets tty.</p>
<p>Dans le fichier <em>/etc/sudoers</em>, on ajoute la ligne :</p>
<pre class="brush:shell">Defaults !tty_tickets</pre>
<p>ou mieux :</p>
<pre class="brush:shell">Defaults env_reset, !tty_tickets</pre>
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
