---
layout: subpage
title: col 
---

#tuples: col, `:`#

---
{% for post in site.pages%}
 {% if post.category contains 'col' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}






