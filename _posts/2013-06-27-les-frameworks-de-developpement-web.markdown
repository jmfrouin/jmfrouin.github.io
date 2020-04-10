---
layout: post
status: publish
published: true
title: Frameworks de développement web
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-06-27 19:40:14 +0200'
date_gmt: '2013-06-27 18:40:14 +0200'
categories:
- symfony
- django
- ruby
tags: []
comments:
- id: 252
  author: Tim
  author_email: tim@amicalement-web.net
  author_url: ''
  date: '2013-09-26 13:27:02 +0200'
  date_gmt: '2013-09-26 12:27:02 +0200'
  content: "En fait en Symfony aussi il est possible de créer une app grâce à composer:\r\n\r\nphp
    composer create-project symfony/framework-standard-edition path/to/install"
- id: 253
  author: Jean-Michel Frouin
  author_email: jm@frouin.me
  author_url: ''
  date: '2013-09-26 14:03:10 +0200'
  date_gmt: '2013-09-26 13:03:10 +0200'
  content: "En effet, merci pour l'info.\r\nJ'ai mis à jour l'article."
---
<p>Que ce soit en PHP (avec Symfony 2), en python (avec Django) ou en ruby, petit tour d'horizon des frameworks de développement web !</p>
<!--more-->
<h2>Les frameworks de développement web</h2>
<p>Cliquez sur le logo du framework pour atteindre la page d'accueil du framework :</p>
<p><a href="http://symfony.com/" target="_blank"><img alt="" src="http://symfony.com/images/common/logo/logo_symfony_header.png" /></a>
<a href="https://www.djangoproject.com/" target="_blank"><img alt="" src="https://www.djangoproject.com/s/img/site/hdr_logo.b19c5e60269d.gif" /></a>
<a href="http://rubyonrails.org/" target="_blank"><img alt="" src="http://rubyonrails.org/images/rails.png" /></a></p>
<p>&nbsp;</p>
<h2>Accès à la console</h2>
<pre class="brush:shell">app/console</pre>
<p>en symfony</p>
<pre class="brush:shell">manage.py</pre>
<p>en django</p>
<pre class="brush:shell">rails console</pre>
<p>en ruby</p>
<h2>Créer une nouvelle application</h2>
<p>En symfony, en passant par composer : </p>
<pre class="brush:shell">./composer create-project symfony/framework-standard-edition path</pre>
<p>Merci à tim, pour l'information.</p>
<p>En django :<br />
<br/></p>
<pre class="brush:shell">manage.py startproject</pre>
<p>puis</p>
<pre class="brush:shell">manage.py startapp</pre>
<p>Et enfin</p>
<pre class="brush:shell">rails new app_name</pre>
<p>en ruby.</p>
<h2>Les assets</h2>
<p>Les voir</p>
<pre class="brush:shell">app/console assetic:dump</pre>
<p>en symfony, puis les convertir en static</p>
<pre class="brush:shell">app/console assets:install</pre>
<p>Les voir</p>
<pre class="brush:shell">manage.py findstatic</pre>
<p>en django, puis les convertir en static</p>
<pre class="brush:shell">manage.py collectstatic</pre>
<p>Et enfin</p>
<pre class="brush:shell">rails generate</pre>
<p>en ruby, qui vous proposera ce que vous voulez régénérer (et notamment les assets)</p>
<h2>Synchroniser les models avec la base de données</h2>
<pre class="brush:shell">app/console doctrine:schema:create</pre>
<p>puis</p>
<pre class="brush:shell">app/console doctrine:schema:update</pre>
<p>en symfony</p>
<pre class="brush:shell">manage.py syncdb</pre>
<p>en django<br />
Cela passera par</p>
<pre class="brush:shell">rails db</pre>
<p>en ruby</p>
<h2>Serveur web</h2>
<p>Lancer un serveur web permettant de tester son application au cours du développement on utilisera :</p>
<pre class="brush:shell">app/console server:run</pre>
<p>en symfony</p>
<pre class="brush:shell">manage.py runserver</pre>
<p>en django</p>
<pre class="brush:shell">rails server</pre>
<p>en ruby</p>
<h2>Nettoyage</h2>
<pre class="brush:shell">app/console cache:clear</pre>
<p>en symfony</p>
<pre class="brush:shell">manage.py clearsessions</pre>
<p>et</p>
<pre class="brush:shell">manage.py cleanup</pre>
<p>en django<br />
Cela passera par</p>
<pre class="brush:shell">rake</pre>
<p>en ruby</p>
