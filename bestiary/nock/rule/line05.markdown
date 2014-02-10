---
layout: subpage
category: nock
title: nock function
---

```text
5  ::    nock(a)           *a
```
Nock is a pure (stateless) function from noun to noun.  In our pseudocode (and
only in our pseudocode) we express this with the prefix operator `*`.

Normally `a` in `nock(a)` is a cell `[s f]`, or as we say

```text
[subject formula]
```
Intuitively, the formula is your function and the subject is its argument.  We
call them something different because Hoon, or any other high-level language
built on Nock, will build its own function calling convention which *does not*
map directly to `*[subject formula]`.


