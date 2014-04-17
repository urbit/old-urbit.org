---
layout: subpage
title: Rune - Index
axis: doc-hoon
categories: lan overview
sort: 5
---

## Runes

Hoon is free of reserved words. Instead, we use digraph pairs such as `|=` and call them runes. 

This library is a work in progress. Feedback and corrections are welcome. Pull requests are encouraged. The repo for this site lives [here](https://github.com/urbit/urbit.github.io). We would love your help in making this reference useful.

<div class="subnav">
<ul>
{% assign prefixes = "bar|buc|cen|col|dot|hax|ket|sig|sem|tis|wut|zap" | split: "|" %}
{% for prefix in prefixes %}
<li>
<a href="#{{ prefix }}" class="section"><code>{{ prefix }}</code></a>
<a href="#" class="expand"></a>
<ul>
{% for page in site.axis.doc-hoon %}
{% if page.categories contains prefix %}
<li>
<a href="#{{ page.title }}">{{ page.title }}</a>
</li>
{% endif %}
{% endfor %}
</ul>
</li>
{% endfor %}
</ul>
</div>

{% assign prefixes = "bar|buc|cen|col|dot|hax|ket|sig|sem|tis|wut|zap" | split: "|" %}
{% for prefix in prefixes %}
<h1 id="{{ prefix }}">{{ prefix }}</h1>
{% for page in site.axis.doc-hoon %}
{% if page.categories contains prefix %}
<h4 id="{{ page.title }}">---</h1>
{{ page.content }}
{% endif %}
{% endfor %}
{% endfor %}