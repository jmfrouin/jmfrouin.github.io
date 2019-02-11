<section class="posts postindex wrapper">

  <h1 class="page-heading">Bienvenue</h1>
  <br/>
  <center>
  {% for category in site.categories %}
    {% if category contains "home" %}
    {% else %}
      <a style="font-size: {{ category | last | size | times: 100 | divided_by: site.categories.size | plus: 70 }}%" href="/category/{{ category | first | slugize }}/"> {{ category | first }} </a><span class="badge">{{category[1].size}}</span>
      {% if forloop.last == false %}
        -
      {% endif %}
    {% endif %}
  {% endfor %}
  </center>
  <br/> <br/>

  <h1 class="page-heading">Les derniers posts</h1>
  <div class="row">
    {% assign count = '0' %}
    {% for post in site.posts limit:5 %}
          {% capture count %}{{ count | plus: '1' }}{% endcapture %}
          <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a> 
          (<span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>)<br/>
    {% endfor %}
  </div>
  <br/> <br/>
  <h1 class="page-heading">GIT</h1>
  {% for post in site.posts %}
    {% if post.categories contains "git" %}
      {% if post.categories contains "home" %}
        <a href="{{post.url}}">{{post.title}}</a> </br>
      {% endif %}
    {% endif %}
  {% endfor %}

  <h1 class="page-heading">C++</h1>
  {% for post in site.posts %}
    {% if post.categories contains "cpp" %}
      {% if post.categories contains "home" %}
        <a href="{{post.url}}">{{post.title}}</a> </br>
      {% endif %}
    {% endif %}
  {% endfor %}

  <h1 class="page-heading">GNU-Linux</h1>
  {% for post in site.posts %}
    {% if post.categories contains "bash" %}
      {% if post.categories contains "home" %}
        <a href="{{post.url}}">{{post.title}}</a> </br>
      {% endif %}
    {% endif %}
  {% endfor %}

  <h1 class="page-heading">Symfony | Silex</h1>
  {% for post in site.posts %}
    {% if post.categories contains "symfony" %}
      {% if post.categories contains "home" %}
        <a href="{{post.url}}">{{post.title}}</a> </br>
      {% endif %}
    {% endif %}
  {% endfor %}

  <h1 class="page-heading">vim</h1>
  {% for post in site.posts %}
    {% if post.categories contains "vim" %}
      {% if post.categories contains "home" %}
        <a href="{{post.url}}">{{post.title}}</a> </br>
      {% endif %}
    {% endif %}
  {% endfor %}

  <p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | prepend: site.baseurl }}">via RSS</a></p>
  Find me on <a href="https://twitter.com/jmfrouin" target="_blank">twitter</a>, <a href="http://frou.in/viadeo" target="_blank">viadeo</a> or <a href="http://frou.in/linkedin" target="_blank">linkedin</a>.
</section>
