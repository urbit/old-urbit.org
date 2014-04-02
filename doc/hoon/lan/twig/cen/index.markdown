---
layout: subpage
title: cen
---

#invocations: cen, `%`#

---
{% for post in site.pages%}
 {% if post.category contains 'cen' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}






