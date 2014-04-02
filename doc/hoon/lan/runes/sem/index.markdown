---
layout: subpage
title: sem
---

#miscellaneous: sem, `;`#

---
{% for post in site.pages%}
 {% if post.category contains 'sem' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}




