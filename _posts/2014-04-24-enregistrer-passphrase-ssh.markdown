---
layout: post
status: publish
published: true
title: Enregistrer sa passphrase ssh
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-04-24 08:27:32 +0200'
date_gmt: '2014-04-24 07:27:32 +0200'
categories:
- ssh
- git
tags: []
comments: []
---
<p>Si la passphrase de la clef SSH est demandée à chaque accès à cette dernière : </p>
<pre class="brush:shell">
[09:23:32] jmfrouin@xps13:.../weather (master)$ git fetch
Enter passphrase for key '/home/jmfrouin/.ssh/id_rsa': 
[09:23:38] jmfrouin@xps13:.../weather (master)$ git fetch
Enter passphrase for key '/home/jmfrouin/.ssh/id_rsa': 
</pre>
<p>Il faut demander, poliment, à ssh-agent, de s'en souvenir, pour nous: </p>
<pre class="brush:shell">
[09:23:41] jmfrouin@xps13:.../weather (master)$ ssh-add ~/.ssh/id_rsa
Enter passphrase for /home/jmfrouin/.ssh/id_rsa: 
Identity added: /home/jmfrouin/.ssh/id_rsa (/home/jmfrouin/.ssh/id_rsa)
[09:24:14] jmfrouin@xps13:.../weather (master)$ git fetch
[09:24:16] jmfrouin@xps13:.../weather (master)$ 
</pre>
<p>Voilà, votre clef SSH sera à nouveau déverrouillée au prochain reboot.</p>
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
