---
layout: post
status: publish
published: true
title: Redimension en masse d'image
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-02-10 09:52:58 +0100'
date_gmt: '2013-02-10 08:52:58 +0100'
categories:
- shell
tags: []
comments: []
---
<p>En bash, en une ligne (nécessite imagemagick):</p>
<pre class="brush:shell">for i in *JPG; do convert -resize 640x480 $i MINI_$i; done

</pre>
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
