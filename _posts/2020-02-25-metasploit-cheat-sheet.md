---
layout: post
status: publish
published: true
permalink: metasploit
title: MetaSploit Cheat Sheet
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2020-02-25 21:47:05 +0200'
date_gmt: '2020-02-25 21:47:05 +0200'
categories:
- kali
tags: []
comments: []
---
<h2>Introduction</h2>
<p> My notes when using msfconsole.</p>

<!--more-->
<h2>autoroute</h2>
Quand une session meterpreter est ouverte sur un host distant.

On ajoute une route pour pivoter facilement : 

{% highlight bash %}
run autoroute -s 10.10.10.0/24
{% endhighlight %}

Pour voir les routes en place : 

{% highlight bash %}
run autoroute -p
{% endhighlight %}
<h2>Sources</h2>
<a href="http://www-lor.int-evry.fr/~pascal/CoursDNS/NOTES-COURS_eng/exemple.html" target="_blank">Cours DNS</a>
<br/>
<a href="http://linuxfr.org/forums/astucesdivers/posts/comment-verifier-les-enregistrements-spf-d-un-nom-de-domaine" target="_blank">Linuxfr.org</a>
<br/>
<a href="https://smittysthoughts.wordpress.com/2010/03/09/the-easy-way-to-make-dig-more-useful-digrc/" target="_blank">.digrc</a>
