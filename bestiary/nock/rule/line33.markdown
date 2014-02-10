---
layout: subpage
category: nock
title: nock 7, function composition
---

**`7` Reduction:**

```text
33 ::    *[a 7 b c]        *[a 2 b 1 c]

*[a 2 b 1 c]

27 ::    *[a 2 b c]        *[*[a b] *[a c]] 

*[*[a b] *[a 1 c]]

26:    *[a 1 b]          b
 
*[*[a b] c]
 
```

**`7` Reduced:**

```text
33r ::     *[a 7 b c]         *[*[a b] c]
```
`7` is an old mathematical friend, function composition.  It's
easy to see how this is built out of `2`.  The data to evaluate
is simply `b`, and the formula is `c` quoted.


