---
layout: page
title: Documentation
axis: root
sort: 1
---

Arvo runs on top of Hoon, Hoon runs on top of Nock, and that's all we know.

If you want to build a deep understanding of how Urbit works, start with Nock. If you'd prefer to just start trying stuff out, start with Hoon. 

+   <h2>Nock</h2>

    ###Tutorial
    {% for page in site.axis.doc-nock %}
    {% if page.categories contains 'tut' %}
    [{{ page.title }}]({{ page.url }})
    {% endif %}
    {% endfor %}

    ###Language Reference
    {% for page in site.axis.doc-nock %}
    {% if page.categories contains 'lan' %}
    [{{ page.title }}]({{ page.url }})
    {% endif %}
    {% endfor %}

+   <h2>Hoon</h2>

    ###Tutorial
    {% for page in site.axis.doc-hoon %}
    {% if page.categories contains 'tut' %}
    [{{ page.title }}]({{ page.url }})
    {% endif %}
    {% endfor %}

    ###Language Reference
    {% for page in site.axis.doc-hoon %}
    {% if page.categories contains 'lan' %}
    [{{ page.title }}]({{ page.url }})
    {% endif %}
    {% endfor %}

    ###Library Reference
    {% for page in site.axis.doc-hoon %}
    {% if page.categories contains 'lib' %}
    [{{ page.title }}](/doc/hoon/lib/#{{ page.section }})
    {% endif %}
    {% endfor %}

+   <h2>Arvo</h2>
    {% for page in site.axis.doc-arvo %}
    [{{ page.title }}]({{ page.url }})
    {% endfor %}


<!-- <hr>
<h2>The Urban Reference Manual</h2>
<hr>
<div class="posts">
      <li><a href="/setup">Chapter I (Setup)</a></li>
{% for post in site.posts reversed %}
  {% if post.categories contains 'doc' %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endif %}
{% endfor %}

</div>
<hr>
<h2><a href="/bestiary">The Urban Bestiary</a></h2>
<hr>
<h2><a href="/tutorial">Tutorial</a></h2>
<hr>
 -->