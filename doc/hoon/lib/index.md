---
layout: subpage
title: Overview
axis: doc-hoon
categories: lib
sort: 0
---

## About the Hoon Library

Hoon is in a way self-documenting. You can look through the source of hoon.hoon and zuse.hoon to find all of the functions documented in this reference. In fact, that's how we documented hoon, by stepping through all of the arms (designated by ++  arm) and understanding what they're doing. As the documentation evolves, it's good to know where to look in the source in case you run in to trouble.  

<div class="subnav">
<ul>
{% for page in site.axis.doc-hoon %}
{% if page.categories contains 'lib' %}
{% if page.title != 'Overview' %}
<li>
	<a href="#{{ page.title | handleize }}" class="section">{{ page.title }}</a>
	<a href="#" class="expand"></a>
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