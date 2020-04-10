---
layout: post
status: publish
permalink: gitbash
published: true
title: Intégration de git dans bash
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-06-03 19:31:32 +0200'
date_gmt: '2013-06-03 18:31:32 +0200'
categories:
- git
- bash
- home
tags: []
comments: []
---
<p>L'intégration de git avec bash permet d'ajouter l'information de la branche courante (entre parenthèses) dans le prompt du shell (PS1)</p>
<!--more-->
{% highlight bash %}
jmfrouin@ux32a:~/dev/config-files (master)$
{% endhighlight %}
<p>J’utilise deux méthodes différentes : </p>
<p>La première fonctionne aussi sous Mac :</p>
{% highlight bash %}
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^\*]/d' -e 's/\* \(.\*\)/ ()/'
}                                                                                                                                                                           
PS1="${debian_chroot:+($debian_chroot)}\[33[01;32m\]\u@\h\[33[00m\]:\[33[01;34m\]\w\[33[0;33m\]\$(parse_git_branch)\[33[00m\]\[33[00m\]\$ "
{% endhighlight %}
<p>Et la seconde que j'utilise actuellement en bash :</p>
{% highlight bash %}
__git_ps1 ()
{ 
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf " (%s)" "${b##refs/heads/}";
    fi
}
PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[0;33m\]`__git_ps1`\[\033[00m\]\$"
{% endhighlight %}
<p>Simple, efficace ! </p>
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
