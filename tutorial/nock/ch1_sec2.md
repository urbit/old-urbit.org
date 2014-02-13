---
layout: subpage
title: Basic Nock, II
---

[**Prev**: Noun Structure](/tutorial/nock/ch1_sec1)
[**Next**: Operator 3](/tutorial/nock/ch1_sec3)


# Section II: Noun Structure

Last section we played around with this:

```text
~tomsyt-balsen/try=> .*(42 [0 1])
42
```
which corresponds to the pattern
```text
*[a [0 1]]                  a
```

Now we're going to experiment with what happens when we replace `1` with
different values. Remember, as you follow along, type out the examples at your
own Arvo prompt.

```text
~tomsyt-balsen/try=> .*([42 43] [0 1])
[42 43]

~tomsyt-balsen/try=> .*([42 43] [0 2])
42

~tomsyt-balsen/try=> .*([42 43] [0 3])
43

~tomsyt-balsen/try=> .*([42 43] [0 4])
! exit
```

We don't really have enough examples to figure out the pattern yet. Let's
change `[42 43]` to `[[44 45] 43]` and try some more.

```text
~tomsyt-balsen/try=> .*([[44 45] 43] [0 1])
[[44 45] 43] 

~tomsyt-balsen/try=> .*([[44 45] 43] [0 2])
[44 45]

~tomsyt-balsen/try=> .*([[44 45] 43] [0 3])
43

~tomsyt-balsen/try=> .*([[44 45] 43] [0 4])
44

~tomsyt-balsen/try=> .*([[44 45] 43] [0 5])
45

~tomsyt-balsen/try=> .*([[44 45] 43] [0 6])
! exit
```

It looks like anything of the form `*[a [0 b]]` produces the sub-nouns that are
inside of a. Remember that notationally, `*[a [0 b]]` is the same as `.*(a [0
b])` e.g. a is `[[44 45] 43]` and b is one of the atoms `1` through `6`. 

But how does  `*[a [0 b]]` know which pieces of a to choose? 

Let's do one more example and then we'll explain it.

```text
~tomsyt-balsen/try=> .*([42 [46 47]] [0 1])
[42 [46 47]] 

~tomsyt-balsen/try=> .*([42 [46 47]] [0 2])
42

~tomsyt-balsen/try=> .*([42 [46 47]] [0 3])
[46 47]

~tomsyt-balsen/try=> .*([42 [46 47]] [0 4])
! exit

~tomsyt-balsen/try=> .*([42 [46 47]] [0 5])
! exit

~tomsyt-balsen/try=> .*([42 [46 47]] [0 6])
46

~tomsyt-balsen/try=> .*([42 [46 47]] [0 7])
47
```
Try to solve this puzzle on your own by playing with the following:
```text
~tomsyt-balsen/try=> .*(a [0 b])
```
where `a` is a cell and `b` is an atom. Try to pick atoms for `b` that are
small and try to pick cells for `a` that have lots of nesting. 

When you're ready to have things explained to you, read on.

Think of a noun as a tree structure:

```text
  [42 [46 47]]
  /       \
42      [46 47]]
          / \ 
        46   47
```

Every cell has two branches (the head of the cell and the tail) leading down
from it. Atoms have no branches, because they can't be broken down any further
(and this is exactly why they're called atoms).

Let's look at the tree of the other noun we played with, `[[44 45] 43]`:

```text
 [[44 45] 43]
    /      \
[44 45]    43
 /   \
44   45
```
It should be pretty obvious that we could change the values of any of the atoms
in the tree without changing the structure of the tree. That is to say, `[[44
45] 43]` and `[[24 25] 23]` have the same tree structure:

```text
 [[22 25] 23]
    /      \
[22 25]    23
 /   \
22   25
```

And now, for a more complicated tree, here's the noun `[[[48 49] 45] [46 47]]`:

```text
  [[[48 49] 45] [46 47]]
       /            \
 [[48 49] 45]      [46 47]
   /       \        /   \
[48 49]    45      46   47
 /   \
48   49
```
So how do the above trees relate to running `.*(a [0 b])`? Simple, every part
of the tree gets mapped to an atomic address (we call it an axis). The mapping
looks something like this:

```text
           1 
       /       \
     2           3          
   /   \       /   \
  4     5     6     7     
 / \   / \   / \   / \
8   9 10 11 12 13 14 15

```
Or, because the lines are kind of ugly:

```text
         1
    2          3
 4    5     6     7
8 9 10 11 12 13 14 15
```

Of course, this only a very small part of the entire tree. We extend the tree
by applying the rule: Every axis `/n` has a head with the axis`/2n` and a tail
with the axis`/2n+1`"

We map from noun to axis by comparing the tree of the noun with the axis tree
and seeing what matches. Like so, marking axes with a `/` character:

```text
  /1 : [[44 45] 43]
         /        \
 /2 : [44 45]     43 : /3
      /     \
/4 : 44      45 : /5
```

Again, because it bears repeating: the head of axis `/n` is `/2n` and the tail
of axis `/n` is `/2n+1`. Remember that the head is the left-hand noun and the
tail the right-hand noun of a cell-pair.

Start with 1. This is your root axis. All nouns have a valid axis `/1`, even
atoms. and the axis `/1` just refers to the noun itself. In the above example,
axis /1 of `[[44 45] 43]` is just `[[44 45] 43]`. The head of `[[44 45] 43]` is
`[44 45]` and the tail is `43`. Thus, axis `/2` of `[[44 45] 43]` is `[44 45]`
and axis /3 is `43`.

Another way to think about it is that the tree map has layers:

```text
layer 0             1
layer 1        2          3
layer 2     4    5     6     7
layer 3    8 9 10 11 12 13 14 15
```

which correspond to the nesting depth of the noun. If a noun is inside two
cells, like `46` inside `[[[48 49] 45] [46 47]]` then its axis is at layer 2 of
the tree. If its inside three cells like `48`, then its axis is at layer
three.

Recall the pattern we learned in section 1:

```text
*[a [0 1]]                  a
```

This, we now see, is a special case of 

```text
*[a [0 b]]              axis /b of a
```

The 0 in `*[a [0 b]]` is just an operator that means axis. Nock maps simple
operators and functions to atoms, instead of a character like `/` for example,
because atoms (and cells) are all Nock knows. This would Fortunately for us,
there are only eleven atoms that are operators, atoms `0` through `10.`

___

###Summary:

**Noun structure:**

Nouns are trees that look like this:
```text
 [[44 45] 43]
    /      \
[44 45]    43
 /   \
44   45
```
The left-hand of a cell is called the head. The right hand is the tail.

**Axes:**

An axis is the address of a node of the noun tree.

The notation for axis n is /n.

The first part of the axis tree looks like this:
```text
         1
    2          3
 4    5     6     7
8 9 10 11 12 13 14 15
```
The head of axis /n is /(2n) and the tail of axis /n is /(2n+1). 

**Nock Operators:**

The operators in Nock are functions mapped onto the eleven atoms `0` through `10`. 

**Nock 0:**

The Nock operator that produces a given axis of a noun:
```text
*[a [0 b]]               /b of a
```
___

###Exercises:

1. Take pen and paper and map out the axes of             

```text
   [[[48 49] 45] [46 47]]
       /             \
 [[48 49] 45]      [46 47]
   /       \        /   \
[48 49]    45      46   47
 /   \
48   49
```

    then to test yourself, run:

```text
~tomsyt-balsen/try=> .*([[[48 49] 45] [46 47]] [0 b])
```
   for each axis `/b` of `[[[48 49] 45] [46 47]]`

2. Write a noun `a` such that the following produces something:

```text
~tomsyt-balsen/try=> .*(a [0 100])
```
    In other words, find a noun that has an axis `/100`.

3. Prune your noun from the last exercis so that its as short as possible,
while still having an axis `/100`.

4. If you still feel confused, replicate the previous two exercises with the
axes `/7`, `/17`, `/27`, `/47` and `/87`.

5. Build a noun that has every atom set to its own axis. The bigger the noun
the better. I'll get you started:

```text
1
[2 3]
[[4 5] 3]
[[4 5] [6 7]
```
To test different atoms in your noun, run 

```text
~tomsyt-balsen/try=> .*(a [0 b])
```
___


[**Prev**: Noun Structure](/tutorial/nock/ch1_sec1)
[**Next**: Operator 3](/tutorial/nock/ch1_sec3)

