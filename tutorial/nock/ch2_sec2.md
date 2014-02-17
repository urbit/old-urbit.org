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
in `c`'s calculation.  We apply `c` to  a new subject that's a
cell of the intermediate value and the old subject - not at all
unlike pushing a new variable on the stack. For example, take the cell `*[46 [0 1]]`. Say we want to apply formula `c` to  the current subject,`46`, in addition to another variable, `0`, that has yet to be declared. We would do this by using`Nock 8`: `*[46 8 [1 0] c]`, which inserts `0` into the subject, which is then in turn  applied to formula `c`: `*[[0 46] c]`. This, however, was a very simple example, as we simply applied the formula `[1 0]` to 46 to create another variable. However, we could also insert more complicated formulas in for `b`, such as `[4 0 1]`, which is increment, or even multiple formulas.     

 Let's work through some more examples:

```text
~tomsyt-balsen/try=> .*(42 [8 [4 0 1] [0 1]])
[43 42]

~tomsyt-balsen/try=> .*([42 45] [8 [[4 0 2] [4 0 3]] [0 1]])
[[43 46] 42 45]
```

In the top example, all we are doing is creating a new variable that is `[42 [4 0 1]`, which is just 42, and then returning the entirety of the subject, as the formula `c` is `[0 1]` in this case, which returns the whole subject. 

In the bottom example, we are incrementing both the head `(/2)`  and tail `(/3)` of the subject with both `[4 0 2]` and `[4 0 3]`, which makes the new subject `[[43 46] 42 45]`. As our formula `c` is nothing more than `[0 1]`, the result is again just the entirety of the subject. 

___

###Exercises:

1.Write a noun that, when nocked, returns a cell containing both its initial subject and its initial subject incremented not once, but twice. 

2.Write a noun with some formula `b` that returns only  the newly-created variable. 
 
Extra credit: In line 34,

```text
    34 ::    *[a 8 b c]       *[a 7 [[7 [0 1] b] 0 1] c]
```
why do we need to write `[7 [0 1] b]` and not just `b`?
Hint: think about what could happen if `b` were just an operator and not a cell
