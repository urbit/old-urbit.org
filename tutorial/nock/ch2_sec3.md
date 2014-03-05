---
layout: subpage
title: Operator 6
---

```text
32 ::    *[a 6 b c d]     *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]

32r ::    *[a 6 b c d]     *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]
```

**`6` Reduction:**

```text

*[p 6 q r s]

32 ::    *[a 6 b c d]      *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]

*[p 2 [0 1] 2 [1 r s] [1 0] 2 [1 2 3] [1 0] 4 4 q]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[*[p 0 1] *[p 2 [1 r s] [1 0] 2 [1 2 3] [1 0] 4 4 q]]

25 ::    *[a 0 b]          /[b a]

*[p *[p 2 [1 r s] [1 0] 2 [1 2 3] [1 0] 4 4 q]]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[p *[*[p [1 r s]] *[p [1 0] 2 [1 2 3] [1 0] 4 4 q]]]

26 ::    *[a 1 b]          b

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[p *[[r s] [*[p 1 0] *[p 2 [1 2 3] [1 0] 4 4 q]]]]

26 ::    *[a 1 b]          b

*[p *[[r s] [0 *[p 2 [1 2 3] [1 0] 4 4 q]]]]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[p *[[r s] [0 *[*[p [1 2 3]] *[p [1 0] 4 4 q]]]]]

26 ::    *[a 1 b]          b

*[p *[[r s] [0 *[[2 3] *[p [1 0] 4 4 q]]]]]

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[p *[[r s] [0 *[[2 3] [*[p [1 0]] *[p 4 4 q]]]]]]

26 ::    *[a 1 b]          b

*[p *[[r s] [0 *[[2 3] [0 *[p 4 4 q]]]]]]

29 ::    *[a 4 b]          +*[a b]

*[p *[[r s] [0 *[[2 3] [0 ++*[p q]]]]]]
```

**`6` Reduced:**

```text
32r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]
```

Actually, `6` is a primitive known to every programmer - good old
"if."  If `b` evaluates to `0`, we produce `c`; if `b` evaluates
to `1`, we produce `d`; otherwise, we crash.

For instance:

```text
~tomsyt-balsen/try=> .*(42 [6 [1 0] [4 0 1] [1 233]])
43
```
and

```text
~tomsyt-balsen/try=> .*(42 [6 [1 1] [4 0 1] [1 233]])
233
```

We can actually simplify the semantics of `6`, at the expense of
breaking the system a little, by creating a macro that works as
"if" only if `b` is a proper boolean and produces `0` or `1`.

This simpler "if" would be:

```text
32s::    *[a 6 b c d]    *[a 2 [0 1] 2 [1 c d] [1 0] [4 4 b]]
```
This reduces to

```text
32sr::   *[a 6 b c d]     *[a *[[c d] [0 ++*[a b]]]]
```
Let's describe what each of `a`, `b`, `c` and `d` are.

`a` is our subject, some data that we want to run our `if` on

`b` is our test formula, which returns a `yes` or a `no` when we apply it to our subject. 

`c` is our `then` formula, which we want to apply to our subject if our test formula produces a `yes`, i.e. a 0.

`d` is our `else` formula, which we want to apply to our subject if our test formula produces a `no`, i.e. a 1.

Let's say we have the following Nock expression:

```text
~tomsyt-balsen/try=> .*(42 [6 [3 0 1] [4 0 2] [4 0 1]])
43
```
Our `test` is the formula [3 0 1], which tests if the subject is a cell.

Our `then` is the formula [4 0 2], which increments the head of a cell.

Our `else` is the formula [4 0 1], which increments an atom.

If we changed our subject to a cell:

```text
~tomsyt-balsen/try=> .*([40 43] [6 [3 0 1] [4 0 2] [4 0 1]])
41
```
With our simpler reduced if rule:

```text
32sr::   *[a 6 b c d]     *[a *[[c d] [0 ++*[a b]]]]
```
we could rewrite 

```text
*[42 [6 [3 0 1] [4 0 2] [4 0 1]]]
```
as 

```text
*[42  *[[[4 0 2] [4 0 1]] [0 ++*[42 [3 0 1]]]]]
```
Since `*[42 [3 0 1]]` produces a `no`, i.e a `1`:

```text
*[42  *[[[4 0 2] [4 0 1]] [0 ++1]]]]
```
which gets incremented twice
```text
*[42  *[[[4 0 2] [4 0 1]] [0 3]]]
```
and goes into a Nock 0 to select the tail of `[[4 0 2] [4 0 1]]`

```text
*[42 [4 0 1]]
```
which increments 42 to produce 43. You should be able to see how changing the subject to the cell `[40 43]` would cause a `0` to be produced by the test, and how that would cascade into the `then` formula `[4 0 2]` being selected and applied instead.

Our real `if` is only slightly more complicated:

```text
32r ::    *[a 6 b c d]     *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]
```
There appears to be an extra step here, using Nock 0 twice, first to select from the cell [2 3], and then to select from the cell [c d]. 

The reason is fairly simple, if we just used the simpler version of `if`, tests that returned values other than 0 or 1 would have unexpected behaviour. If our our test produced a `3` we would then try to reference the axis /5 in our cell [c d]. Since the tail of `d` could very well be a valid formula, strange things could result.

We add the step of selecting from [2 3] because trying to reference anything other than /2 or /3 within [2 3] will crash, which is exactly what we want. (/1 of [2 3] won't crash, but this is fine since our test can never produce a -1)

