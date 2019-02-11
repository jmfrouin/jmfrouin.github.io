---
layout: post
status: publish
published: true
title: Manipulations PDF
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-03-04 19:02:14 +0100'
date_gmt: '2013-03-04 18:02:14 +0100'
categories:
- debian
tags: []
comments: []
---
<h2>Pré-requis</h2>
<p>Avant toute chose il faut installer PDF toolkit :</p>
<pre class="brush:shell">sudo apt-get install pdftk</pre>
<h2>Rotations</h2>
<p>Rotation de 90° à gauche d'un PDF et enregistrement dans un autre document</p>
<pre class="brush:shell">pdftk origin.pdf cat 1-endW output rotated.pdf</pre>
<p>Rotation de 90° à droite d'un PDF et enregistrement dans un autre document</p>
<pre class="brush:shell">pdftk origin.pdf cat 1-endE output rotated.pdf</pre>
<p>Rotation de 180° d'un PDF et enregistrement dans un autre document</p>
<pre class="brush:shell">pdftk origin.pdf cat 1-endS output rotated.pdf</pre>
<h2>Sécurité</h2>
<p>Crypter un PDF avec le mot de passe <em>secret</em> :</p>
<pre class="brush:shell">pdftk fichier.pdf output fichier_protege.pdf owner_pw secret</pre>
<p>Et décryptage :</p>
<pre class="brush:shell">pdftk fichier_protege.pdf input_pw secret output fichier.pdf</pre>
<h2>Manipulation</h2>
<p>Retirer une page d'un PDF (disons la 13):</p>
<pre class="brush:shell">pdftk fichier.pdf cat 1-12 14-end output fichier_sans_page_13.pdf</pre>
<p>Concaténer plusieurs PDF en un :</p>
<pre class="brush:shell">pdftk *.pdf cat output ../Final.pdf</pre>
<h2>Références</h2>
<p><a href="http://www.pdflabs.com/docs/pdftk-cli-examples/" target"=_blank">pdflabs (en anglais)</a><br />
<a href="http://www.pdflabs.com/docs/pdftk-man-page/" target="_blank">pdftk man page (en anglais)</a></p>
