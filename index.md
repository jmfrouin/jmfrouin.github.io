---
title: Welcome
comments: false
---
<h1>Software / Source code</h1>
<a href="/baseconvertor/">BaseConvertor 1.00 C# &amp; Silverlight 2011</a><br/>
<a href="/contacts">Contacts 0.92 C++ &amp; GDI 2003-2004</a><br/>
<a href="https://github.com/jmfrouin/clipboards">clipboards 0.13 C# &amp; WinForms 2011</a><br/>
<a href="https://github.com/jmfrouin/gbemu">gbemu 0.59 C++ &amp; [X11 | SDL] 2008-2012</a><br/>
<a href="/imagemanip">ImageManip 1.00 C#/.Net 2011</a><br/>
<a href="/mlp">MLP C++ &amp; wxWidgets 2010</a><br/>
<a href="/neuron">Neuron C# &amp; .Net 2010-2011</a><br/>
<a href="/reversi">SReversi 1.0 for Windows CE</a><br/>
<a href="https://github.com/jmfrouin/sdatabase">sdatabase 0.40 C++ &amp; wxWidgets 2006-2007</a><br/>
<a href="/scleaner">All versions (and platforms) of scleaner</a><br/>
<a href="/scsvmanager">ScsvManager 0.45 Beta C++ 2004</a><br/>
<a href="/sinfos">SInfos 1.12 C++ 2004</a><br/>
<a href="/stweaker">STweaker 2004 1.33 C++ 2004</a><br/>
<a href="/syatzee">SYatzee C++ / GDI 2004</a><br/>
<a href="/yatzee2">Yatzee 2.X for Windows 8.X / 10</a><br/>
<a href="/yatzee">Yatzee 2.00 C# &amp; .Net 2011</a><br/>
<h1>Articles</h1>
<div class="row">
  {% assign count = '0' %}
  {% for post in site.posts %}
        {% capture count %}{{ count | plus: '1' }}{% endcapture %}
        {{ count }} - <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a> 
        (<span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>)<br/>
  {% endfor %}
</div>
