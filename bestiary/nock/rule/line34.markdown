---
layout: subpage
category: nock
title: nock 8, declaration
---


**`8` Reduction:**

```text
34 ::    *[a 8 b c]        *[a 7 [[7 [0 1] b] 0 1] c]

*[a 7 [[7 [0 1] b] 0 1] c]   

33r ::     *[a 7 b c]         *[*[a b] c]

*[*[a [7 [0 1] b] 0 1]] c]

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[[*[a [7 [0 1] b]] *[a 0 1]] c]

25 ::    *[a 0 b]          /[b a]

*[[*[a [7 [0 1] b]] /[1 a]] c]

16 ::    /[1 a]            a

*[[*[a [7 [0 1] b]] a] c]

33r ::     *[a 7 b c]         *[*[a b] c]

*[[*[*[a 0 1]] b] a] c]
```
**`8` Reduced:**

```text
34r ::     *[a 8 b c]        *[[*[a b] a] c]
```

`8` is similar to `7`, except that the subject for `c` is not simply the
product of `b`, but the ordered pair of the product of `b` and the original
subject. 

Why would we want to do this?  Imagine a higher-level language in which the
programmer declares a variable.  This language is likely to generate an `8`,
because the variable is computed against the present subject, and used in a
calculation which depends both on the original subject and the new variable.
