---
layout: subpage
category: nock
title: nock 6, if, then, else
---

**`6` Reduction:**

```text
32 ::    *[a 6 b c d]      *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]

*[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[*[a 0 1] *[a 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]]

25 ::    *[a 0 b]          /[b a]

*[a *[a 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[a *[*[a [1 c d]] *[a [1 0] 2 [1 2 3] [1 0] 4 4 b]]]

26 ::    *[a 1 b]          b

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[a *[[c d] [*[a 1 0] *[a 2 [1 2 3] [1 0] 4 4 b]]]]

26 ::    *[a 1 b]          b

*[a *[[c d] [0 *[a 2 [1 2 3] [1 0] 4 4 b]]]]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[a *[[c d] [0 *[*[a [1 2 3]] *[a [1 0] 4 4 b]]]]]

26 ::    *[a 1 b]          b

*[a *[[c d] [0 *[[2 3] *[a [1 0] 4 4 b]]]]]

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[a *[[c d] [0 *[[2 3] [*[a [1 0]] *[a 4 4 b]]]]]]

26 ::    *[a 1 b]          b

*[a *[[c d] [0 *[[2 3] [0 *[a 4 4 b]]]]]]

29 ::    *[a 4 b]          +*[a b]

*[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]
```

**`6` Reduced:**

```text
	32r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]
```
`6` is a primitive known to every programmer - good old "if."  If `b` evaluates
to `0`, we produce `c`; if `b` evaluates to `1`, we produce `d`; otherwise, we
crash. We could have defined "if" as a built-in function, like increment
by arbitrarily inventing another operator:

```text
::    $[0 b c]         b
::    $[1 b c]         c
```
Then we could restate `6` quite compactly:

```text
32c::    *[a 6 b c d]     *[a $[*[a b] c d]]
```

However, since we _can_ write `if` as a macro, albeit a funky macro, we do so
as to keep the Nock specification small.

In real life, of course, the Nock implementor knows that `6` is "if" and
implements it as such. It's worth noting that in practical, compiler-generated
Nock, we never do anything as funky as these `6` macro internals.  There's no
reason we couldn't build formulas at runtime, but we have no reason to and we
don't - except when actually metaprogramming.  As in most languages, normally
code is code and data is data.

