---
layout: post
status: publish
published: true
title: Quelques outils de sécurité réseau sous Debian
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-04 22:00:24 +0100'
date_gmt: '2013-02-04 21:00:24 +0100'
categories:
- debian
tags: []
comments: []
---
<p>john the ripper : Active password cracking tool (apt-get install john john-data)<br />
namp : The network mapper  (apt-get install nmap)<br />
nessus : <a href="http://www.nessus.org" target="_blank">Vulnerability scanning software</a><br />
chrootkit : <a href="http://www.chrootkit.org" target="_blank">Check Rootkit</a><br />
wireshark : Network traffic analyzer (apt-get install wireshark)<br />
netcat : TCP/IP swiss army knife (apt-get install netcat-openbsd)<br />
kismet : Wifi networks detector (apt-get install kismet)<br />
hping : Packet generator and analyzer (apt-get install hping3)<br />
snort : Network intrusion prevention system (apt-get install snort)<br />
tcpdump : Network debugging tool (apt-get install tcpdump)<br />
ssldump : Network debugging tool (apt-get install ssldump)<br />
ncaptool : Network capture tool (apt-get install ncaptool)</p>
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
