---
layout: subpage
title: Overview
axis: doc-hoon
categories: lan
sort: 0
---

## About the Hoon Language

Hoon is ruthlessly utilitarian, which means it's difficult to separate in to rigid categories for documentation. You'll notice that there is some overlap between twigs, tiles, types and runes that are confusing at first. 

We have done our best to point out these points of potential confusion. The usefulness of these overlaps should become clear as you become a more experienced hoon programmer.

{% for page in site.axis.doc-hoon %}
{% if page.categories contains 'overview' %}
[{{ page.title }}]({{ page.url }})
{% endif %}
{% endfor %}