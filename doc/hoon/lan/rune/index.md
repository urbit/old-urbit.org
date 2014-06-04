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

<script type="text/javascript" src="/public/js/subnav.js"></script>

<div class="subnav runes">
<ul>
{% assign prefixes = "bar|buc|cen|col|dot|hax|ket|sig|sem|tis|wut|zap" | split: "|" %}
{% for prefix in prefixes %}
<li>
<a href="#" class="expand"></a>
<a href="#{{ prefix }}" class="section"><code>{{ prefix }}</code></a>
<ul>
{% for page in site.axis.doc-hoon %}
{% if page.categories contains prefix %}
<li>
<a href="#{{ page.title }}"><code>{{ page.title }}</code></a>
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
<h1 id="{{ page.title }}"></h1>
{{ page.content }}
---
{% endif %}
{% endfor %}
{% endfor %}