---
layout: post
status: publish
published: true
title: Timing en C++ sous GNU/Linux
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-01-30 20:34:53 +0100'
date_gmt: '2013-01-30 19:34:53 +0100'
categories:
- cpp
- home
tags: []
comments: []
---
<p>Mesurer le temps d'exécution d'une portion de code sous GNU/Linux en C++.</p>
<!--more-->
<pre class="brush:cpp">#include &lt;iostream&gt;
#include &lt;stdlib.h&gt;
#include &lt;sys/time.h&gt;
#include &lt;cstdlib&gt;

int main()
{
  struct timeval start, end;

  long mtime, seconds, useconds;    

  gettimeofday(&amp;start, NULL);
  for(int i=10000000; --i&gt;0;) 
  {
    int a = rand();
    int b = rand();
    a/=b;
  }
  gettimeofday(&amp;end, NULL);

  seconds  = end.tv_sec  - start.tv_sec;
  useconds = end.tv_usec - start.tv_usec;

  mtime = ((seconds) * 1000 + useconds/1000.0) + 0.5;
  std::cout &lt;&lt; "(int) Elapsed time: " &lt;&lt; mtime &lt;&lt; " ms\n";

  return EXIT_SUCCESS;
}</pre>
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
