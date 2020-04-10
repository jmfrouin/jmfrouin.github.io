---
layout: post
status: publish
published: true
title: Gestion des paquets, avec apt, sous Debian
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-04 19:25:31 +0100'
date_gmt: '2013-02-04 18:25:31 +0100'
categories:
- apt
- bash
- home
tags: []
comments: []
---
<h2>Introduction</h2>
<em>Ceci est un vieux document que j'avais fait au début de ma découverte de GNU/Linux.<br />
Je l'ai rafraîchis et je le garde car mêmes les bases, peuvent servirent un jour.</em>
<!--more-->
Il faut savoir que le gestionnaire de paquet utilise le fichier des sources (fichier dans lequel il va chercher la liste des paquetages disponibles) qui se trouve dans <em>/etc/apt/sources.list</em>.
Le fichier <em>/etc/apt/sources.list</em> contenait avant tous les dépôts utilisés. Sur les distributions modernes est apparu le répertoire <em>/etc/apt/sources.list.d</em> permettant de mieux organiser ses sources, en les scindant en plusieurs fichiers.
Mon fichier sources.list sur Debian SID (je conserve les sources de l'OS en lui même):
{% highlight bash %}
  {% include files/sources.list %}
{% endhighlight %}
Et dans le répertoire <em>/etc/apt/sources.list.d</em>, je place les sources des logiciels additionnels que j'installe sur ma distribution :
Pour les paquets bumblebee <em>/etc/apt/sources.list.d/bumblebee.list</em>:
<pre class="brush:shell">deb http://suwako.nomanga.net/debian sid main contrib
deb-src http://suwako.nomanga.net/debian sid main</pre>
Pour les paquets dotdeb <em>/etc/apt/sources.list.d/dotdeb.list</em>:
<pre class="brush:shell">deb http://packages.dotdeb.org squeeze all
deb-src http://packages.dotdeb.org squeeze all</pre>
Pour le client owncloud <em>/etc/apt/sources.list.d/owncloud.list</em>:
<pre class="brush:shell">deb http://download.opensuse.org/repositories/isv:ownCloud:devel/Debian_6.0/ /</pre>
<h2>Mise à jour des paquets disponibles</h2>
Une fois qu'une modification à été apportée au fichier de sources, il faut mettre à jour la liste des paquets disponibles.<br />
Utiliser
{% highlight bash %}
apt-get update
{% endhighlight %}
pour la mettre à jour.
<h2>Mise à niveau du système</h2>
Une fois la liste des paquets à jour, un
{% highlight bash %}
apt-get upgrade
{% endhighlight %}
permet la mise à jour de votre distribution (sans mise à jour de numéro de version majeur),
{% highlight bash %}apt-get dist-upgrade{% endhighlight %}
une mise à jour vers la dernière version stable disponible.<br />
Sur ubuntu, la commande dist-upgrade n'est utilisée que 2 fois par an lors de la sortie d'une nouvelle version. (Pour debian, le passage de sarge à etch, à pris 21 mois)<br />
Avec la commande
{% highlight bash %}apt-show-revisions -u{% endhighlight %}
on peut obtenir une information sur les numéros de version avant et après un
{% highlight bash %}apt-get update{% endhighlight %}
<h2>Nettoyage du système</h2>
En fait les paquets mis à jour sont téléchargés puis installés. Une fois l'installation correctement faite rien ne les efface. C'est pourquoi une fois la mise à jour effectuée un
{% highlight bash %}apt-get clean{% endhighlight %}
permet de supprimer le cache des paquets.<br />
Il est possible d'utiliser la commande
{% highlight bash %}apt-get autoremove{% endhighlight %}
pour supprimer les paquets inutiles.<br />
Quelques autres outils à essayer : <em>deborphan</em>, <em>cruft</em>.
<h2>Recherche de paquet</h2>
Pour rechercher le paquet pidgin (Ancien gaim) :
{% highlight bash %}apt-cache search pidgin{% endhighlight %}
On peut combiner deux mots (ou plus) pour limiter les résultats de la recherche. Il est aussi possible d'utiliser les expression régulières.
<h2>Ajouter un paquet</h2>
Pour installer un paquet 3 façons de faire :
<h3>Directement depuis une source de paquets</h3>
Pour installer le paquet pidgin depuis une des sources de paquets :
{% highlight bash %}apt-get install pidgin{% endhighlight %}
Il est parfois utile d'utiliser l'option <em>--reinstall</em> en cas de problème. Une autre option utile, est <em>--download-only</em> permettant de télécharger uniquement le paquet sans l'installer.
<h3>Depuis un fichier .deb ou .rpm</h3>
Installer un fichier deb ce fait en utilisant
{% highlight bash %}dpkg -i paquet.deb{% endhighlight %}
Avant de pouvoir installer un fichier RPM (format des paquets RedHat et Mandriva) sur debian, il faut le convertir en .deb:<br />
Pour ce faire, il faut utiliser l'utilitaire alien (alien - Installation de paquets non natifs avec dpkg)
{% highlight bash %}apt-get install alien{% endhighlight %}
puis faire :
{% highlight bash %}alien fichier.rpm{% endhighlight %}
<h3>Depuis les sources</h3>
Pour pouvoir installer proprement (Il faut passer par la construction d'un paquet deb ou rpm, pour que tous les fichiers installés soient connus (pour être supprimés)). un logiciel dont on ne possède que les sources il suffit d'utiliser l'outil <em>checkinstall</em>. Checkinstall se substitue à la commande <em>make install</em> et créé à ce moment un paquet qu'il est ensuite possible d'installer avec la commande <em>dpkg</em> d'un système debian (Donc Ubuntu aussi).
Ainsi avec :
<pre class="brush:shell">./configure
make
sudo checkinstall
sudo spkg -i package.deb</pre>
On possède un moyen simple, propre et efficace d'ajouter un paquet à notre distribution et ce depuis les sources.
<h2>Obtenir des informations détaillés sur un paquet</h2>
Pour obtenir des informations un peu plus importantes que celles retournées par search : 
{% highlight bash %}apt-cache show paquet{% endhighlight %}
<h2>Forcer l'installation d'un paquet</h2>
{% highlight bash %}
apt-get install -f -o Dpkg::Options::="--force-overwrite" libaudio2
{% endhighlight %}
<h2>Suppression d'un paquet</h2>
Pour supprimer pidgin : 
{% highlight bash %}apt-get remove paquet{% endhighlight %}
ou
{% highlight bash %}apt-get purge paquet{% endhighlight %}
(supprime aussi les fichiers de settings en général le répertoire .paquet dans le répertoire home).
<h2>Récuperer les codes sources d'un paquet</h2>
Grâce à la commande 
{% highlight bash %}apt-get source pidgin{% endhighlight %}
il est possible de récupérer les sources de pidgin dans le répertoires courant (apt s'occupe d'appliquer les patchs spécifiques à la distribution).
<h2>Analyse des dépendances</h2>
Pour obtenir la liste des dépendances d'un paquet : 
{% highlight bash %}apt-rdepends pidgin{% endhighlight %}
<h2>Récupérer une clé inconnue</h2>
Si le message d'erreur suivant :
{% highlight bash %}Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 3F64E067D0845D62{% endhighlight %}
apparait lors d'un <em>apt-get update</em>, il suffit d'importer la clef.<br />
Récupération de la clef:
{% highlight bash %}gpg --keyserver hkp://subkeys.pgp.net --recv-keys 3F64E067D0845D62{% endhighlight %}
Ajout de la clef au trousseau
{% highlight bash %}gpg --export --armor 3F64E067D0845D62 | sudo apt-key add -{% endhighlight %}
<h2>Retrouver un fichier</h2>
Il faut d'abord installer le paquet qui permettre de recherche un fichier manquant
{% highlight bash %}sudo apt-get install apt-file{% endhighlight %}
Ensuite, tout simplement :
{% highlight bash %}apt-file search fichier{% endhighlight %}
Qui vous retourne, si il le trouve, le paquet correspondant.
<h2>Duplication des paquets installés</h2>
Sauvegarde de la liste des paquets installés sur un système :
{% highlight bash %}dpkg --get-selections > packages.list{% endhighlight %}
Réinstallation la liste des paquets sur une autre machine :
{% highlight bash %}dpkg --set-selections < packages.list{% endhighlight %}
Puis pour les installer (sur l'autre machine) :
{% highlight bash %}apt-get dselect-upgrade<{% endhighlight %}
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
