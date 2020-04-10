---
layout: post
status: publish
published: true
permalink: gitconfig
title: Configuration de git
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-31 20:30:53 +0100'
date_gmt: '2013-01-31 19:30:53 +0100'
categories:
- git
- home
tags: []
comments:
- id: 26
  author: Equipe GitStack
  author_email: gitstack@yahoo.com
  author_url: http://gitstack.com
  date: '2013-02-03 22:34:06 +0100'
  date_gmt: '2013-02-03 21:34:06 +0100'
  content: "Bonsoir,\r\n\r\nBeau rappel sur la configuration de ce cher outil qu'est
    Git.\r\n\r\nBonne continuation sur ce bel outil.\r\n\r\n--\r\nEquipe GitStack"
---
<p>Toutes les commandes suivantes, ne font que, ajouter des lignes au fichier ~/.gitconfig.</p>
<!--more-->
<h2>Définir le rebase par défaut</h2>

{% highlight bash %}
git config --global --bool pull.rebase true
{% endhighlight %}

et activer la commande rerere : 
{% highlight bash %}
git config --global rerere.enabled true
{% endhighlight %}


<h2>Ajouter la couleur à git</h2>

{% highlight bash %}
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
{% endhighlight %}

<h2>Créer des raccourcis</h2>

{% highlight bash %}
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
{% endhighlight %}

<p>Ensuite un git co permettra de faire un checkout.</p>
<h2>Définir son identité</h2>
<p>Définir son nom :</p>

{% highlight bash %}
git config --global user.name "Jean-Michel Frouin"
{% endhighlight %}

<p>Définir son email :</p>

{% highlight bash %}
git config --global user.email jm@frouin.me
{% endhighlight %}

<h2>Définir ses outils</h2>
<p>Son éditeur de texte:</p>

{% highlight bash %}
git config --global core.editor "vim"
{% endhighlight %}

<p>Son comparateur de commit:</p>

{% highlight bash %}
git config --global merge.tool "vimdiff"
{% endhighlight %}

<h2>Ignorer des fichiers</h2>

{% highlight bash %}
echo ".svn" ~/.gitignore
git config --global core.excludesfile ~/.gitignore
{% endhighlight %}

<h2>Cloner un dépôt en ssh</h2>

{% highlight bash %}
git clone user@machine.domain.com:~/project
{% endhighlight %}

<p>Va créer le répertoire guide contenant le dépôt.</p>
<p>Sur port non standard:<br />
Editer le fichier ~/.ssh/config</p>
<p>Et mettre :</p>

{% highlight bash %}
Host machine.domain.com
  Port 1234
{% endhighlight %}

<h2>Configurer les couleurs</h2>
<p>Dans le fichier ~/.gitconfig :</p>

{% highlight bash %}
[color]
branch = auto
diff = auto
status = auto

[color "branch"]
current = yellow reverse
local = yellow
remote = green

[color "diff"]
meta = yellow bold
frag = magenta bold
old = red bold
new = green bold

[color "status"]
added = yellow
changed = green
untracked = cyan
{% endhighlight %}

<p>NB: Largement inspiré de : http://www.kernel.org/pub/software/scm/git/docs/tutorial.html</p>
<p>Bonus mon fichier .gitconfig</p>
{% highlight bash %}
  {% include files/gitconfig %}
{% endhighlight %}
<p>Pour de plus amples informations sur git, <a href="http://frouin.me/git/">un glossaire git</a> est disponible.</p>
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
