---
layout: subpage
category: nock
title: pseudocode
---

```text
8  ::    ?[a b]           0
9  ::    ?a               1
10 ::    +[a b]           +[a b]
11 ::    +a               1 + a
12 ::    =[a a]           0
13 ::    =[a b]           1
```
Here we define more pseudocode operators, which we'll use in reductions further
down.  So far we have four built-in functions: `*` meaning Nock itself, `?`
testing whether a noun is a cell or an atom, `+` incrementing an atom, and `=`
testing for equality.  Again, no rocket science here.

We should note that in Nock and Hoon, `0` (pronounced "yes") is true, and `1`
("no") is false.  Why?  It's fresh, it's different, it's new.  And it's
annoying.  And it keeps you on your toes.  And it's also just intuitively
right.

