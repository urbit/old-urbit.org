---
layout: subpage
title: zap
---

#special: zap, `!`#

---
{% for post in site.pages%}
 {% if post.category contains 'zap' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}





