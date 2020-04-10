---
title: Welcome
comments: false
---

<h1>Webpages</h1>

[Hack the Box Writeup](pentest)

[Software / Source Code](logiciels)

<h1>Articles</h1>
<div class="row">
  {% assign count = '0' %}
  {% for post in site.posts %}
        {% capture count %}{{ count | plus: '1' }}{% endcapture %}
        {{ count }} - <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a> 
        (<span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>)<br/>
  {% endfor %}
</div>

[Mentions](mentions)

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
