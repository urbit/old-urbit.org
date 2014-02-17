---
layout: subpage
title: Basic Nock, I
---

[**Next**: Noun Structure](/tutorial/nock/ch1_sec2)


#Section I: Getting Started With Nock#

> *What one fool can do, another can.*  
> **Ancient Simian proverb**

Think of Nock as a kind of functional assembly language.  It's not like
assembly language in that it's directly executed by the hardware.  It is like
assembly language in that (a) everything in Urbit executes as Nock; (b) you
wouldn't want to program directly in Nock; and (c) learning to program directly
in Nock is a great way to start understanding Urbit from the ground up.

Just as Unix runs C programs by compiling them to assembler, Urbit runs Hoon
programs by compiling them to Nock.  You could try to learn Hoon without
learning Nock.  But just as C is a thin wrapper over the physical CPU, Hoon is
a thin wrapper over the Nock virtual machine.  It's a tall stack made of thin
layers, which is much easier to learn a layer at a time.

And unlike most fundamental theories of computing, there's really nothing smart
or interesting about Nock.  Of course, in a strictly formal sense, all of
computing is math.  But that doesn't mean it needs to feel like math.  Nock is
a simple mechanical device and it's meant to feel that way.

Let's get start by learning how to use Urbit's operating system, Arvo, to
evaluate Nock code.

We'll assume that you've gone through the [Urbit setup](/setup) process and have an Arvo
prompt that looks something like this:

```text
~tomsyt-balsen/try=> 
```

At your prompt, type the following exactly:

```text
~tomsyt-balsen/try=> .*(42 [0 1])
```
This should return `42`. Don't worry about what this is doing yet.

It's very important that you actually go to your prompt and type in our
examples. Copying and pasting is cheating, although using your up-arrow is not. This might seem silly, but to learn
Nock (or any language)  it's very important that your fingers get
comfortable writing it. 

If you accidentally make a mistake typing in a Nock expression, you'll get a
syntax error:

```text
~tomsyt-balsen/try=> .*(42[0 1]) 
~ <syntax error at [1 6]>

~tomsyt-balsen/try=> .*( 42 [0 1]) 
~ <syntax error at [1 4]>
```

Easiest way to get a sytax error is to accidentally leave out a space. Or add
an extra one. Fortunately, the error message tells you where the mistake is:

```text
~ <syntax error at [1 4]>
```

means that there's an error at `line 1`, `column 4`.  Once you know where an
error is, it's much easier to fix.

But even if your Nock expression is formatted correctly, you might get
something that looks like this:

```text
~tomsyt-balsen/try=> .*(42 [5 0 1]) 
! exit
```
This means that the expression you typed in is correct Nock, but it just
doesn't produce anything. Unfortunately, we can't give you line and column
numbers on this one, so the only surefire way to debug an exit message is to
understand what your code is doing. Literally speaking, an exit message means
you tried to do something that just doesn't make sense. Such trying to
reference data that doesn't exist, or trying to increment something that's not
a number, or asking if `42` is equal, without asking what it's equal to.

Enough about errors, let's practice some expressions that work:

```text
~tomsyt-balsen/try=> .*(41 [0 1]) 
41

~tomsyt-balsen/try=> .*(40 [0 1]) 
40

~tomsyt-balsen/try=> .*(374 [0 1]) 
374
```


The perceptive reader will notice the pattern here: If a is a number, `.*(a [0
1])` always produces `a`, although `a` itself will not return, as `a` is not a number and nock does not act on letters. To test it, run the following, but
replace `a` with any number you like.

```text
~tomsyt-balsen/try=> .*(a [0 1]) 
a
```

Once you're satisfied that this is true, let's do something slightly
different:

```text
~tomsyt-balsen/try=> .*(374 [1 0]) 
0

~tomsyt-balsen/try=> .*(40 [1 0]) 
0

~tomsyt-balsen/try=> .*(41 [1 0]) /
0
```

This pattern is pretty easy: `*(a [1 0])` always produces `0`, no matter what a
is.

Again, play around with the above yourself by choosing your own values for a:

```text
~tomsyt-balsen/try=> .*(a [1 0]) 
0
```

One more pattern, and then we'll actually explain what these numbers and brackets represent:

```text
~tomsyt-balsen/try=> .*(374 [1 374]) 
374

~tomsyt-balsen/try=> .*(40 [1 374]) 
374

~tomsyt-balsen/try=> .*(374 [1 40]) 
40
```

As an exercise, run the last three lines again but replace `374` and `40` with
number of your own.

You've probably already guessed the pattern here: `.*(a [1 b])` always produces
`b`, regardless of `a`. But feel free to test it, replacing `a` and `b` with any number.

```text
~tomsyt-balsen/try=> .*(a [1 b]) 
b
```

Let's run the following piece code again:

```text
~tomsyt-balsen/try=> .*(42 [0 1])
```

Nock is made up of two basic building blocks: atoms, which can be any
non-negative whole number, and cells, which are pairs of numbers or cells
(cells can go inside of other cells.) `42`, for example, is an atom. `[0 1]` is
a cell. Even `[42 [0 1]]` is a cell. (It's very important to note that cells
can nest inside other cells.)

Collectively, both atoms and cells are called nouns. And Nock is just a list of
rules (or a set of patterns) for transforming nouns.  You put one noun in, you
get another noun out. It's like algebra, `f(x) = y`. `nock(noun_a) = noun_b`

The atom `42` is a noun, the cell `[0 1]` is a noun, In fact, `.*(42 [0 1])`
is a noun too, except that its wrapped in syntax that tells Arvo "run
this noun through Nock". `.*(42 [0 1])` is actually the way to tell Arvo
(Urbit's operating system) to evaluate `Nock([42 [0 1]])`. The cellular noun
`[42 [0 1]]` goes into Nock, the atomic noun `42` comes out.

We could simply write our very first example again as 

```text
nock([42 [0 1]]) = 42
```
except that we wouldn't be able to evaluate it in Arvo.

Actually, we almost never use the above mathematical notation. For the sake of
brevity we almost always write nock(a) using the notation `*a`. Thus, nock([42
[0 1]])  `*[42 [0 1]]` mean the same thing. If we want to tell Arvo to evaluate
the noun, we use `.*(42 [0 1])`. You will notice that the outermost brackets
somewhat confusingly disappear when we use the .*() function in Arvo, we will
explain why in [replaceme: Chapter 2. Section 1] 


But in documenting Nock, we most frequenly use the `*[42 [0 1]]` style of
notation:

Instead of, for example, writing

```text
~tomsyt-balsen/try=> .*(a [1 b]) 
b
```

the standard way of writing out the rules of Nock is 

```text
*[a [1 b]]                  b
```

with the left hand side being the noun that matches our input and the right
side being the product of that input. 

We've been using `a` and `b` as variables that represent numbers (i.e. atoms),
but we can and do use them more broadly to represent nouns in general.

Let's apply the rule

```text
*[a [1 b]]                  b
```

which, to reiterate, means that when we run any noun of the form [a [1 b]]
through Nock (using the expression `.*(a [1 b])` in Arvo) always produces `b`,
regardless of `a`.

Let's run a few examples:

```text
~tomsyt-balsen/try=> .*(301 [1 374])
374

~tomsyt-balsen/try=> .*([42 43] [1 312])
312

~tomsyt-balsen/try=> .*(374 [1 [44 48]])
[44 48]

~tomsyt-balsen/try=> .*([46 49] [1 [456 539]])
[456 539]

~tomsyt-balsen/try=> .*(374 [1 [[[32 34] 33]])
[[[31 32] 33]
```

To conclude this section, let's review what we've learned:

___

###Summary:

**Notation:**

Arvo syntax:

```text
~tomsyt-balsen/try=> .*(42 [0 1]) 
42
```

Math notation:

```text
nock([42 [0 1]]) = 42
```

Nock notation:

```text
*[42 [0 1]]                  42
```

**Error Messages:**

A syntax error occurs when an expression in Arvo is not typed in correctly.

```text
~tomsyt-balsen/try=> .*( 42 [0 1]) 
~ <syntax error at [1 4]>
```

The cell in the syntax error gives the line and column number of the location of the error.

```text
~tomsyt-balsen/try=> .*(42 [5 0 2]) 
! exit
```

**Structures:**

A noun is an atom or a cell.  An atom is a natural number.  A cell is an
ordered pair of two nouns. I.e. two atoms, two cells, or a cell and an atom.

**Nock Rules**

Lower-case letters such as `a` or `b` are variables that represent nouns. 

Nock rules are notated with two columns, where the left hand side indicates
what pattern the noun matches, and the right hand side indicates what the noun
produces.

```text
*[a [0 1]]                  a
*[a [1 b]]                  b
```
___

###Exercises:

1. Using the rule:

	```text
	*[a [0 1]]                  a
	```

	replace `a` with an atom, a cell, and multiple cells, and return them all respectively in Arvo (using, of course, the proper Arvo syntax).  


2. Using the rule:

	```text
	*[a [1 b]]                  b
	```
	Write a cell, substituting a noun of more then 4 cells for `b`, and any atom for `a`, and then return it in Arvo (again, in the correct syntax, of course). Then play around with what you substitute for a: change it to a different atom, make it a cell, and then a set of nested cells. Does it make a difference? If yes, why? If not, why not?

3. Produce a syntax error that reads:
```text
~ <syntax error at [1 14]>
```

4. With pen and paper, write out all three possible forms of notation (Arvo syntax, Math notation, and Nock notation) for each
of the expressions you evaluated in exercises 1. and 2.

___

[**Next**: Noun Structure](/tutorial/nock/ch1_sec2)

