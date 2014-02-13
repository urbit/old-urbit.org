---
layout: subpage
title: Basic Nock
---

[**Prev**: Operators 2 and 5](/tutorial/nock/ch1_sec5)
[**Next**: Chapter II](/tutorial/nock/ch2_sec1)

#Section VI: Specification

Let's list out all the rules we've learned so far, with the explanations collapsed:

```text
A noun is an atom or a cell.  
An atom is a natural number.  
A cell is an ordered pair of nouns. 
 

[a b c]              [a [b c]]

?(cell)               0
?(atom)               1
+(cell)               ! exit
+(atom)               1 + atom
=([a a])              0 
=([a !a])              1
=(atom)               ! exit


*[a 0 b]              /b of a
*[a 1 b]              b 
*[a 2 b c]            *[*[a b] *[a c]]
*[a 3 b]              ?(*[a b])
*[a 4 b]              +(*[a b])
*[a 5 b]              =(*[a b])

*[a [b c] d]          [*[a b c] *[a d]] 

```
That looks cleaner. Now let's look at an abridged version of the real Nock spec, which you should now be able to mostly read


```text
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
...
38 ::
39 ::    *a               *a
```

Since the Nock spec has been designed to be as concise as possible, a couple things are notationally different from the rules we've learned. 

The largest difference is the block that defines what the `/` or axis operator does:

```text
16 ::    /[1 a]           a
17 ::    /[2 a b]         a
18 ::    /[3 a b]         b
19 ::    /[(a + a) b]     /[2 /[a b]]
20 ::    /[(a + a + 1) b] /[3 /[a b]]

```
This block of pseudocode is functionally equivalent to saying:

The head of axis `/n` is `/(2n)` and the tail of axis `/n` is `/(2n+1).` 

If you read and understood Section II, you understand what this is doing, even if you can't parse the actual code. It's worth trying to figure out. Work through how lines 16 through 20 reduce eeach axis, starting with /1 and counting upward. Lines 19 and 20 look a little tricky, essentially line 19 is what you use to reduce all even axes greater than /2 and line 20 is for odd axes greater than /3. 

For example, let's say you have /4:

```text

/[4 p]

19 ::    /[(a + a) b]     /[2 /[a b]]

/[(2 + 2) p] 

/[2 /[2 p]]

```

if `p` is `[[44 45] 43]`, then `/[2 p]]` is `[44 45]`. Thus, `[4 p]` is
`/[2 /[2 p]]`, or `/[2 [44 45]]`, which is `44`.

Try to figure out axes `/5` through `/10` on your own. 

Going back to the specification, the next most obvious difference is between

```text
8  ::    ?[a b]           0
9  ::    ?a               1
10 ::    +[a b]           +[a b]
11 ::    +a               1 + a
12 ::    =[a a]           0
13 ::    =[a b]           1
14 ::    =a               =a
```

and 

```text
?(cell)               0
?(atom)               1
+(cell)               ! exit
+(atom)               1 + atom
=([a a])              0 
=([a !a])             1
=(atom)               ! exit
```

We'll work through the evolution of this block:

First thing is that since we're trying to make the Nock specification small, we can get rid of the parentheses:

```text
?cell               0
?atom               1
+cell               ! exit
+atom               1 + atom
=[a a]              0 
=[a !a]             1
=atom               ! exit

```
Then we can remove the words `cell` and `atom.` Since the rules in the nock spec match top to bottom, we can specify matching a rule to a cell or atom by putting an `[a b]` above an `a`. A cell will match `[a b]` and and atom will not, therefore because all cells will match `[a b]`, only atoms will match `a` below `[a b]`.

```text
?[a b]             0
?a                 1
+[a b]             ! exit
+a                 1 + atom
=[a a]             0 
=[a !a]            1
=a                 ! exit

```

Next thing we can do, along the same principle, is change `!a` to `b`, because `[a b]` below `[a a]` will only match to a pair of unequal nouns.

```text
?[a b]             0
?a                 1
+[a b]             ! exit
+a                 1 + atom
=[a a]             0 
=[a !a]            1
=a                 ! exit
```

Then there's these lines, which we call our crash defaults:

```text
10 ::    +[a b]           +[a b]
14 ::    =a               =a
21 ::    /a               /a
39 ::    *a               *a
```
Basically the crash defaults determine when Nock needs to return an ! exit, because something is nonsensical. In theory these lines imply that Nock spins forever in an infinite loop, in practice, Nock will just crash.

```text
10 ::    +[a b]           +[a b]

```

means that Nock crashes if you try to increment a cell 

```text
14 ::    =a               =a
```

means that Nock crashes if you try run an equality test on an atom

```text
   21 ::    /a               /a
```
means that Nock crashes if you try to reference a noun axis that doesn't exist

```text
39 ::    *a               *a
```
means that if you try to run something that's not a valid formula (i.e. doesn't match any of the preceding lines 1 through 38) through Nock, you guessed it, Nock crashes.

Replacing ! exit in our rules with the appropriate crash default, we get the canoncial Nock specification:

```text
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
...
38 ::
39 ::    *a               *a

```

And that's it! That's essentially really all there is to Nock. Everything else in Urbit, including the elided lines 32 through 37, is just a structure built on top of some combination of what you now already know. Next Chapter we'll learn some basic Nock macros, lines d lines 32 through 37, that, for convenience, are included in the canonical Nock specification. 


[**Prev**: Operators 2 and 5](/tutorial/nock/nock5)
[**Next**: Chapter II](/tutorial/nock/ch2_sec1)

