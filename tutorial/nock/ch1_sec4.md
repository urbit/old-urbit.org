---
layout: subpage
title: Basic Nock, IV
---

[**Prev**: Operator 3](/tutorial/nock/ch1_sec3)
[**Next**: Operators 2 and 5](/tutorial/nock/ch1_sec5)

#Section IV: Operator 4

Last section we learned how to test whether a noun is an atom or a cell with
`Nock 3`. Now we're going to figure out what `Nock 4` does.

Let's start playing with `Nock 4`, using `[[44 45] 46]` as our subject:

```text
~tomsyt-balsen/try=>.*([[44 45] 46] [4 0])
! exit

~tomsyt-balsen/try=>.*([[44 45] 46] [4 1])
! exit

~tomsyt-balsen/try=>.*([[44 45] 46] [4 2])
! exit
```

Okay, this is starting to feel a lot like `Nock 3`. Looks like `Nock 4` doesn't
like atoms either. Remember that `Nock 3` took a cell that was a formula as its
argument:

```text
*[subject [3 formula]]
```

And then depending on what the expression

```text
*[subject formula]
```

produced, `Nock 3` would return a `0` or `1`, according to the function `?(x)`
that we defined:

```text
*[a [3 b]]         ?(*[a b])
?(cell)            0
?(atom)            1
```

Let's assume that Nock 4 operates in a similar way. Let's use the formula `[0
n]` to try to apply Nock 4 to different axes in our subject:

```text
~tomsyt-balsen/try=>.*([[44 45] 46] [4 [0 1]])
! exit

~tomsyt-balsen/try=>.*([[44 45] 46] [4 [0 2]])
! exit

~tomsyt-balsen/try=>.*([[44 45] 46] [4 [0 3]])
47
```

Well! That's blessedly simple then. Watch:

```text
~tomsyt-balsen/try=>.*([[44 45] 46] [0 3])
46

~tomsyt-balsen/try=>.*([[44 45] 46] [4 [0 3]])
47
```

Can you guess what 

```text
~tomsyt-balsen/try=>.*([[44 45] 46] [4 [0 4]])
```

would produce?

If you said 

```text
~tomsyt-balsen/try=>.*([[44 45] 46] [4 [0 4]])
45
```

then you're starting to get the hang of this. Yes, ladies and gentlemen, `Nock
4` is increment. Nock together your subject and the formula in your argument,
and whatever that produces, add 1 to it.

But what if `*[subject formula]` produces a cell instead of an atom? How do we
add `1` to a cell? Simple, we don't. The sun continues to rise in the east,
pigs remain regretfully earthbound, Hell is still rather toasty, and
incrementing a cell in Nock produces an ! exit:

```text
~tomsyt-balsen/try=>.*([[44 45] 46] [4 [0 2]])
! exit
```

Assuming we understood how `Nock 3` worked, writing down our pattern for `Nock 4` is easy:

Nock 3:

```text
*[a [3 b]]         ?(*[a b])
?(cell)            0
?(atom)            1
```

Nock 4:

```text
*[a [4 b]]         +(*[a b])
+(cell)            ! exit
+(atom)            1 + atom
```
`+(x)` is, again, just some notation so we can write out both branches of Nock
4.

An interesting property of Nock 4 is that  we can chain it together to
increment successive times.

```text
~tomsyt-balsen/try=>.*(44 [4 [0 1]])
45

~tomsyt-balsen/try=>.*(44 [4 [4 [0 1]]])
46

~tomsyt-balsen/try=>.*(44 [4 [4 [4 [0 1]]]])
47

~tomsyt-balsen/try=>.*(44 [4 [4 [4 [4 [0 1]]]]])
48

~tomsyt-balsen/try=>.*(44 [4 [4 [4 [4 [4 [0 1]]]]]])
49
```

Those brackets are starting to really pile up. Which is making this whole
process a lot less legible than we would like.

Fortunatley Nock has a notational rule that'll let us not have to write so many
of those brackets.

```text
~tomsyt-balsen/try=>.*(44 [4 [4 [4 [4 [4 [0 1]]]]]])
49

~tomsyt-balsen/try=>.*(44 [4 4 4 4 4 0 1])
49
```

Woah. That's a lot cleaner. 

Concisely, Nock considers brackets to group to the right. If you'll recall from back in section 1:

```text
A noun is an atom or a cell.
An atom is a natural number.
A cell is an ordered pair of two nouns. I.e. two atoms, two cells, or a cell and an atom.
```

Which means that formally, all nouns in Nock are either singletons (atoms) or
cells (pairs). There are no triples, quadruples, or n-tuples:

```text
[a b c]
[a b c d]
[a b c d e]
```

etc.

But because a triple like [a b c] doesn't exist in Nock, but is easier on the
eyes, we can map a nested pair onto it.

```text
[a b c]         [a [b c]]
```

Which means that the Nock interpreter, whenever it sees a triple (or any
n-tuple, for n>2), just inserts the needed brackets.

Let's do some more examples to help you get the hang of it:

```text
~tomsyt-balsen/try=>.*(44 [4 [4 [4 [4 [4 0 1]]]]])
49

~tomsyt-balsen/try=>.*(44 [4 [4 [4 [4 4 0 1]]]])
49

~tomsyt-balsen/try=>.*(44 [4 [4 [4 4 4 0 1]]])
49

~tomsyt-balsen/try=>.*(44 [4 [4 4 4 4 0 1]])
49

~tomsyt-balsen/try=>.*(44 [4 4 4 4 4 0 1])
49
```

We can't get rid of the last pair though:

```text
~tomsyt-balsen/try=>.*(44 4 4 4 4 4 0 1)
~ <syntax error at [1 18]>
```

This is just an artifact of Arvo's Nock interpreter, which we directly access
with the `.*` function, pronounced `dottar` (dot-star, get it?). `.*` takes two
arguments, a subject and a formula:

```text
.*(subject [formula])
```

And for inscrutable reasons, the formula has to be in brackets. As does the
subject, if it's a cell:

```text
~tomsyt-balsen/try=>.*(44 45 [4 4 4 4 4 0 2])
~ <syntax error at [1 9]>

~tomsyt-balsen/try=>.*([44 45] [4 4 4 4 4 0 2])
49
```

Let's review:

___

###Summary:

**Nock 4:**

```text
*[a [4 b]]         +(*[a b])
+(cell)            ! exit
+(atom)            1 + atom
```

**Brackets:**

Brackets group to the right.

```text
[a b c]         [a [b c]]
```

**Nock interpreter:**

`.*` is pronounced "dottar"

Takes two arguments, subject and formula:

```text
.*(subject [formula])
```

formula must be bracketed.

___

###Exercises:

1. Chain together Nock 4 and Nock 3, so that cells produce 2 and atoms produce 3.
2. Write a formula that always returns the cell [4 0 1].
___

[**Prev**: Operator 3](/tutorial/nock/ch1_sec3)
[**Next**: Operators 2 and 5](/tutorial/nock/ch1_sec5)
