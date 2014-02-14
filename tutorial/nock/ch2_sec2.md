---
layout: subpage
title: Operator 8
---

```text
34 ::    *[a 8 b c]       *[a 7 [[7 [0 1] b] 0 1] c]

34r ::    *[a 8 b c]       *[[*[a b] a] c]
```

**`8` Reduction:**

```text

*[p 8 q r] 

34 ::    *[a 8 b c]        *[a 7 [[7 [0 1] b] 0 1] c]

*[p 7 [[7 [0 1] q] 0 1] r]   

33r ::     *[a 7 b c]         *[*[a b] c]

*[*[p [7 [0 1] q] 0 1]] r]

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[[*[p [7 [0 1] q]] *[p 0 1]] r]

25 ::    *[a 0 b]          /[b a]

*[[*[p [7 [0 1] q]] /[1 p]] r]

16 ::    /[1 a]            a

*[[*[p [7 [0 1] q]] p] r]

33r ::     *[a 7 b c]         *[*[a b] c]

*[[*[*[p 0 1]] q] p] r]

25 ::    *[a 0 b]          /[b a]

*[[*[/[1 p] q] p] r]

16 ::    /[1 a]            a

*[[*[p q] p] r]

```
**`8` Reduced:**

```text
34r ::     *[a 8 b c]        *[[*[a b] a] c]
```


Nock 8 evaluates the formula `c` with the cell of `*[a b]` and the original
subject `a`.  In other words, in math notation, if `d` is `[8 b c]`,

```text
d(a) == c([b(a) a])
```
But why?  Suppose, for the purposes of `c`, we need not just `a`,
but some intermediate noun computed from `a` that will be useful
in `c`'s calculation.  We apply `c` with a new subject that's a
cell of the intermediate value and the old subject - not at all
unlike pushing a new variable on the stack.

Let's work through some examples:

```text
~tomsyt-balsen/try=> .*(42 [8 [4 0 1] [0 1]])
[43 42]

~tomsyt-balsen/try=> .*([42 45] [8 [[4 0 2] [4 0 3]] [0 1]])
[[43 46] 42 45]
```
For extra credit, a good question to ask yourself: In line 34,

```text
    34 ::    *[a 8 b c]       *[a 7 [[7 [0 1] b] 0 1] c]
```
why do we need to write `[7 [0 1] b]` and not just `b`?

