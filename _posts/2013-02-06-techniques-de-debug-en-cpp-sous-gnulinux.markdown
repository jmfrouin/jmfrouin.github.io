---
layout: post
status: publish
published: true
title: Techniques de debug en C++ sous GNU/Linux
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-06 19:00:33 +0100'
date_gmt: '2013-02-06 18:00:33 +0100'
categories:
- debian
- cpp
tags: []
comments: []
---
<h2>Points d'arrêt dans une librairie partagée sous GNU/Linux</h2>
<p>Il est possible de débugger les librairies partagées en utilisant l'interruption 3 en mode DEBUG.<br />
Pour ce faire il suffit d'insérer : asm("int3"); à l'endroit où le point d'arrêt doit être posé.<br />
<!--more-->
Ensuite lors de l'exécution du programme dans gdb, il s'arrêtera automatiquement sur le point d'arrêt permettant ainsi de débugger la librairie partagée.<br />
Si le programme est lancé normalement (ie sans debuggeur), le programme quittera avec le message d'erreur : <em>Trappe pour point d'arrêt et de trace</em> (En tout cas avec GCC localisé en français version gcc (GCC) 4.1.2).</p>
<p>Il faudra donc penser à encadrer le point d'arrêt par un test, par exemple :</p>
<pre class="brush:cpp">#ifdef DEBUG_SHARED_LIBRARIES
asm("int3");
#endif //DEBUG_SHARED_LIBRARIES</pre>
<p>pour éviter que le programme quitte et vous fasse perdre du temps.</p>
<p>Et lancer cmake :</p>
<pre class="brush:shell">
cmake -DDEBUG_SHARED_LIBRARIES=1 ../source/
</pre>
<h2>Utiliser les macros de pré-compilation</h2>
<p>Dans un fichier :</p>
<pre class="brush:cpp">
std::cerr &lt;&lt; "[ERR] Pointeur nul. : Fichier " &lt;&lt; __FILE__ &lt;&lt; ", ligne " __LINE__ &lt;&lt; '\n'; 
</pre>
<p>Indiquera sur la sortie d'erreur, le fichier et la ligne où le programme à planté.</p>
<p>Pour vérifier le numéro de compilateur:</p>
<pre class="brush:cpp">
#define VERSION_GCC (__GNUC__*10000+__GNUC_MINOR__*100+__GNUC_PATCHLEVEL__) 
// Vérifier que la version de GCC est supérieure à 4.0.0
#if VERSION_GCC &gt; 30200
</pre>
<p><em>Cela peut servir aussi, à n'utiliser que certains fonctions / macros en fonction des versions les supportant.</em></p>
<h2>Valeur de retour Linux</h2>
<p>Les deux valeurs de retour (Nécessite l'en-tête $&lt;$iostream$&gt;$) de base de Linux pour le point de sortie :</p>
<pre class="brush:cpp">
return EXIT_SUCCESS;
return EXIT_FAILURE;
</pre>
<h2>Obtenir la liste des symboles</h2>
<p>L'outil <em>nm</em> fait cela.<br />
L'option -C active le demangle permettant d'obtenir les symboles C++ de façon plus lisible.</p>
<pre class="brush:shell">
nm -C file | egrep ' t ' | awk '{print $3}' | sort | uniq -c | sort -nr
</pre>
<h2>Empreinte mémoire</h2>
<p>Pour voir l'empreinte mémoire d'un processus il suffit d'aller dans <em>/proc/PID/maps</em>.<br />
Les segments exécutables ne sont pas dupliqués. Les segments de données, eux, le sont.</p>
