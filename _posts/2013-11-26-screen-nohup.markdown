---
layout: post
status: publish
published: true
title: Se détacher d'un shell ... screen & nohup
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-11-26 16:09:11 +0100'
date_gmt: '2013-11-26 15:09:11 +0100'
categories:
- shell
- bash
tags: []
comments: []
---
<p>screen c'est bien pratique pour détacher un shell où l'on s'est connecté en SSH, on le lance simplement grâce à la commande <strong>screen</strong>.</p>
<p>Cela fait longtemps que je devais faire une "cheat sheet" de cet outil, voila chose faite.</p>
<p>D'ailleurs en passant voici les raccourcis :</p>
<h2>Bases</h2>
<p>-ctrl a c -&gt; créer une nouvelle fenêtre<br />
-ctrl a A -&gt; définir le nom de la fenêtre<br />
-ctrl a w -&gt; voir toutes les fenêtres<br />
-ctrl a 1|2|3|... -&gt; basculer vers la fenêtre N<br />
-ctrl a " -&gt; choisir la fenêtre<br />
-ctrl a ctrl a -&gt; basculer entre les fenêtres<br />
-ctrl a d -&gt; détacher la fenêtre<br />
-ctrl a ? -&gt; aide<br />
-ctrl a [ -&gt; commencer la copie, déplacer le curseur jusqu’où l'on veut copier, appuyer sur ENTREE, sélectionner des caractères, appuyer sur ENTREE pour copier les caractères sélectionnés dans le buffer<br />
-ctrl a ] -&gt; copier depuis le buffer</p>
<h2>Comment démarrer un screen</h2>
<p>-screen -DR -&gt; lister les screen détachés<br />
-screen -r PID -&gt; se rattacher à une session détachée<br />
-screen -dmS MySession -&gt; démarrer une session détachée<br />
-screen -r MySession -&gt; s'attacher a une session en utilisant son nom</p>
<h2>Avancés</h2>
<p>-ctrl a S -&gt; Spliter la session<br />
-ctrl a TAB -&gt; Basculer entre deux splits</p>
<p>Lorsque l'on créé un nouveau split, la fenêtre courante est vide, utiliser <em>ctrl a "</em> pour sélectionner une session existante ou <em>ctrl a n</em> pour en créer une nouvelle.</p>
<p>-ctrl a Q -&gt; Tuer tous les splits sauf celui actif.<br />
-ctrl a X -&gt; Retirer la fenêtre active des splits.<br />
-ctrl a O -&gt; Se déconnecter de la fenêtre active.<br />
-ctrl a I -&gt; Se connecter dans la fenêtre active.</p>
<p><a href="http://neophob.com/2007/04/gnu-screen-cheat-sheet/" target="_blank">Lien original</a></p>
<p>Et parfois screen n'est pas disponible, ou non fonctionnel :</p>
<pre class="brush:shell">Cannot open your terminal '/dev/pts/0' - please check.</pre>
<p>Dans ce cas il faut revenir aux bases : nohup</p>
<h2>nohup</h2>
<p>On lance une commande insensible aux signaux SIGHUP avec : </p>
<pre class="brush:shell">nohup wget ftp://example.com/big.file &</pre>
<h2>Rendre une commande lancée insensible</h2>
<p>On peut aussi rendre une process déjà lancé, insenssible au signal SIGHUP : </p>
<pre class="brush:shell">disown -h job</pre>
<h2>bash</h2>
<p>bash peut automatiquement, rendre insensible les taches lancées en arrière plan avec: </p>
<pre class="brush:shell">shopt -u huponexit</pre>
<p><a href="http://content.hccfl.edu/pollock/Unix/nohup.htm" target="_blank">Lien original</a></p>
