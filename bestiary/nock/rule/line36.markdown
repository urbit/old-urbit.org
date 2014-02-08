---
layout: subpage
category: nock
title: nock 10, hint
---


**`10` Reduction:**

```text
36 :: *[a 10 [b c] d]   *[a 8 c 7 [0 3] d]

34r ::     *[a 8 b c]        [[*[a b] a] c]

*[[*[a c] a] 7 [0 2] d]

33r ::     *[a 7 b c]        *[*[a b] c]

*[*[[*[a c] a] 0 3] d]
```
**`10` reduced:**

```text
36r ::    *[a 10 [b c] d]   *[*[[*[a c] a] 0 3] d]

33 ::    *[a 10 b c]       *[a c]
```
If `b` is an atom and `c` is a formula, the formula `[10 b c]` appears to be
equivalent to `c`. Likewise if `[b c]` is a cell, `[10 [b c] d]` appears to be
equivalent to `d`.

`10` is actually a hint operator.  The `b` or `[b c]`is discarded information -
it is not used, formally, in the computation.  It may help the interpreter
compute the expression more efficiently, however.

Every Nock computes the same result - but not all at the same speed.  What
hints are supported?  What do they do?  Hints are a higher-level convention
which do not, and should not, appear in the Nock spec.  Some are defined in
Hoon.  Indeed, a naive Nock interpreter not optimized for Hoon will run Hoon
quite poorly.  When it gets the product, however, the product will be right.

(Why is the c in `[b c]` is computed?  Because `c` could crash.  A correct
Nock cannot simply ignore it, and treat both variants of `10` as equivalent.)
