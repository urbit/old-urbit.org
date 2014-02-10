---
layout: subpage
category: nock
title: recursion
---

```text
27 ::    *[a 2 b c]        *[*[a b] *[a c]]
```
Line 22 brings us the essential magic of recursion.  `2` is the Nock operator.
If you can compute a subject and a formula, you can evaluate them in the
interpreter.  In most fundamental languages, like Lisp, `eval` is a curiosity.
But Nock has no `apply` - so all our work gets done with `2`.
