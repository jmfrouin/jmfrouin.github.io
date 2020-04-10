---
layout: post
status: publish
published: true
title: 'Déploiement d''application Symfony en production avec git '
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-31 10:10:08 +0100'
date_gmt: '2013-01-31 09:10:08 +0100'
categories:
- git
- home
- symfony
tags: []
comments: []
---
<h1>Assumptions</h1>
<p>Partons du principe que l'on déploie, en production, dans <em>/var/www/mon_app</em><br />
Que la gestion des dépôts git à été faite sous gitolite.<br />
L'user de déploiement est publisher.<br />
Enfin dans git, on à deux branches (entre autre), une dans laquelle, <em>master</em>, on verse les modifications à mettre en production, et une <em>production</em>, qui contient les commits avec la configuration de production, que l'on rebase sur master avant de la pousser.</p>
<!--more-->
<h1>Préparation / Mise en place</h1>
<p>On créé initialise donc le dépôt git :</p>
<pre class="brush:shell">git init</pre>
<p>Depuis le poste du déployeur, on ajoute une branche production.</p>
<pre class="brush:shell">git branch production</pre>
<p>On y fait les modifications pour la production (paramaeters.ini entre autre) et on commit.<br />
Ensuite quand des modifications seront faite sur le master, il suffira de ce remettre à jour :</p>
<pre class="brush:shell">git rebase master</pre>
<p>Une fois cela fait il faut, initialiser la copie en production :<br />
On récupère composer :</p>
<pre class="brush:shell">php -r "eval('?&gt;'.file_get_contents('https://getcomposer.org/installer'));"</pre>
<p>Et on lance l'initialisation des bundles :</p>
<pre class="brush:shell">./composer.phar update</pre>
<p>Pour pouvoir déployer il faut avant tout ajouter la cible de déploiement pour la mise en prod :</p>
<pre class="brush:shell">git remote add prod publisher@srv1.domain.tld:/var/www/mon_app</pre>
<p>Ne pas oublier de ce mettre sur la branche production en ... production.</p>
<pre class="brush:shell">git checkout production</pre>
<p>Pour que le commit puisse fonctionner il faut définir :</p>
<pre class="brush:shell">git config receive.denyCurrentBranch ignore</pre>
<p>Puis dans un second temps, mettre en place un hook git pour initialiser l'application symfony2.<br />
On utilise le hook <em>post-update</em> c'est à dire, une fois que le dépôt à reçu la mise à jour du code.</p>
<pre class="brush:shell">#!/bin/sh
#
# This hook does three things:
#
#  1. update the "info" files that allow the list of references to be
#     queries over dumb transports such as http
#
#  2. if this repository looks like it is a non-bare repository, and
#     the checked-out branch is pushed to, then update the working copy.
#     This makes "push" function somewhat similarly to darcs and bzr.
#
#  3. clear the symfony cache, update submodules and install static assets
#
# To enable this hook, make this file executable by "chmod +x post-update".

export SYMFONY_ENV=prod
PHP="php -c /etc/php5/fpm/php.ini"
CONSOLE="$PHP app/console --no-debug"

git-update-server-info

is_bare=$(git-config --get --bool core.bare)

if [ -z "$is_bare" ]
then
	# for compatibility's sake, guess
	git_dir_full=$(cd $GIT_DIR; pwd)
	case $git_dir_full in */.git) is_bare=false;; *) is_bare=true;; esac
fi

update_wc() {
	ref=$1
	echo "Push to checked out branch $ref" &gt;&amp;2
	if [ ! -f $GIT_DIR/logs/HEAD ]
	then
		echo "E:push to non-bare repository requires a HEAD reflog" &gt;&amp;2
		exit 1
	fi
	if (cd $GIT_WORK_TREE; git-diff-files -q --exit-code &gt;/dev/null)
	then
		wc_dirty=0
	else
		echo "W:unstaged changes found in working copy" &gt;&amp;2
		wc_dirty=1
		desc="working copy"
	fi
	if git diff-index --cached HEAD@{1} &gt;/dev/null
	then
		index_dirty=0
	else
		echo "W:uncommitted, staged changes found" &gt;&amp;2
		index_dirty=1
		if [ -n "$desc" ]
		then
			desc="$desc and index"
		else
			desc="index"
		fi
	fi
	if [ "$wc_dirty" -ne 0 -o "$index_dirty" -ne 0 ]
	then
		new=$(git rev-parse HEAD)
		echo "W:stashing dirty $desc - see git-stash(1)" &gt;&amp;2
		( trap 'echo trapped $$; git symbolic-ref HEAD "'"$ref"'"' 2 3 13 15 ERR EXIT
		git-update-ref --no-deref HEAD HEAD@{1}
		cd $GIT_WORK_TREE
		git stash save "dirty $desc before update to $new";
		git-symbolic-ref HEAD "$ref"
		)
	fi

	# eye candy - show the WC updates 
	echo "Updating working copy" &gt;&amp;2
	(cd $GIT_WORK_TREE
	git-diff-index -R --name-status HEAD &gt;&amp;2
	git-reset --hard HEAD)

	# install / update vendor bundles
	echo "Installing vendor bundles" &gt;&amp;2
	(cd $GIT_WORK_TREE
	git-submodule sync
	git-submodule update --init)

	# bootstrap symfony
	echo "Bootstraping Symfony" &gt;&amp;2
	(cd $GIT_WORK_TREE
	$PHP vendor/bundles/Sensio/Bundle/DistributionBundle/Resources/bin/build_bootstrap.php)

	# Clear the symfony cache
	echo "Clearing the symfony cache" &gt;&amp;2
	(cd $GIT_WORK_TREE
	$CONSOLE cache:clear --no-warmup)

    # Deploy static assets
	echo "Installing static assets" &gt;&amp;2
	(cd $GIT_WORK_TREE
	$CONSOLE assetic:dump --no-debug
	$CONSOLE assets:install --symlink web)
}

if [ "$is_bare" = "false" ]
then
	active_branch=`git-symbolic-ref HEAD`
	export GIT_DIR=$(cd $GIT_DIR; pwd)
	GIT_WORK_TREE=${GIT_WORK_TREE-..}
	for ref
	do
		if [ "$ref" = "$active_branch" ]
		then
			update_wc $ref
		fi
	done
fi</pre>
