---
layout: subpage
title: tis
---

#compositions: tis, `=`#

---
{% for post in site.pages%}
 {% if post.category contains 'tis' %}
##[{{ post.title }}]({{ post.url }})##
{{ post.content }}

---
{% endif %}
{% endfor %}






