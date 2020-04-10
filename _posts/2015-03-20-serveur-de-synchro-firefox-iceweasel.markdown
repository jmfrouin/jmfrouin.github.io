---
layout: post
status: publish
published: true
title: Serveur de synchro Firefox / Iceweasel
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2015-03-20 09:59:14 +0100'
date_gmt: '2015-03-20 08:59:14 +0100'
categories:
- firefox
- iceweasel
tags: []
comments: []
---
<h2>ATTENTION</h2>
<p><strong>A partir de Firefox 29 ce tutoriel n'est plus valide, visiter ce <a href="http://dattaz.fr/blog/?id=13" target="_blank">site</a>, pour la nouvelle procédure.</strong>.
Lire aussi l'url <a target="_blank" href="https://docs.services.mozilla.com/howtos/run-sync-1.5.html">officielle</a></p>
<!--more-->
<h2>Prérequis</h2>
<p>Il faut installer python, make, mercurial et sqlite3:</p>
<blockquote><p>sudo apt-get install python-dev mercurial sqlite3 python-virtualenv</p></blockquote>
<h2>Compiler le serveur</h2>
<p>On récupère les sources depuis le mercurial de mozilla :</p>
<blockquote><p>jmfrouin@secure:~/sync$ hg clone https://hg.mozilla.org/services/server-full<br />
destination directory: server-full<br />
requesting all changes<br />
adding changesets<br />
adding manifests<br />
adding file changes<br />
added 539 changesets with 1470 changes to 346 files (+1 heads)<br />
updating to branch default<br />
60 files updated, 0 files merged, 0 files removed, 0 files unresolved</p></blockquote>
<p>On entre dans la copie locale :</p>
<blockquote><p>jmfrouin@secure:~/sync$ cd server-full/</p></blockquote>
<p>Et on lance la compilation :</p>
<blockquote><p>jmfrouin@secure:~/sync/server-full$ make build<br />
virtualenv --distribute --no-site-packages .<br />
New python executable in ./bin/python<br />
Installing<br />
...</p>
<p>...<br />
Building the app<br />
Checking the environ [ok]<br />
Updating the repo [ok]<br />
Building Services dependencies<br />
Getting server-core [ok]<br />
Getting server-reg [ok]<br />
Getting server-storage [ok] [ok]<br />
Building External dependencies [ok]<br />
Now building the app itself [ok]<br />
[done]<br />
# Pre-compile mako templates into the correct directories.<br />
for TMPL in `find . -name '*.mako'`; do ./bin/python -c "from mako.template import Template; Template(filename='$TMPL', module_directory='`dirname $TMPL`', uri='`basename $TMPL`')"; done;</p></blockquote>
<p>J'ai pas eu le problème, mais si y'en a avec pysqlite, il faut l'installer :</p>
<blockquote><p>./bin/pip install pysqlite</p></blockquote>
<h2>Configuration</h2>
<pre class="brush:shell">[global]
clean_shutdown = false

[captcha]
use = false
public_key = PUBLIC_KEY
private_key = PRIVATE_KEY
use_ssl = false

[storage]
backend = syncstorage.storage.sql.SQLStorage
sqluri = mysql://mysql_user:mysql_password@localhost/sync_db
standard_collections = false
use_quota = true
quota_size = 25120
pool_size = 100
pool_recycle = 3600
reset_on_return = true
display_config = true
create_tables = true

[auth]
backend = services.user.sql.SQLUser
sqluri = mysql://mysql_user:mysql_password@localhost/sync_db
pool_size = 100
pool_recycle = 3600
create_tables = true
# Uncomment the next line to disable creation of new user accounts.
allow_new_users = true

[nodes]
fallback_node = http://sync.domain.com:5000/

[smtp]
host = localhost
port = 25
sender = sync@frouin.me

[cef]
use = true
file = syslog
vendor = mozilla
version = 0
device_version = 1.3
product = weave

[reset_codes]
backend = services.resetcodes.rc_sql.ResetCodeSQL
sqluri = mysql://mysql_user:mysql_password@localhost/sync_db
create_tables = True</pre>
<h2>Lancement du serveur</h2>
<blockquote><p>bin/paster serve development.ini<br />
Starting server in PID 29951.<br />
serving on 0.0.0.0:5000 view at http://127.0.0.1:5000</p></blockquote>
<h2>En action</h2>
<p>Ainsi on note, que sous firefox, on peut utiliser la synchro des modules complémentaires (les extensions) alors que sous iceaweasel non.</p>
<p>Les 5 restants :</p>
<p>- les marques-pages</p>
<p>- les mots de passe</p>
<p>- les préférences</p>
<p>- l'historique</p>
<p>- les onglets</p>
<p>étant communs aux deux navigateurs.</p>
<p>Suite à la mise à jour sous wheezy : </p>
<pre class="brush:shell">
cp etc/sync.conf ~/
hg revert etc/sync.conf
hg pull
hg update
make build
bin/easy_install Mysql-Python
cp ~/sync.conf /etc
</pre>
<p><strong>Je reviendrai éditer ce billet, pour ajouter la configuration avec nginx du serveur.</strong></p>
<p><em>Ce billet est largement inspiré de cette <a href="http://docs.services.mozilla.com/howtos/run-sync.html" target="_blank">page </a></em></p>
