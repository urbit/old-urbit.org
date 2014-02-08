---
layout: subpage
category: nock
title: cell test, increment, equality
---

```text
28 ::    *[a 3 b]         ?*[a b]
29 ::    *[a 4 b]         +*[a b]
30 ::    *[a 5 b]         =*[a b]
```
In lines 23-25, we meet our axiomatic functions again:

For instance, if `x` is a formula that calculates some product, `[3 x]` would test whether the product is a cell. [4 x]` would increments the product (if atomic)`. [5 x]` would test whether the head and tail of the product were the same (if cellular).
