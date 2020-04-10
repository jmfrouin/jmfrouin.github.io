---
layout: post
status: publish
published: true
title: Déploiement d'application django (1.6.5) en Production avec git
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-07-08 21:17:44 +0200'
date_gmt: '2013-07-08 20:17:44 +0200'
categories:
- git
- django
- home
tags: []
comments: []
---
<h2>Historique</h2>
<p>16/05/2014 : Changement de 'cleanup' to 'clearsessions', car : </p>
<!--more-->
{% highlight bash %}
The `cleanup` command has been deprecated in favor of `clearsessions`.
{% endhighlight %}
<h2>Assumptions</h2>
<p>Partons du principe que l'on déploie, en production, dans <em>/var/www/mon_app</em><br />
Que la gestion des dépôts git à été faite sous gitolite.<br />
L'user de déploiement est publisher.<br />
Enfin dans git, on à deux branches (entre autre), une dans laquelle, <em>master</em>, on verse les modifications à mettre en production, et une <em>production</em>, qui contient les commits avec la configuration de production, que l'on rebase sur master avant de la pousser.</p>
<h2>Préparation / Mise en place</h2>
<p>On créé initialise donc le dépôt git :</p>
{% highlight bash %}
git init
{% endhighlight %}
<p>Depuis le poste du déployeur, on ajoute une branche production.</p>
{% highlight bash %}
git branch production
{% endhighlight %}
<p>On y fait les modifications pour la production (settings.py entre autre) et on commit.<br />
Ensuite quand des modifications seront faite sur le master, il suffira de ce remettre à jour :</p>
{% highlight bash %}
git rebase master
{% endhighlight %}
<p>Une fois cela fait il faut, initialiser la copie en production.<br />
Pour pouvoir déployer il faut avant tout ajouter la cible de déploiement pour la mise en prod :</p>
{% highlight bash %}
git remote add prod publisher@srv1.domain.tld:/var/www/mon_app
{% endhighlight %}
<p>Ne pas oublier de ce mettre sur la branche production en ... production.</p>
{% highlight bash %}
git checkout production
{% endhighlight %}
<p>Pour que le commit puisse fonctionner il faut définir :</p>
{% highlight bash %}
git config receive.denyCurrentBranch ignore
{% endhighlight %}
<p>Puis dans un second temps, mettre en place un hook git pour initialiser l'application django.<br />
On utilise le hook <em>post-update</em> c'est à dire, une fois que le dépôt à reçu la mise à jour du code.</p>
{% highlight bash %}
  {% include files/hook_django %}
{% endhighlight %}

<p>Références : <a href="https://git.wiki.kernel.org/index.php/GitFaq#non-bare" target="_blank">GitFaq non-bar repo</a> et <a href="http://utsl.gen.nz/git/post-update" target="_blank">post-update</a></p>
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
