---
layout: post
status: publish
published: true
title: Envoyer le contenu d'un répertoire par mail !
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-05-03 15:13:05 +0200'
date_gmt: '2014-05-03 14:13:05 +0200'
categories:
- shell
- bash 
tags: []
comments: []
---
<p>Ca faisait longtemps que je devais le faire.<br />
Un ami à eu besoin, du coup je l'ai écris rapidement.<br />
Voici donc un script pour envoyer tous les fichiers contenu dans un répertoire par mail, utilisant uuenview pour l'encodage uuencode, et la commande mail pour l'envoie pur.</p>
<p>Il faudra revenir dessus, mais en l'état il fonctionne :</p>
<pre class="brush:shell">#!/bin/bash

IFS=$(echo -en "\n\b")

for file in `ls`; 
do
  echo "Envoi du fichier $file"
  (uuenview -u $file) | mail -s "$file" user@mail.tld
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
