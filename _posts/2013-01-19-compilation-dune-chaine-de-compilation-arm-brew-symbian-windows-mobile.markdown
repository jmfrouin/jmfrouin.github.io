---
layout: post
status: publish
published: true
title: Compilation d'une chaine de compilation ARM (Brew, Symbian, WiMo ...)
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-19 18:47:50 +0100'
date_gmt: '2013-01-19 17:47:50 +0100'
categories:
- brew
- symbian
- gcc
tags: []
comments: []
---
<p>Script compilant une chaine de compilation ARM pouvant servir pour Brew, Symbian, Windows Mobile ... n'importe quel OS fonctionnant avec un processeur ARM.</p>
<!--more-->
<p>Commentaires du script :</p>
<p>On installe des paquets essentiels :</p>
<pre class="brush:shell">#!/bin/bash

#echo "Press Key - Installing ${TARGET} for build the Cross Compil Chain for Brew"
#sudo apt-get update
#sudo apt-get install libncurses5-dev gcc texinfo libmpc-dev libmpfr-dev</pre>
<p>On définie le format de sortie du compilateur:</p>
<pre class="brush:shell">#Target
#TARGET=arm-none-eabi
TARGET=arm-elf</pre>
<p>Les différentes version des composants principaux de la chaine complète de compilation :<br />
- binutils ou GNU Binary Utilities: des outils manipulant le format binaire.<br />
- gcc ou GNU Compiler Collection: le compilateur à proprement parlé.<br />
- newlib ou The Red Hat newlib C Library: une librairie, écrite en C. (fournie notamment stdlib.h)<br />
- gdb ou GNU Debugger</p>
<pre class="brush:shell">#Versions
BINUTILS_VER=2.20.1
GCC_VER=4.5.0
NEWLIB_VER=1.18.0
GDB_VER=7.1</pre>
<p>Ici on lui indique où l'on veut qu'il se compile, assemble, link ... :</p>
<pre class="brush:shell">PREFIX=/opt/toolchains/${TARGET}_${BINUTILS_VER}_${GCC_VER}_${NEWLIB_VER}_${GDB_VER}</pre>
<p>Et enfin un échantillon des nombreuses options à ajuster pour compiler sur un OS, plutôt qu'un autre:</p>
<pre class="brush:shell">#Options
BINUTILS_OPTIONS='--target='${TARGET}' --prefix='${PREFIX}' --enable-interwork --enable-multilib --disable-nls --disable-shared --disable-threads --with-gcc --with-gnu-as --with-gnu-ld'
#BOOT_GCC_OPTIONS='--target='${TARGET}' --prefix='${PREFIX}' --enable-interwork --enable-multilib --disable-nls --disable-shared --disable-threads --disable-libstdc++ --disable-libssp --disable-libstdcxx-pch --disable-libmudflap --disable-libgomp --with-gmp='${PREFIX}' --with-mpfr='${PREFIX}' --with-mpc='${PREFIX}' --enable-languages=c --with-newlib --with-headers=../newlib-'${NEWLIB_VER}'/newlib/libc/include --with-gcc --with-gnu-as --with-dwarf2 -v'
#--with-specs='%{O2:%{!fno-remove-local-statics: -fremove-local-statics}} %{O*:%{O|O0|O1|O2|Os:;:%{!fno-remove-local-statics: -fremove-local-statics}}}'
#GCC_OPTIONS='--target='${TARGET}' --prefix='${PREFIX}' --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --enable-extra-sgxxlite-multilibs --with-gnu-as --with-gnu-ld --enable-languages=c,c++ --disable-shared --disable-lto --with-newlib --disable-nls --with-headers=yes --disable-libgomp --enable-poison-system-directories --with-float=soft --disable-werror'
GCC_OPTIONS='--target='${TARGET}' --prefix='${PREFIX}' --disable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --enable-languages=c,c++ --disable-shared --with-newlib --disable-nls --with-headers=yes --disable-libgomp --with-float=soft --disable-werror'
#--with-gmp='${PREFIX}' --with-mpfr='${PREFIX} '--with-headers=../newlib-'${NEWLIB_VER}'/newlib/libc/include --with-mpc='${PREFIX}
#GCC_OPTIONS='--target='${TARGET}' --prefix='${PREFIX}' --enable-interwork --enable-multilib --disable-nls --disable-shared --disable-threads --with-gcc --with-gnu-as --with-gnu-ld --with-dwarf2 --enable-languages=c,c++ --with-newlib --with-headers=../newlib-'${NEWLIB_VER}'/newlib/libc/include --disable-libssp --disable-libstdcxx-pch --disable-libmudflap --disable-libgomp --with-gmp='${PREFIX}' --with-mpfr='${PREFIX}' --with-mpc='${PREFIX}' -v'
GDB_OPTIONS='--target='${TARGET}' --prefix='${PREFIX}' --disable-nls'
NEWLIB_OPTIONS='--target='${TARGET}' --prefix='${PREFIX}' --enable-interwork --enable-multilib --disable-newlib-supplied-syscalls'</pre>
<p>On affiche les paramètres :</p>
<pre class="brush:shell">#Display settings
echo "Prefix : "${PREFIX}
echo "binutils options : "${BINUTILS_OPTIONS}
echo "gcc options : "${GCC_OPTIONS}
echo "gdb options : "${GDB_OPTIONS}
echo "newlib options : "${NEWLIB_OPTIONS}</pre>
<p>On test les sources de chaque composants, après téléchargement :</p>
<pre class="brush:shell">echo "Press Key - Downloading CCC from web"
test ! -f binutils-${BINUTILS_VER}.tar.bz2 &amp;&amp; wget http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VER}.tar.bz2
test ! -f gcc-core-${GCC_VER}.tar.bz2 &amp;&amp; wget http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-core-${GCC_VER}.tar.bz2
test ! -f gcc-g++-${GCC_VER}.tar.bz2 &amp;&amp; wget http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VER}/gcc-g++-${GCC_VER}.tar.bz2
test ! -f newlib-${NEWLIB_VER}.tar.gz &amp;&amp; wget ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_VER}.tar.gz
test ! -f gdb-${GDB_VER}.tar.bz2 &amp;&amp; wget http://ftp.gnu.org/gnu/gdb/gdb-${GDB_VER}.tar.bz2</pre>
<p>Avant la compilation on nettoie une éventuelle, précédente compilation:</p>
<pre class="brush:shell">echo "Press Key - Cleaning ..."
rm -rf binutils-${BINUTILS_VER} newlib-${NEWLIB_VER} gdb-${GDB_VER} ${TARGET} gcc-${GCC_VER}
rm -rf ${PREFIX}</pre>
<p>Et on prépare :</p>
<pre class="brush:shell">mkdir ${PREFIX}
mkdir ${PREFIX}/bin
export PATH=${PATH}:${PREFIX}/bin
echo "Path : "${PATH}</pre>
<p>On décompresse :</p>
<pre class="brush:shell">tar jxvf binutils-${BINUTILS_VER}.tar.bz2
tar jxvf gcc-core-${GCC_VER}.tar.bz2
tar jxvf gcc-g++-${GCC_VER}.tar.bz2
tar zxvf newlib-${NEWLIB_VER}.tar.gz
tar jxvf gdb-${GDB_VER}.tar.bz2</pre>
<p>Et on compile :</p>
<pre class="brush:shell">echo "Press Key - Building of binutils !"
cd binutils-${BINUTILS_VER}
mkdir build
cd build
../configure ${BINUTILS_OPTIONS}
make
make install
cd ../..

echo "Press Key - Building of boot gcc !"
read -n 1 c #getchar
cd gcc-${GCC_VER}
mkdir build
cd build
#mkdir -p host-i686-pc-linux-gnu/fixincludes
../configure ${GCC_OPTIONS} #2&gt;err.log
#mkdir -p libiberty libcpp fixincludes
echo "boot gcc make " &gt; ../err.log
make all-gcc 2&gt;&gt; ../err.log
echo "install boot gcc " &gt;&gt; ../err.log
make install-gcc 2&gt;&gt; ../err.log
cd ../..

echo "Press Key - Building of newlib !"
read -n 1 c #getchar
cd newlib-${NEWLIB_VER}
mkdir build
cd build
../configure ${NEWLIB_OPTIONS}
make
make install
cd ../..

echo "Press Key - Building of full gcc"
read -n 1 c #getchar
cd gcc-${GCC_VER}/build
../configure ${GCC_OPTIONS} #2&gt;err.log
echo "full gcc make " &gt;&gt; ../err.log
make all 2&gt;&gt; ../err.log
echo "full gcc make install" &gt;&gt; ../err.log
make install 2&gt;&gt; ../err.log
cd ../..

echo "Press Key - Building of gdb !"
read -n 1 c #getchar
cd gdb-${GDB_VER}
mkdir build
cd build
../configure ${GDB_OPTIONS}
make
make install
cd ../..</pre>
<p>Lien vers le script complet <a href="http://frouin.me/scripts/arm-none-eabi.sh">arm-none-eabi.sh</a>.</p>
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
