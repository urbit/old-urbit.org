---
layout: subpage
title: bar
---

#gates: bar, `|`#

---
{% for post in site.pages%}
 {% if post.category contains 'bar' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}



