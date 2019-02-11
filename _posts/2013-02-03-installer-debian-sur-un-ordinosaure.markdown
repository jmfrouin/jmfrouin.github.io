---
layout: post
status: publish
published: true
title: Installer debian sur un ordinosaure
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-03 08:03:29 +0100'
date_gmt: '2013-02-03 07:03:29 +0100'
categories:
- debian
tags: []
comments:
- id: 28
  author: Stef
  author_email: stephaniezen13@gmail.com
  author_url: http://Website
  date: '2013-02-04 16:28:20 +0100'
  date_gmt: '2013-02-04 15:28:20 +0100'
  content: "Je plussois et je bravotte ! \r\nParce qu'il y a un bel effort de documentation
    de procédures qui étaient longues et fastidieuses et qui ont dû être le théâtre
    de quelques nuits blanches ;-)"
---
<h2>Résumé</h2>
<p><em>Mise à jour : Ce texte à plus de 10 ans, j'ai recopié ce texte tel que, en mettant à jour les urls utilisées.</em></p>
<p>Ce document détaille l'installation d'une debian 4.0 etch (La dernière version stable à l'heure où j'écris ce texte et, connaissant debian, pour encore quelques années.) sur un ordinateur ultra-portable le Libretto 100CT de Toshiba (1999). Comme tout ultra-portable il ne possède ni lecteur CD, ni lecteur de disquette, ni port USB. Livré (acheté sur ebay) avec windows 98 installé sur le disque dur de 2Go. Le portable est équipé de 64Mo de RAM.</p>
<!--more-->
<h2>Introduction</h2>
<p>Sur un ultra-portable qui ne possède que Windows et qui ne possède ni CD, disquette ou USB, différentes méthodes existent mais aucune ne me convenait pour diverses raisons (l'OS installé était Windows 98 première édition et ne possédait pas de driver pour ma carte 3C589, enfin, si, il en possédait un, mais sur le CD :D et sans lecteur CD ...). Finalement, j'ai essayé de récapituler la manipulation, au moins pour ne pas l'oublier et peut être pour aider quelqu'un.</p>
<p>Une méthode, proche de celle ci, consiste à démonter le disque dur de l'ultra-portable et à le monter sur un autre PC (portable, ou PC de bureau, en utilisant une nappe 2"5 vers 3"5) pour y installer Linux. Cette méthode ne me plaît pas car l'installation se fait effectivement sur le disque dur de l'ultra-portable, mais la détection du matériel se fait sur la machine sur laquelle on installe la distribution et non sur l'ultra-portable. Aussi, lorsque l'on réinsère le disque dur dans l'ultra-portable, il faut tout reconfigurer à la main.</p>
<p>Important : La procédure détaillée ici est relativement simple mais nécessite de démonter le disque dur de votre portable. Si le portable n'incorpore pas de lecteur CD ou de disquette, c'est soit qu'il est extrêmement vieux, soit qu'il s'agit d'un ultra-portable. Dans le cas d'un ultraportable, démonter le disque peut vite devenir un enfer (je pense, notamment, au Libretto L5, qu'il faut démonter entièrement pour pouvoir accéder au disque dur). Donc, cette procédure vise plutôt les personnes ayant accès rapidement au disque dur de leur portable. De plus, pour cette procédure, un câble IDE vers USB a été utilisé (un tel cable coûte 40€ dans les grands distributeurs de matériel informatique et permet de relier un disque dur IDE 3"5, IDE 2"5 ou SATA à votre PC via un connecteur USB).</p>
<h2>Défragmenter le disque dur (nécessite Windows)</h2>
<p>Windows utilise un système de fichier (FAT16 ou FAT32) qui fragmente beaucoup. Un disque trop fragmenté ne peut pas être redimensionné. Donc, si le disque est trop fragmenté, il faut défragmenter le disque dur. On peut le faire directement sur l'ultra-portable en utilisant l'outil défragmenteur de disque de Windows (Démarrer-&gt;Programmes-&gt;Accessoires-&gt;Outils système-&gt;Défragmenteur de disque.). La défragmentation du disque supportant le système d'exploitation par le système d'exploitation n'est pas très efficace car Windows lui-même bloque certains fichiers qui ne pourront pas être déplacés pendant la défragmentation. Donc, on connecte le disque dur de l'ultra-portable à un PC sous Windows. Une fois le disque dur détecté, il suffit de lancer le défragmenteur de disque et de le lancer sur le disque dur USB. L'opération peut être longue en fonction du taux de fragmentation du disque dur. Voilà, le disque est défragmenté. On va enfin pouvoir faire une place pour Linux!</p>
<h2>Redimensionner la partition FAT32</h2>
<p>Maintenant, il va falloir faire une place à Linux sur le disque. Plusieurs méthodes existent là encore (il est possible d'utiliser Partition Magic, Hardk Disk Manager directement sous Windows si on préfère.). Mon choix s'est arrêté sur gparted que j'ai déjà utilisé et que je trouve plus efficace que Partition Magic (peut-être car gparted fonctionne sous Linux :D). Il est vrai que gparted ne fonctionne que sous Linux. Si le PC possède Linux, c'est le moment de booter dessus (Il est aussi possible d'utiliser une distribution Linux sous vmware ou depuis un Live CD Ubuntu, les deux méthodes ont été testées.). Une fois gparted lancé, il faut choisir le bon disque (Un disque dur IDE branché en USB est reconnu sous Linux par /dev/sdX, sur la capture d'écran le disque se trouve en /dev/sdb.). Il suffit ensuite de cliquer droit sur la partition à redimensionner et de choisir Resize (Si par hasard l'option est désactivée, cela signifie que le disque dur a été automatiquement monté par Linux. Pour le démonter, clique droit puis umount.).</p>
<p>Pour donner un exemple, sur le disque dur de 2Go, j'ai redimensionné la partition à 500Mo (pour Windows 98 c'est largement suffisant). Il doit donc rester une partition non formatée sur le disque maintenant.</p>
<h2>Récupérer l'installeur debian pour le réseau</h2>
<p>Avant de continuer, il va falloir récupérer deux fichiers, qui permettront de lancer l'installation de Linux sur l'ultra-portable par le réseau (en passant par une carte réseau intégrée à l'ultra-portable ou en insérant une carte PCMCIA ethernet. Personnellement, je garde toujours une carte réseau 3Com, dont les drivers sont depuis longtemps intégrés à Linux, pour ce genre d'occasion).</p>
<p>Il faut donc télécharger les fichiers initrd.gz et linux depuis <a href="http://d-i.debian.org/daily-images/i386/daily/netboot/debian-installer/i386/" target="_blank">ici</a>. On les place sur le disque C:\ du disque dur qui est toujours en USB.</p>
<h2>Installation de grub</h2>
<p>Maintenant que le disque dur est prêt à accueillir Linux, il va falloir installer grub et lui indiquer qu'il faut démarrer l'installation de debian via le réseau. Là encore, deux méthodes existent, une pour Windows et une pour Linux. Sous Windows 98, l'utilitaire loadlin permet de lancer simplement un noyau Linux. Mais voilà je n'ai pas les drivers de ma carte réseau :D.</p>
<h3>Préparation pour l'installation de grub</h3>
<p>Maintenant il va falloir préparer le terrain pour grub, pour qu'il puisse démarrer l'installeur debian via le réseau. Il faut créer un répertoire boot à la racine de C:\. Ensuite il faut créer un répertoire grub dans ce répertoire boot et enfin créer un fichier nommé menu.lst dans le dossier grub. Il faut mettre dans ce fichier :</p>
<blockquote><p>title Installeur debian 4.00 par le réseau<br />
kernel (hd0,0)/linux<br />
initrd (hd0,0)/initrd.gz
</p></blockquote>
<p>Quelques explications sont nécessaires, kernel permet de spécifier à grub où il va trouver le noyau de Linux pour le démarrage. (hd0,0) représente en fait C:\ pour grub.</p>
<h3>grub sous Windows 2000/NT/XP</h3>
<h4>Installation</h4>
<p>grub est un logiciel opensource écrit pour GNU/Linux. Il éxiste cependant une version pour Windows (<a href="https://gna.org/projects/grub4dos/" target="_blank">Disponible ici</a>). Dans l'archive le seul fichier à récupérer est : grldr.exe, le bootloader. L'installation est simple, il suffit de copier le fichier grldr.exe sur le disque C:\. Ensuite, il faut modifier le fichier boot.ini (Si le fichier n'apparaît pas sous windows, il faut afficher les fichiers cachés (depuis un naviguateur de fichier: Outils-&gt;Options des dossiers-&gt;Afficher les fichiers système).) pour y insérer la ligne suivante :</p>
<blockquote><p>
C:\grldr = "Lancer GRUB"</p></blockquote>
<p>Ainsi, au prochain démarrage de Windows, il sera possible de choisir entre booter sous Windows ou lancer grub.</p>
<p>Voilà, le disque dur est prêt pour être remis dans l'ultra-portable.</p>
<h3>grub sous Linux</h3>
<h4>Installation</h4>
<p>Sous Linux, il suffit de lancer grub : grub depuis un terminal, puis (Il faudra bien faire attention à ce que hd1 corresponde au disque dur branché en usb. Pour cela, il faut aller dans le fichier /boot/grub/device.map et s'assurer que hd1 correspond bien au disque dur en USB :</p>
<blockquote><p>root (hd1,0)<br />
setup (hd1)<br />
quit</p></blockquote>
<p>Voilà, si tout s'est bien passé, grub est maintenant installé sur le disque du portable. Il est maintenant tant de débrancher le disque dur et de le rebrancher sur l'ultra-portable.</p>
<h2>Installation</h2>
<p>Installer le système, sans installer d'environnement graphique.</p>
<h2>Post-Install</h2>
<h3>Installer le serveur graphique</h3>
<p>Pour pouvoir utiliser une interface graphique, sans forcément utiliser KDE ou GNOME, il faut l'installer soi-même. Personellement, j'aime bien fluxbox comme gestionnaire de fenêtres (surtout pour les vieilles machines). Avant de pouvoir utiliser fluxbox, il reste encore quelques étapes.</p>
<p>En premier, il faut installer le serveur graphique : </p>
<blockquote><p>apt-get install xserver-xorg</p></blockquote>
<p> ainsi que les fontes de base (sans quoi le serveur graphique refusera de se lancer) </p>
<blockquote><p>apt-get install xfonts-base</p></blockquote>
<p>A ce stade X fonctionnera mais aucun environnement ne sera installé. Maintenant que l'ordinateur est capable de fonctionner en "mode graphique", il faut installer un gestionnaire de session graphique. Il en existe plusieurs : gdm, kdm, xdm. On en installe un </p>
<blockquote><p>apt-get install xdm</p></blockquote>
<p>Voilà, tout est prêt pour enfin installer notre gestionnaire de fenêtre préféré </p>
<blockquote><p>apt-get install fluxbox fluxconf fbdesk</p></blockquote>
<p>L'utilitaire fluxconf permet ensuite d'utiliser plusieurs utilitaires, dont fluxkeys qui permet d'assigner des actions à des touches, très pratique.</p>
<h3>Installer les paquets spécifiques au matériel</h3>
<p>On installe les outils spécifiques au matériel. Mon portable est un toshiba, donc apt-get install toshset fnfxd toshutils.</p>
<h3>Installer des applications légères</h3>
<p>Enfin, il peut être intéressant de savoir qu'il existe un gestionnaire de mail très léger Sylpheed et très complet (SSL, IMAP/POP, GPG ...) qui sera une très bonne alternative à icedove (icedove est la version pleinement GNU de thunderbird.) :</p>
<blockquote><p>apt-get install sylpheed</p></blockquote>
<p>. Il existe aussi un gestionnaire de fichiers, léger et plus que correct, qui remplacera avantageusement nautilus : xfe </p>
<blockquote><p>apt-get install xfe</p></blockquote>
