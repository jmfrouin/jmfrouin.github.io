---
layout: page
title: RobotHash sur un Carnet d'Adresses
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-11-17 13:31:05 +0200'
date_gmt: '2014-11-17 12:31:05 +0200'
categories:
- bash
tags: []
comments: []
---
<h2>Introduction</h2>
<p>Cela fait longtemps que je trouvais mon carnet d'adresse un peu tristoune car il manquait de "photo".
J'essaie de les ajouter au fur et à mesure mais ... c'est long.</p>

<!--more-->

<p>Du coup j'ai eu l'idée de mixer le concept de <a href="http://robohash.org/" target="_blank">RobotHash</a>, qui fournit une photo en fonction d'une chaine de caractères unique, et mon serveur de carnet d'adresse sous CARD DAV.</p>
<p>Après une longue période de flemme, je l'ai finalement fait.</p>
<p>J'ai essayé plusieurs méthodes avant d'en trouver une satisfaisante</p>
<p>Finalement il faut exporter son carnet d'adresse au format VCF, disons edn Contacts.vcf</p>
<p>En m'appuyant sur le <a href="http://wiki.linuxwall.info/doku.php/en:ressources:astuces:mutt_alias_vcard" target="_blank">script d'un wiki Linux</a> comme point de départ.
Voici la version finale que j'ai utilisé :)</p>
{% highlight bash %}
  {% include files/convert.sh %}
{% endhighlight %}
<p>Une fois l'export fait il suffit de lancer le script ainsi : ./convert Contacts.vcf > Contacts2.vcf</p>
<p>Une fois le script passé le rendu est sympa : </p>
<img src="https://frouin.me/images/carddav.jpg">
<p>Oh merde ... il est sous Windows Phone !!</p>
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
