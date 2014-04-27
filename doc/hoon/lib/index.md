---
layout: subpage
title: Overview
axis: doc-hoon
categories: lib
sort: 0
---

## About the Hoon Library

Hoon is in a way self-documenting. You can look through the source of `hoon.hoon` and `zuse.hoon` in your `/urb/` directory to find all of the functions documented in this reference. 

This library is a work in progress. Feedback and corrections are welcome. Pull requests are encouraged. The repo for this site lives [here](https://github.com/urbit/urbit.github.io). We would love your help in making this reference useful.

<div class="subnav arms">
<ul>
{% for page in site.axis.doc-hoon %}
{% if page.categories contains 'lib' %}
{% if page.title != 'Overview' %}
<li>
    <a href="#" class="expand"></a>
	<a href="#{{ page.title | handleize }}" class="section">{{ page.title-short }}</a>
	<ul>
	{% for arm in page.arms %}
	<li>
	<a href="#{{ arm }}">{{ arm }}</a>
	</li>
	{% endfor %}
	</ul>
</li>
{% endif %}
{% endif %}
{% endfor %}
</ul>
</div>

{% for page in site.axis.doc-hoon %}
{% if page.categories contains 'lib' %}
{% if page.title != 'Overview' %}
<h1 id="{{ page.title | handleize }}">{{ page.title }}</h1>
{{ page.content }}
{% endif %}
{% endif %}
{% endfor %}