---
layout: subpage
title: wut
---

---
#tests: wut, `?`#

---
{% for post in site.pages%}
 {% if post.category contains 'wut' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}




