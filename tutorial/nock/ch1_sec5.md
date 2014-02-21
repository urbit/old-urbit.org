---
layout: subpage
title: Basic Nock, V 
---

[**Prev**: Operator 4](/tutorial/nock/ch1_sec4)
[**Next**: Specification](/tutorial/nock/ch1_sec6)

#Section V: Operators 2 and 5

So we've learned how to do some simple operations with Nock. Now we're going to get a little fancier.


To jog your memory, we've seen the following operators so far:

```text
~tomsyt-balsen/try=> .*([42 43] [0 1])
[42 43]

~tomsyt-balsen/try=> .*([42 43] [1 0])
0

~tomsyt-balsen/try=> .*([42 43] [3 0 1])
0

~tomsyt-balsen/try=> .*([42 43] [4 0 2])
43
```

These have all had the following pattern in common:

```text
*[subject [operator arguments]]
```
with the atomic operator (0, 1, 3 or 4).

What if we replaced that atom with a cell? With a formula, even? Let's try it:

```text
~tomsyt-balsen/try=> .*(42 [[0 1] 0 1])
[42 42]
```

Well that's different. Let's try another subject:

```text
~tomsyt-balsen/try=> .*([42 43] [[0 1] 0 1])
[[42 43] 42 43]
```
And if we change the formulas?

```text
~tomsyt-balsen/try=> .*([42 43] [[0 2] 0 1])
[42 42 43]

~tomsyt-balsen/try=> .*([42 43] [[0 2] 0 2])
[42 42]

~tomsyt-balsen/try=> .*([42 43] [[0 1] 0 2])
[[42 43] 42]
```
It looks like its running both formulas and then just combining the results in a cell.

```text
~tomsyt-balsen/try=> .*([42 43] [[3 0 1] 3 0 2])
[0 1]

~tomsyt-balsen/try=> .*([42 43] [[3 0 1] 4 0 3])
[0 44]

~tomsyt-balsen/try=> .*([42 43] [[1 [0 1]] 4 0 3])
[[0 1] 44]

~tomsyt-balsen/try=> .*([42 43] [[4 0 3] 1 [0 1]])
[44 [0 1]]
```
Yup, the subject is definitely running through both formulas in parallel. The
last example seems to do something like this:

```text
*[[42 43] [4 0 3] 1 [0 1]]         [*[[42 43] [4 0 3]] *[[42 43] 1 [0 1]]]
```
which we can evaluate using Arvo:

```text
~tomsyt-balsen/try=> .*([42 43] [4 0 3])
44

~tomsyt-balsen/try=> .*([42 43] [1 [0 1]])
[0 1]
```
Or by hand, which is good practice. Open up a blank text file or grab a pen and
copy along:

```text
*[[42 43] [4 0 3] 1 [0 1]]  [*[[42 43] [4 0 3]] *[[42 43] 1 [0 1]]]

<<  Nock 4:       *[a [4 b]]          +(*[a b]) >>

[+(*[[42 43] 0 3]]) *[[42 43] 1 [0 1]]]

<<  Nock 0:       *[a [0 b]]          /b of a  >>
       
[+(43) *[[42 43] 1 [0 1]]]

<<     +():       +(atom)             1 + atom  >>

[44 *[[42 43] 1 [0 1]]]

<<  Nock 1:       *[a [1 b]]          b  >>

[44 [0 1]] 
```
Thus,

```text
~tomsyt-balsen/try=> .*([42 43] [[4 0 3] 1 [0 1]])
[44 [0 1]]
```
We could write the first line of the reduction more generally as  

```text
*[subject [formula1] formula2]     [*[subject formula1] *[subject formula2]]   
```
Which is a little long for my taste, since a formula is a cell we can rewrite it as:

```text
*[a [b c] d e]     [*[a b c] *[a d e]]   
```
where a is the subject, [b c] is formula1 and [d e] is formula2.

But actually we can simplify this further and just say:

```text
*[a [b c] d]     [*[a b c] *[a d]]   
```
since d has to be a cell for `*[a d]` to evaluate. We really just want to
specify what happens when you replace an atomic operator with a cell.

What's really cool about this rule is that, like the operators, it also chains:

```text
~tomsyt-balsen/try=> .*([42 [46 47]] [[0 1] [3 0 1] [0 2]])
[[42 46 47] 0 42]
```
So if we wanted to produce our subject with all the atoms incremented, we could
do that:

```text
~tomsyt-balsen/try=> .*([42 [46 47]] [[4 0 1] [4 0 2] [4 0 3]])
[43 47 48]
```
We can make our chains as long as we like

```text
~tomsyt-balsen/try=> .*([42 [46 47]] [[0 1] [3 0 1] [0 2] [3 0 2] [0 3] [3 0 3]])
[[42 46 47] 0 42 1 [46 47] 0]
```

That is, we can evaluate arbitrary numbers of formulas on the same subject in
parallel.

But what if we want to run them in series? 

The expression `*[[42 43] [[4 0 3] 1 [3 0 1]]]` is a good example of how this might work:

```text
~tomsyt-balsen/try=> .*([42 43] [[4 0 3] 1 [3 0 1]])
[44 [3 0 1]]
```

Wouldn't it be interesting if we could run [44 [3 0 1]] through Nock again and end up with `*[44 [3 0 1]]` or just `1`?

We'd need a recursive operator to do that. Fortunately, we've got one, Nock 2:

```text
~tomsyt-balsen/try=> .*([42 43] [2 [4 0 3] 1 [3 0 1]])
1
```
Obviously this is a toy example because we could just do the same thing
functionally with:

```text
~tomsyt-balsen/try=> .*([42 43] [3 4 0 3])
1
```
But Nock 2 also lets us call a formula inside our subject.

```text
~tomsyt-balsen/try=> .*([[40 43] [4 0 1]] [2 [0 4] [0 3]])
41

~tomsyt-balsen/try=> .*([[40 43] [4 0 1]] [2 [0 5] [0 3]])
44
```
Or we could completely separate the operator and arguments:

```text
~tomsyt-balsen/try=> .*([[40 43] [0 1 3 4]] [2 [0 2] [0 31] [0 6] [0 30]])
44
```
We did a lot of slicing and dicing of nouns with the formula distribution rule.
Nock 2 lets us run those reassembled nouns as expressions. We could think of
Nock 2 as being exactly like the distribution rule:

```text
*[a [b c] d]          [*[a b c] *[a d]]  
```
except that Nock 2 has an extra `*` meaning we run everything through Nock a
second time. So if we have two formulas 

```text
*[subject 2 formula1 formula2]               *[*[subject formula1] *[subject formula2]]  
```
which we can rewrite as:

```text
*[a 2 b c]            *[*[a b] *[a c]] 
```

Let's work through that last example again:

```text
~tomsyt-balsen/try=> .*([[40 43] [0 1 3 4]] [2 [0 2] [0 31] [0 6] [0 30]])
44
```

So we've got our subject [[40 43] [0 1 3 4]] and a four different formulas: 
[0 2] [0 31] [0 6] [0 30]

Let's apply each of these to our subject separately:

```text
~tomsyt-balsen/try=> .*([[40 43] [0 1 3 4]] [0 2])
[40 43]

~tomsyt-balsen/try=> .*([[40 43] [0 1 3 4]] [0 31])
4

~tomsyt-balsen/try=> .*([[40 43] [0 1 3 4]] [0 6])
0

~tomsyt-balsen/try=> .*([[40 43] [0 1 3 4]] [0 30])
3
```

If instead of Nock 2, we had just used the formula distribution rule:

```text
~tomsyt-balsen/try=> .*([[40 43] [0 1 3 4]] [[0 2] [0 31] [0 6] [0 30]])
[[40 43] 4 0 3]
```

But since Nock 2 is recursive:

```text
*[[[40 43] [0 1 3 4]] [2 [0 2] [0 31] [0 6] [0 30]]]
```
reduces to:

```text
*[[40 43] 4 0 3]
```

which is, of course, 43 + 1, or 44.

Now that we understand how to slice up nouns in our subject, let's introduce Nock 5. 

Nock 5 is exactly like Nock 3 and Nock 4 in structure, but we've saved it for
last because it's easier to understand how to use it, once you know how to
distribute formulas. See if you can figure it out from the following:

```text
~tomsyt-balsen/try=> .*([42 42] [5 [0 2] [0 3]])
0

~tomsyt-balsen/try=> .*([42 43] [5 [0 2] [0 3]])
1

~tomsyt-balsen/try=> .*([42 44] [5 [0 2] [0 3]])
1

~tomsyt-balsen/try=> .*([[42 42] [42 42]] [5 [0 2] [0 3]])
0

~tomsyt-balsen/try=> .*([[42 43] [42 43]] [5 [0 2] [0 3]])
0

~tomsyt-balsen/try=> .*([[42 43] [42 43]] [5 [0 4] [0 3]])
1

~tomsyt-balsen/try=> .*([[42 42] [42 42]] [5 [0 2] [0 3]])
0
```

Yes, Nock 5 is an equality test:

```text
*[a 5 b]              =(*[a b])
```

if the head and the tail of the cell produced by `*[a b]` are the same, then
Nock 5 produces 0, if they are different, Nock 5 produces 1:

```text
=([a a])              0 
=([a !a])              1
```
Where `!a` just means "not a."

But what if `*[a b]` inside `=(*[a b])` produces an atom?

```text
~tomsyt-balsen/try=> .*([[42 42] [42 42]] [5 [1 1]])    
! exit
```
So we need to add

```text
=(atom)              ! exit
```
to our rule. 

Let's reduce the last example from above by hand:

```text
*[[[42 42] [42 42]] [5 [0 2] [0 3]]]

    *[a 5 b]                =(*[a b])

=(*[[[42 42] [42 42]] [0 2] [0 3]])

    *[a [b c] d]            [*[a b c] *[a d]]

=([[*[[42 42] [42 42]] [0 2]] *[[[42 42] [42 42]] [0 3]]])

      =(*[[[42 42] [42 42]] [0 2]])         ::head

          *[a [0 b]]               /b of a
              
          [42 42]

      =(*[[[42 42] [42 42]] [0 3]])         ::tail

          *[a [0 b]]               /b of a
           
          [42 42]

=([[42 42] [42 42]])

    =([a a])                 0 

```
___

###Summary:

**Formula Distribution:**

A formula with a second formula at its head instead of an operator distributes the subject over both formulas:

```text
*[a [b c] d]          [*[a b c] *[a d]]  
```

`[b c]` is the first formula, d is the second formula.

**Nock 2**

```text
*[subject 2 formula1 formula2]               *[*[subject formula1] *[subject formula2]]  
```
which translates to 

```text
*[a 2 b c]            *[*[a b] *[a c]]
```

**Nock 5**

```text
*[a 5 b]              =(*[a b])
=([a a])              0 
=([a !a])              1
=(atom)               ! exit
```
___

###Exercises:

1. Using the above rule, write a formula that reverses the order of the atoms in `[42 46 [68 69] 55]` i.e. produces `[55 [68 69] 46 42]`.

2. Put the subject `[4 3 7 2 5 1 6]` in order from least to greatest.

3. Does `*[[42 42] 5 [0 1] [0 3]]` produce a `yes` or a `no`?

4. Write a noun that contains some data (nouns you find interesting) and some code (formulas you find interesting), write an expression with that noun as the subject that produces a single data-noun and a single code cell. Then use Nock 2 to apply the formula to the data.

5. Choose a subject such that the following expression evaluates

```text
`~tomsyt-balsen/try=> .*(subject [2 [0 5] [0 4] [0 3]])`
`43`
```
___

[**Prev**: Operator 4](/tutorial/nock/nock4)
[**Next**: Specification](/tutorial/nock/nock6)

