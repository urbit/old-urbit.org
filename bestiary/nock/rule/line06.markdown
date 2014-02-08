---
layout: subpage
category: nock
title: bracket grouping
---

```text
6  ::    [a b c]           [a [b c]]
```
Ie, brackets (in our pseudocode, as in Hoon) associate to the right.  For those
with Lisp experience, it's important to note that Nock and Hoon use tuples or
"improper lists" much more heavily than Lisp.  The list terminator, normally 0,
is never automatic.  So the Lisp list 

```text
(a b c)
```
becomes the Nock noun

```text
[a b c 0]
```
which is equivalent to

```text
[a [b [c 0]]]
```
Note that we can and do use unnecessary brackets anyway, for
emphasis.


