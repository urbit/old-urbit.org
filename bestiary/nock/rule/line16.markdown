---
layout: subpage
category: nock
title: trees
---

```text
16 ::    /[1 a]           a
17 ::    /[2 a b]         a
18 ::    /[3 a b]         b
19 ::    /[(a + a) b]     /[2 /[a b]]
20 ::    /[(a + a + 1) b] /[3 /[a b]]
```
Slightly more interesting is our tree numbering.  Every noun is of course a
tree.  The `/`, or axis, operator imposes an address space on that tree,
mapping every nonzero atom to a tree position.

1 is the root.  The head of every node `n` is `2n`; the tail is `2n+1`.  Thus a
simple tree:

```text
     1
  2      3
4   5  6   7
         14 15
```
If the value of every leaf is its tree address, this tree is

```text
  [[4 5] [6 14 15]]
```


