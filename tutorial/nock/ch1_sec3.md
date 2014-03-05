---
layout: subpage
title: Basic Nock, III
---

[**Prev**: Noun Structure](/tutorial/nock/ch1_sec2)
[**Next**: Operator 4](/tutorial/nock/ch1_sec4)

# Operator 3

In the last section we learned how to access data inside nouns. Now we're going
to learn what you can do with data. After all, Nock is a computer, so you
should be able to, you know, compute things.


We mentioned in the last section that Nock has eleven operators, `0` through
`10`. We saw `Nock 1` in Section I:

```text
*[a [1 b]]                  b
```

We could describe `Nock `1 the constant operator, since it always produces `b`
no matter what you put in as a.

We also have `Nock 0`, which lets you refer to the sub-noun at the `axis b` of
your subject `a`. 

```text
*[a [0 b]]               /b of a
```

We're going to skip `Nock 2` and cover it in Section V and for now just jump
straight to `Nock 3`.

Before we do, let's quickly go over three new terms that'll help us talk about
operators:

Let's say you have the Nock expression 

```text
*[a [1 b]] 
```

We know that `1` is the operator, but shouldn't we have names for what `a` and
`b` are?

Let's call `a` the subject, because it's being subjected to our computation.
Poor `a`.

We'll call `b` an argument, And we'll call the cell `[1 b]` a formula.
Diagramming it out:

```text
*[a [1 b]] 
*[subject [operator argument]]
*[subject formula]
```

Good, now that we've got vocab out of the way, let's get cooking.

Let's use the big noun `[[[48 49] 45] [46 47]]` from the last section as our subject. 

```text
~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 0])
! exit
```

Uh-oh, Arvo is telling us we just tried to do something indecent and unnatural. 

```text
~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 1])
! exit

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 2])
! exit

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 3])
! exit

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 4])
! exit
```

Looks like `Nock 3` doesn't like atomic arguments. Let's see what happens if we try a cellular one.

```text
~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 [0 1]])
0
```

Okay, so at least that does something.

Let's try some more:

```text
~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 [0 2]])
0

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 [0 3]])
0

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 [0 4]])
0

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [3 [0 5]])
1
```

Wait, what?

Hold on, aren't `[0 1]` or `[0 5]` valid Nock formulas on their own?  If `3`
only takes cells, and formulas are cells, maybe it matters what the formula
does on its own.

Let's try that sequence again without `Nock 3`:

```text
~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [0 1])
[[[48 49] 45] [46 47]]

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [0 2])
[[48 49] 45]

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [0 3])
[46 47]

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [0 4])
[48 49]

~tomsyt-balsen/try=>.*([[[48 49] 45] [46 47]] [0 5])
45
```

One of these things is not like the others. Looks like something changes
whether the formula `[0 n]` refers to an atom or a cell in our subject.

Let's see what happens if we run Nock 3 with `[0 1]` as its argument and try
some different subjects:

```text
~tomsyt-balsen/try=>.*([42 42] [3 [0 1]])
0

~tomsyt-balsen/try=>.*(42 [3 [0 1]])
1

~tomsyt-balsen/try=>.*([1 1] [3 [0 1]])
0

~tomsyt-balsen/try=>.*(1 [3 [0 1]])
1
```

Looks like that's `0` for cells and `1` for atoms. Which means that `Nock 3` is
cell/atom tester. 

How's that work?

`Nock 3`'s argument is itself a formula. Let's call it `b`.

```text
*[subject-a [3 formula-b]]
```

`Nock 3` produces either a `0` or a `1`, depending on what formula-b does when
applied to subject-a:

```text
*[subject-a formula-b]
```

Or more simply:

```text
*[a b]
```

If `*[a b]` produces a cell, then `*[a [3 b]]` produces 0. If `*[a b]` produces
an atom, `*[a [3 b]]` produces 1. So our pattern for Nock 3 is:

```text
*[a [3 b]]         ?(*[a b])
?(cell)            0
?(atom)            1
```

`?(x)` is just a litte functional notation so that we can write out both possible branches.

We should also note that Urbit uses the atom `0` to mean "yes" and the atom `1`
to mean "no." (this may seem different and annoying. it is, but it's
the same thing that Unix does).

In that context, `Nock `3 is just asking the question "Is the product of these two nouns a cell?

Let's review what we've learned:

___

###Summary:

**Vocabulary:**

The subject is the noun that gets computed.

The operator is an atom that tells us how to Nock the subject and arguments.

The arguments modify the behaviour of the operator.

A formula is a cell of `[operator arguments]`

As a chart:

```text
*[a [1 b]] 
*[subject [operator arguments]]
*[subject formula]
```

**Yes and No**

Atom 0 means "yes" 
Atom 1 means "no." 

**Nock 3**

Nock 3 is a cell tester.

```text
*[a [3 b]]         ?(*[a b])
?(cell)            0
?(atom)            1
```
___

###Exercises:

1. Run and compare

```text
~tomsyt-balsen/try=>.*(a b)
```
    and 

```text
~tomsyt-balsen/try=>.*(a [3 b])
```
    with different values for a and b.

2. Try finding a value for `b` that will return `1` if `a` is the atom `42`:

```text
~tomsyt-balsen/try=>.*(42 [3 b])
```
    Not only is this possible, but you already know the formula to do it.
___

[**Prev**: Noun Structure](/tutorial/nock/ch1_sec2)
[**Next**: Operator 4](/tutorial/nock/ch1_sec4)
