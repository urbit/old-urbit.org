---
layout: subpage
title: hax
---

#prettyprint: hax `#`#

---
{% for post in site.pages%}
 {% if post.category contains 'hax' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}



