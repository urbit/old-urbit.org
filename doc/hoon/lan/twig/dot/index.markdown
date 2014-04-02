---
layout: subpage
title: dot
---

#nock: dot, `.`#

---
{% for post in site.pages%}
 {% if post.category contains 'dot' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}



