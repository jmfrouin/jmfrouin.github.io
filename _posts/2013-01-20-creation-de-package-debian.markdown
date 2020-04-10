---
layout: post
status: publish
published: true
title: Création de package debian
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-20 10:25:59 +0100'
date_gmt: '2013-01-20 09:25:59 +0100'
categories:
- cmake
- debian
tags: []
comments: []
---
<p>Ce script créé automatiquement le paquet debian de scleaner, depuis les sources, en utilisant cmake.<br />
La paquet généré passait lintian sans problèmes à l'époque où je distribuais les paquets de scleaner.</p>
<!--more-->
<pre class="brush:shell">#This program is free software; you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation; either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see &lt;http://www.gnu.org/licenses/&gt;.

PROG=scleaner

#!/bin/bash
if [ $# -ne 1 ]; then
	echo $0 version
	exit
fi
tar cvf ${PROG}_$1.orig.tar . --exclude=${PROG}_$1.orig.tar --exclude=.svn --exclude=build &gt; /dev/null
echo Creating tar archive : ${PROG}_$1.orig.tar
gzip ${PROG}_$1.orig.tar 
echo Compression of tar archive : ${PROG}_$1.orig.tar.gz
mv ${PROG}_$1.orig.tar.gz build/
echo Moving ${PROG}_$1.orig.tar.gz to build
mkdir build/${PROG}-$1
echo Creating build/${PROG}-$1 directory
cd build/${PROG}-$1
echo Entering build/${PROG}-$1 directory
dh_make -s
echo dh_make
cmake ../../src/
echo Launching cmake
dpkg-buildpackage -rfakeroot 
echo Package built</pre>
<p>Lien vers le script complet <a href="http://frouin.me/scripts/create_deb.sh">create_deb.sh</a>.</p>
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
