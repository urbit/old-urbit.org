---
layout: post
category: doc
title: Urbit is Easy&#58; Chapter II (Intro to Nock)
---

*"What one fool can do, another can"*  
**(Ancient Simian proverb)**

Now that we've installed Arvo, let's learn Nock.

Think of Nock as a kind of functional assembly language.  It's
not like assembly language in that it's directly executed by the
hardware.  It is like assembly language in that (a) everything in
Urbit executes as Nock; (b) you wouldn't want to program directly
in Nock; and (c) learning to program directly in Nock is a great
way to start understanding Urbit from the ground up.

Just as Unix runs C programs by compiling them to assembler,
Urbit runs Hoon programs by compiling them to Nock.  You could
try to learn Hoon without learning Nock.  But just as C is a thin
wrapper over the the physical CPU, Hoon is a thin wrapper over
the Nock virtual machine.  It's a tall stack made of thin layers,
which is much easier to learn a layer at a time.

And unlike most fundamental theories of computing, there's really
nothing smart or interesting about Nock.  Of course, in a
strictly formal sense, all of computing is math.  But that
doesn't mean it needs to feel like math.  Nock is a simple
mechanical device and it's meant to feel that way.

##Specification##

Let's start with the Nock spec.  It may look slightly
intimidating, but at least it isn't long.

No, you can't just look at this and tell what it's doing.
But at least there are only 39 lines of it.

    1  ::    A noun is an atom or a cell.  
    2  ::    An atom is a natural number. 
    3  ::    A cell is an ordered pair of nouns.
    4  ::
    5  ::    nock(a)          *a
    6  ::    [a b c]          [a [b c]]
    7  ::
    8  ::    ?[a b]           0
    9  ::    ?a               1
    10 ::    +[a b]           +[a b]
    11 ::    +a               1 + a
    12 ::    =[a a]           0
    13 ::    =[a b]           1
    14 ::    =a               =a
    15 ::
    16 ::    /[1 a]           a
    17 ::    /[2 a b]         a
    18 ::    /[3 a b]         b
    19 ::    /[(a + a) b]     /[2 /[a b]]
    20 ::    /[(a + a + 1) b] /[3 /[a b]]
    21 ::    /a               /a
    22 ::
    23 ::    *[a [b c] d]     [*[a b c] *[a d]]
    24 ::
    25 ::    *[a 0 b]         /[b a]
    26 ::    *[a 1 b]         b
    27 ::    *[a 2 b c]       *[*[a b] *[a c]]
    28 ::    *[a 3 b]         ?*[a b]
    29 ::    *[a 4 b]         +*[a b]
    30 ::    *[a 5 b]         =*[a b]
    31 ::
    32 ::    *[a 6 b c d]     *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]
    33 ::    *[a 7 b c]       *[a 2 b 1 c]
    34 ::    *[a 8 b c]       *[a 7 [[7 [0 1] b] 0 1] c]
    35 ::    *[a 9 b c]       *[a 7 c 2 [0 1] 0 b]
    36 ::    *[a 10 [b c] d]  *[a 8 c 7 [0 3] d]
    37 ::    *[a 10 b c]      *[a c]
    38 ::
    39 ::    *a               *a

Bear in mind: this is pseudocode.  It is neither Nock nor Hoon.
Strictly speaking, it's really just English.  All formal systems
resolve to informal language at the very bottom.  What's
important is just that no two reasonable people can read the spec
to mean two different things.

##Sounds##

In characteristic Urbit style, we got tired of three or
four-syllable pronunciations of ASCII punctuation characters and
assigned them all standard one-syllable names.  We'll meet the
rest later, but the ones we use in Nock:

    `$`   buc
    `/`   fas
    `+`   lus
    `(`   pel
    `)`   per
    `[`   sel
    `]`   ser
    `*`   tar
    `=`   tis
    `?`   wut

##Nouns##

Let's look at the data model first - lines 1-3 above.  Ideally,
you *can* look at this and just tell what it's doing.  But let's
explain it a little anyway.

An atom is a natural number - ie, an unsigned integer.  Nock does
not limit the size of atoms, or know what an atom means.  

For instance, the atom 97 might mean the number 97, or it might
mean the letter 'a' (ASCII 97).  A very large atom might be the
number of grains of sand on the beach - or it might be a GIF of
your children playing on the beach.  Typically when we represent
strings or files as atoms, the first byte is the low byte.  But
even this is just a convention.  An atom is an atom.

A cell is an ordered pair of any two nouns - cell or atom.  We
group cells with square brackets: 

    [1 1] 
    [34 45] 
    [[3 42] 12]
    [[1 0] [0 [1 99]]]

To keep our keyboards from wearing out, line 6 tells us that 
brackets group to the right:

    6  ::    [a b c]           [a [b c]]

So instead of writing
 
    [2 3]
    [2 [6 7]]
    [2 [6 [14 15]]]
    [2 [6 [[28 29] [30 31]]]]
    [2 [6 [[28 29] [30 [62 63]]]]]

we can write

    [2 3]
    [2 6 7]
    [2 6 14 15]
    [2 6 [28 29] 30 31]
    [2 6 [28 29] 30 62 63]

While this notational convenience is hardly rocket science, it's
surprising how confusing it can be, especially if you have a Lisp
background.  Lisp's "S-expressions" are very similar to nouns,
except that Lisp has multiple types of atom, and Lisp's syntax
automatically adds list terminators to groups.  So in Lisp

    '(2 6 7)

is a shorthand for

    '(2 6 7 . nil)

and the equivalent noun is

    [2 6 7 0]

or, of course,

    [2 [6 [7 0]]]

##Rules##

Nock's semantics are defined as a reduction algebra.  To compute
`Nock(x)`, where `x` is any noun, we step through the rules from
the top down, find the first left-hand side that matches `x`, and
reduce it to the right-hand side.  


Right away we see line 5:

    5  ::    Nock(a)           *a

When we use variable names, like `a`, in the pseudocode spec, we
simply mean that the rule fits for any noun `a`.

So `Nock(x)` is `*x`, for any noun `x`.  And how do we reduce
`*x`?  Looking up, we see that lines 23 through 39 reduce `*x` -
for different patterns of `x`.

For example, suppose our `x` is `[5 1 6]`.  Stepping downward
through the rules, the first one that matches is line 26:

    26 ::    *[a 1 b]        b

Line 26 tells us that when reducing any noun of the form `[a 1
b]`, the result is just `b`.  So `*[5 1 6]` is `6`.

For a more complicated example, try 

    *[[19 42] [0 3] 0 2]

The first rule it matches is line 23:

    23 ::    *[a [b c] d]     [*[a b c] *[a d]]

since `a` is `[19 42]`, `b` is `0`, `c` is `3`, and `d` is `[0 2]`.
So this reduces to a new computation

    [*[[19 42] 0 3] *[[19 42] 0 2]]

Each side of this matches rule 25:

    25 ::    *[a 0 b]         /[b a]

So we have

    [/[3 [19 42]] /[2 [19 42]]]

When we explain `/`, we'll see that this is `[42 19]`.

Finally, suppose our `x` is just `42`.  The first rule that
matches is the last:

    39 ::    *a               *a

So `*42` is `*42`, which is... `*42`.  Logically, Nock goes into
an infinite reduction loop and never terminates.

In practice, this is just a clever CS way to specify the simple
reality that `*42` is an error and makes no sense.  An actual
interpreter will not spin forever - it will throw an exception
outside the computation.

##Functions##

We've already seen the `*` function (pronounced "tar"), which
just means `Nock`.  This is the main show and we'll work through
it soon, but first let's explain the functions it uses - `=`, `?`,
`+` and `/`.

###Equals: `=`###

`=` (pronounced "tis", or sometimes "is") tests a cell for
equality.  `0` means yes, `1` means no:

    12 ::    =[a a]           0
    13 ::    =[a b]           1
    14 ::    =a               =a

Again, testing an atom for equality makes no sense and logically
fails to terminate.

###Depth: `?`###

`?` (pronounced "wut") tests whether is a noun is a cell.  Again, 
`0` means yes, `1` means no:

    8  ::    ?[a b]           0
    9  ::    ?a               1

(This convention is the opposite of old-fashioned booleans, so we
try hard to say "yes" and "no" instead of "true" and "false.")

###Increment: `+`###

`+` (pronounced "lus", or sometimes "plus") adds 1 to an atom:

    10 ::    +[a b]           +[a b]
    11 ::    +a               1 + a

Because `+` works only for atoms, whereas `=` works only for
cells, the error rule matches first for `+` and last for `=`.

###Address: `/`###

`/` (pronounced "fas") is a tree address function:

    16 ::    /[1 a]           a
    17 ::    /[2 a b]         a
    18 ::    /[3 a b]         b
    19 ::    /[(a + a) b]     /[2 /[a b]]
    20 ::    /[(a + a + 1) b] /[3 /[a b]]
    21 ::    /a               /a

This looks way more complicated than it is.  Essentially, we
define a noun as a binary tree and assign an address, or *axis*,
to every node in the tree.  The root of the tree has the address `/1`.  The left child of every node at `/n` is `/2n`; the right child is
`/2n+1`.  (Writing `(a + a)` is just a clever way to write `2n`, while minimizing the number of pseudocode forms.)

A complete tree of depth 3 would have the following addresses:

             1
        2          3
     4    5     6     7
    8 9 10 11 12 13 14 15

Let's practice actually addressing a tree. As an example, let's use
`[[97 2] [1 42 0]]` as our initial cell. In our addressing system, the initial cell itself is always the root node of our binary tree, and thus always is always assigned the axis `\1`. So in this case:

    \1 -> [[97 2] [1 42 0]]

This cell, like all cells in Nock, can be represented as `[a b]`,
where `a` is the left subtree and `b` is the right So. The left subtree is the leftmost noun, and the right subtree is the list of all other nouns. In this case, `a` is `[97 2]` and `b` is `[1 42 0]`.

Next let's find the axis of each subtree. As per our binary tree, for any cell with the axis `\1` (the root cell), the axis of its left subtree is always `\2` and the axis of the right subtree is always `\3`. Since our left subtree was `[97 2]`, this means that:

    \2 -> [97 2]

And since our right subtree was `[1 42 0]`, this means that:

    \3 -> [1 42 0]

Of course the nodes at the axes `\2` and `\3` can also be cells that take the form of `[a b]`, as is the case in this example. Thus each node can be broken down into its own subtrees. As per our binary tree diagram, the left noun of the cell at axis `\2` has the axis `\4`:

    \4 -> 97

And the right subtree of the cell at axis `\2` receives the axis `\5`:

    \5 -> 2

The general rule is that for any cell `n`, the axis of the left
subtree is `2n` and the axis of the right subtree is `2n + 1`. So
for our cell with axis `\3`, this means the left and right subtrees have the respective axes:

    \6 -> 1
    \7 -> [42 0]

The reason why the node at axis `\7` has the value `[42 0]` rather than `[42]` is because brackets right associate, so `[1 42 0]` is really `[1 [42 0]]`. This means that our last two nodes receive the axes:

    \14 -> 42
    \15 -> 0

What happens in Arvo when we ask the interpreter to find a noun in a slot that doesn't exist, e.g. 8 through 13 in our example? The answer is that interpreter simply throws an error.

We can also build nouns in which every atom is its own axis: 

    1
    [2 3]
    [2 6 7]
    [[4 5] 6 7]
    [[4 5] 6 14 15]
    [[4 5] [12 13] 14 15]
    [[4 [10 11]] [12 13] 14 15]
    [[[8 9] [10 11]] [12 13] 14 30 31]

Once you've spent enough time programming in Urbit, you'll know
these axes in your dreams.
