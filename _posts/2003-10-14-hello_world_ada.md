---
layout: page
title: Hello World en ADA
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2003-10-14 21:47:05 +0200'
date_gmt: '2003-10-14 21:47:05 +0200'
categories:
- ada
tags: []
comments: []
---
<h2>Hello World en ADA</h2>
<p>Le traditionnel hello world en ADA.</p>
<!--more-->
{% highlight ada %}
with Ada.Text_Io ;
procedure Afficher_Bienvenue is
  use Ada.Text_Io ;
begin
  Put_Line("Bienvenue en ADA") ;
end Afficher_Bienvenue ;
{% endhighlight %}
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
