---
layout: post
status: publish
published: true
title: Créer une archive tbz2 d'un répertoire
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-20 18:34:28 +0100'
date_gmt: '2013-01-20 17:34:28 +0100'
categories:
- shell
- bash
tags: []
comments: []
---
<p>Un script qui me permet de créer une archive tbz2 d'un répertoire.<br />
<!--more-->
Il prend un argument (ou pas, dans ce cas c'est le nom du répertoire courant) et sort : timestamp_argument.tbz2<br />
Exemple :</p>
<blockquote><p>~/toto# ./backup.sh<br />
-&gt; 2012_06_08-09_05_12-toto.tbz2<br />
~/toto# ./backup.sh titi<br />
-&gt; 2012_06_08-09_05_12-titi.tbz2</p></blockquote>
<p>Il me permet d'archiver des trucs ponctuellement, le timestamp en tete, permettant un tri aisé !</p>
<pre class="brush:shell"># History
# 0.02 : [2012/04/02] Add ability to call without argument, so use basename(pwd) instead
# 0.01 : Initial version

#!/bin/bash

EXPECTED_ARGS=1

timestamp=`date +%Y_%m_%d-%H_%M_%S`
dir_name=`pwd`;
archive_name=`basename $dir_name`

#echo "dir_name : $dir_name"
#echo "archive_name: $archive_name"
#echo "Timestamp used : $timestamp"

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Will compress as $timestamp-$archive_name.tbz2"
  tar jcvf $timestamp-$archive_name.tbz2 * .git* --exclude=build --exclude=b
else
  echo "Will compress as $timestamp-$1.tbz2"
  tar jcvf $timestamp-$1.tbz2 * .git* --exclude=build --exclude=b
fi</pre>
<p>Lien vers le script complet <a href="http://frouin.me/scripts/backup.sh">backup.sh</a>.</p>
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
