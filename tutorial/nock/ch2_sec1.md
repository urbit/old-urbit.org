---
layout: subpage
title: Operator 7
---


In the last chapter we showed you the Nock specification with lines 32 through 37 removed.
This chapter will explain what these lines are and what they do:

```text
32 ::    *[a 6 b c d]     *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]
33 ::    *[a 7 b c]       *[a 2 b 1 c]
34 ::    *[a 8 b c]       *[a 7 [[7 [0 1] b] 0 1] c]
35 ::    *[a 9 b c]       *[a 7 c 2 [0 1] 0 b]
36 ::    *[a 10 [b c] d]  *[a 8 c 7 [0 3] d]
37 ::    *[a 10 b c]      *[a c]
```

These lines describe the Nock operators 6 through 10, which are just macros that reduce to operators 0 through 5. As you can see, these operators are defined in terms of Nock operators covered in the last chapter.

They add no new functionality to Nock, but we include them in the specification because they are essential to making Nock a practical basis for computation.

##Nock 7

We'll start with the easiest macro: Nock 7

```text
33 ::    *[a 7 b c]       *[a 2 b 1 c]
```
We actually already used Nock 7 in the last chapter while we were explaining Nock 2.

```text
~tomsyt-balsen/try=> .*([42 43] [2 [4 0 3] 1 [3 0 1]])
1
```
Which sequentially applies the formulas `[4 0 3]` and `[3 0 1]` to our subject `[42 43]`. We use Nock 7 whenever we evaluate two formulas on our subject in series. The Nock 1 operator in `*[a 2 b 1 c]` is, as we know, the constant operator, which means that when Nock 2 applies, as in the above example, '[1 [3 0 1]]` to the subject, [3 0 1] is produced.

Let's work through a full reduction of the above example, refer to the specification at the end of the last chapter to get a better sense of where these rules are coming from. And as always, please copy along on pen and paper or in a text file.

```text
*[[42 43] [2 [4 0 3] 1 [3 0 1]]]

      27 ::    *[a 2 b c]       *[*[a b] *[a c]]

*[*[[42 43] [4 0 3]] *[[42 43] 1 [3 0 1]]]
      
      29 ::    *[a 4 b]         +*[a b]

*[+*[[42 43] 0 3] *[[42 43] 1 [3 0 1]]]

      25 ::    *[a 0 b]         /[b a]

*[+/[3 [42 43]] *[[42 43] 1 [3 0 1]]]

      18 ::    /[3 a b]         b

*[+43 *[[42 43] 1 [3 0 1]]]

      11 ::    +a               1 + a

*[44 *[[42 43] 1 [3 0 1]]]

      26 :: *[a 1 b]            b

*[44 [3 0 1]]

      28 ::    *[a 3 b]         ?*[a b]

?*[44 0 1]

      25 ::    *[a 0 b]         /[b a]

?/[1 44]

      16 ::    /[1 a]           a

?44

      9  ::    ?a               1

```

This reduction is overly long because we've included the full reduction sequences for the Nock 0, 3 and 4 operators, which can usually be omitted without loss of clarity. The notation is often helpful, but must be balanced against the needs of conciseness. 

Like so:

```text
*[[42 43] [2 [4 0 3] 1 [3 0 1]]]

    27 ::    *[a 2 b c]       *[*[a b] *[a c]]


*[*[[42 43] [4 0 3]] *[[42 43] 1 [3 0 1]]]

    26 ::    *[a 1 b]         b

*[*[[42 43] [4 0 3]] [3 0 1]]

    29 ::    *[a 4 b]         +*[a b]

*[44 [3 0 1]]

    28 ::    *[a 3 b]         ?*[a b]

```
The student of Nock should be able to fill in the missing steps in their heads.

Informally, the formula `[7 b c]` composes the formulas `b` and
`c`.  To use a bit of math notation, if `d` is `[7 b c]`,

```text
d(a) == c(b(a))
```
Let's see how this works by applying some reductions to the
definition of `7`, and producing a simpler definition that
doesn't look like a macro:


**`7` Reduction:**

```text

*[p 7 q r]

33 ::    *[a 7 b c]        *[a 2 b 1 c]

*[p 2 q 1 r]

27 ::    *[a 2 b c]        *[*[a b] *[a c]] 

*[*[p q] *[p 1 r]]

26:    *[a 1 b]          b
 
*[*[p q] r]
 
```

**`7` Reduced:**

```text
33r ::     *[a 7 b c]         *[*[a b] c]
```
