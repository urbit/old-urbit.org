---
layout: subpage
title: buc
---

#type definitions: buc, `$`#

---
{% for post in site.pages%}
 {% if post.category contains 'buc' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}





