---
layout: post
status: publish
published: true
title: Surveiller la température de son disque dur
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-22 22:45:46 +0100'
date_gmt: '2013-01-22 21:45:46 +0100'
categories:
- shell
- monitoring
tags: []
comments:
- id: 632
  author: bonnard
  author_email: bonnardmickael@gmail.com
  author_url: ''
  date: '2014-04-16 00:29:54 +0200'
  date_gmt: '2014-04-15 23:29:54 +0200'
  content: "Bonjour\r\n\r\nJ'ai lu avec attention votre article sur lle script de
    surveillance des températures disques durs.\r\n\r\nJ'avais néanmoins une question
    concernant les notifications d'alertes.\r\n\r\nTant que le script détecte que
    les températures sont en état warning/critical il envoie des alertes, mais quel
    code pourrait t'on ajouter pour qu'il envoie un mail et UN seul si les températures
    reviennent à la normale.\r\n\r\nSi on met un if température ok alors envoi notification
    mail mais le mail partira a chaque declenchement de la tache cron et moi je ne
    ceux qu'une seule notification.\r\n\r\ncordialement"
- id: 633
  author: Jean-Michel Frouin
  author_email: jm@frouin.me
  author_url: http://frouin.me
  date: '2014-04-16 09:37:46 +0200'
  date_gmt: '2014-04-16 08:37:46 +0200'
  content: |-
    Il suffirait pour ce faire d'utiliser une variable globale, que l'on set à TRUE (ou 1), quand le mail est parti.
    La variable serait remise à FALSE (ou 0) quand une alerte de warning/critical est levée.
---

<p>A installer avant : </p>
<blockquote><p>jmfrouin@4310:~$ sudo apt-get install hddtemp</p></blockquote>
<!--more-->
<p>Avec :<br />
- /dev/sda : le disque à surveiller<br />
- warning : temperature à partie de laquelle, le script enverra le mail d'avertissement<br />
- alarm : temperature à partie de laquelle, le script enverra le mail demandant un redémarrage<br />
- message_warning : Le contenu du mail<br />
- message_alarm : Le contenu du mail<br />
- dest : les destinataires du script</p>
<pre class="brush:shell">#!/bin/bash
temp=$(hddtemp /dev/sda -n)
warning=45
alarm=50
message_warning="HDD has reached warning threshold temperature whith $temp°C. Please cool down the system NOW!"
message_alarm="HDD has reached ALARM threshold temperature whith $temp°C. Please shut down the system NOW!"
dest="...@gmail.com ...@gmail.com"
if [ $temp -ge $warning -a $temp -lt $alarm ] ; then
   echo  $message_warning | mail -s "Warm system alert on `hostname`" $dest
elif [ $temp -ge $alarm ] ; then
   echo $message_alarm | mail -s "Critical temp alert on `hostname`" $dest
fi
exit</pre>
<p>Le script est à placer dans la crontab de root (hddtemp nécessite les droits de super utilisateur) :</p>
<blockquote><p>* * * * * /root/.monitoring_hdd.sh</p></blockquote>
