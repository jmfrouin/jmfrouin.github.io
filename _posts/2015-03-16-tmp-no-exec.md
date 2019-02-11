---
layout: page
title: /tmp et /var/tmp avec +noexec
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2015-03-16 09:43:05 +0200'
date_gmt: '2015-03-16 08:43:05 +0200'
categories:
- bash
- debian
tags: []
comments: []
---
<h2>Introduction</h2>
<p>Pour mieux sécuriser mon serveur, et sur les conseils d'un expert sécurité, je vais monter mes partitions /tmp, et /var/tmp, avec le flag noexec.</p>

<!--more-->

<h2>Prérequis</h2>
Pour pouvoir monter mes partitions avec le flag <b>noexec</b>, c'est con mais il faut que /tmp soit une partition.
Pour ma part ce n'était pas le cas, j'ai du augmenter la taille de mon FS puis créer la partition, la formater, l'ajouter à ma fstab et enfin passer à la suite.
Pour /var/tmp on utilisera le tmpfs (FS en RAM)

<h2>On y va</h2>
<p>
Il faut modifier son fstab pour ajouter le flag noexec, aux partitions montées sur /tmp et /var/tmp
{% highlight bash %}
/dev/mapper/tmp /tmp ext4 defaults,nodev,nosuid,noexec 0  2
tmpfs /var/tmp tmpfs defaults,nodev,nosuid,noexec 0  2
{% endhighlight %}
Par contre pour que apt, ou aptitude, puisse continuer de fonctionner, il faut qu'il puisse avoir le flag noexec, lors de la mise à jour des paquets.
Du coup on créée le fichier /etc/apt/apt.conf.d/30tmpdir
</p>
{% highlight bash %}
DPkg::Pre-Invoke
{
  "mount -o remount,exec /tmp";
  "mount -o remount,exec /var/tmp";
};

DPkg::Post-Invoke
{
  "mount -o remount /tmp";
  "mount -o remount /var/tmp";
};
{% endhighlight %}
Et voila il ne reste plus qu'a tester : 

{% highlight bash %}
root@mail:~ # apt-get install vim-syntax-go
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Suggested packages:
  golang-go
Recommended packages:
  vim-addon-manager
The following NEW packages will be installed:
  vim-syntax-go
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 0 B/30.1 kB of archives.
After this operation, 141 kB of additional disk space will be used.
Selecting previously unselected package vim-syntax-go.
(Reading database ... 90535 files and directories currently installed.)
Unpacking vim-syntax-go (from .../vim-syntax-go_2%3a1.0.2-1.1_all.deb) ...
Setting up vim-syntax-go (2:1.0.2-1.1) ...
root@mail:~ # apt-get purge vim-syntax-go
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be REMOVED:
  vim-syntax-go*
0 upgraded, 0 newly installed, 1 to remove and 0 not upgraded.
After this operation, 141 kB disk space will be freed.
Do you want to continue [Y/n]? 
(Reading database ... 90548 files and directories currently installed.)
Removing vim-syntax-go ...
{% endhighlight %}

Et voilà !
