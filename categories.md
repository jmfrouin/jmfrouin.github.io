---
layout: page
title: Categories
permalink: /categories/
comments: false
---
<a name="categories"></a>
<h3>Categories</h3>
<div class="row">
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
</div>
