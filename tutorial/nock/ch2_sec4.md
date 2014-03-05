---
layout: subpage
title: Operator 10
---

```text
36 ::    *[a 10 [b c] d]  *[a 8 c 7 [0 3] d]
37 ::    *[a 10 b c]      *[a c]
```

**`10` Reduction:**

```text

*[p 10 [q r] s] 

36 :: *[a 10 [b c] d]   *[a 8 c 7 [0 3] d]

*[p 8 r 7 [0 3] d]

34r ::     *[a 8 b c]        [[*[a b] a] c]

*[[*[p r] p] 7 [0 2] s]

33r ::     *[a 7 b c]        *[*[a b] c]

*[*[[*[p r] p] 0 3] s]
```

**`10` reduced:**

```text
36r ::    *[a 10 [b c] d]   *[*[[*[a c] a] 0 3] d]

33 ::    *[a 10 b c]       *[a c]
```

The second case of 10 is so easy it's puzzling:

```text
37 ::    *[a 10 b c]      *[a c]
```
For any `b`, the formula `[10 b c]` seems to be perfectly
equivalent to the formula `c`.  But why?  Why would we say
`[10 b c]` when we could just say `c`?

The answer is that `10` is a hint to the interpreter.  It's true
that `[10 b c]` has to be *semantically* equivalent to `c`, but
it doesn't have to be *practically* equivalent.  Since whatever
information is in `b` is discarded, a practical interpreter is
free to ignore it, or to use it in any way that does not affect
the results of the computation.

And the other reduction of `10`:

```text
    36 ::    *[a 10 [b c] d]  *[a 8 c 7 [0 3] d]
```
Reducing:

```text
*[a 8 c 7 [0 3] d]

  <<34r::    *[a 8 b c]       *[[*[a b] a] c]>>

*[[*[a c] a] [7 [0 3] d]]

  <<33r::    *[a 7 b c]       *[*[a b] c]>>

*[*[[*[a c] a] 0 3] d]
```
If you've assimilated a bit of Nock already, you may feel the
temptation to reduce this to

```text
*[a d]
```
since it would be very reasonable to think that

```text
*[[*[a c] a] 0 3]
```

is just `a`.  And it seems to be - given the semantics of 8 as
we've explained them.

But there's a problem, which is that `c` might not terminate.
If `c` terminates, this reduction is correct.  Otherwise it's not. 
So the best we can do is:

```text
36r::    *[a 10 [b c] d]  *[*[[*[a c] a] 0 3] d]
```

