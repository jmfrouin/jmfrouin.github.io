---
layout: post
status: publish
published: true
permalink: virtualenv
title: virtualenv
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2014-06-23 09:31:05 +0200'
date_gmt: '2014-06-23 08:31:05 +0200'
categories:
- bash
- python
- django
tags: []
comments: []
---
<h2>Introduction</h2>
<p>Lors de mes premiers projets DJango j'ai foncé un peu tête la première dans le Framework, et ensuite j'ai découvert VirtualEnv, South ...<br />
Du coup je me suis dis qu'il fallait écrire un billet pour la prochaine fois que je redémarrerai un projet DJango, pour le faire proprement. En googlant je suis tombé sur le lien fournit dans la section "Références".<br />
Du coup je m'en suis fortement inspiré, pour la rédaction de ce billet.</p>
<!--more-->
<h2>Environnement virtuel Python</h2>
<p>Pour utiliser <strong>virtualenv</strong>, le petit utilitaire qui va permettre de gérer les problèmes de dépendances Python que l'on va avoir sur un projet DJango, il faut Python et bien entendu virtualenv.</p>
<h3>Installation</h3>
<p>Pour installer les deux, il faut, sur Ubuntu :</p>
<pre class="brush:shell">
sudo apt-get install python python-virtualenv
</pre>
<h3>Création de l'environnement</h3>
<p>On créé donc un environnement virtuel dans lequel on travaillera : </p>
<pre class="brush:shell">
virtualenv mon_app_env
</pre>
<h3>Utilisation</h3>
<p>On entre dedans pour travailler :</p>
<pre class="brush:shell">
source ./mon_app_env/bin/activate
</pre>
<p>Quand on à finit de travailler, on en sort : </p>
<pre class="brush:shell">
deactivate
</pre>
<p>Simple, non ? </p>
<h3>Sauvegarde des dépendances</h3>
<p>Une fois tous les paquets installés avec pip, on peut faire un dump des dépendances : </p>
<pre class="brush:shell">
pip freeze > requirements.txt
</pre>
<p>Ainsi, pip, va écrire dans un fichier les modules et leur versions associées, à utiliser (Un peu à la façon d'un composer.json en Symfony): </p>
<pre class="brush:shell">
Django==1.5.1
MySQL-python==1.2.4
PIL==1.1.7
Unipath==1.0
argparse==1.2.1
django-comments==1.0.0.b
django-debug-toolbar==0.9.4
django-gmapi==1.0.1
wsgiref==0.1.2
</pre>
<h3>Restauration des dépendances</h3>
<p>Et les réinstaller sur une machine 'vierge'</p>
<pre class="brush:shell">
pip install -r requirements.txt
</pre>
<h2>Installer DJango</h2>
<p>On oublie pas avant d'installer Django, d'entrer dans l'environnement de travail de notre application : </p>
<pre class="brush:shell">
source ./mon_app_env/bin/activate
</pre>
<p>Une fois dedans on installe tous les paquets dont on à besoin, et notamment django : </p>
<pre class="brush:shell">
pip install django
</pre>
<h2>Références</h2>
<p><a href="http://www.jeffknupp.com/blog/2012/02/09/starting-a-django-project-the-right-way/" target="_blank">Starting a Django project the right way</a></p>
