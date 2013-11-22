---
layout: post
category: doc
title: Urbit Made Easy&#58; Chapter II
---

#Chapter II: Starting, Stopping and Reading Reductions# 

##Some Basic Notation##

In the last chapter, we reduced the noun `[2 6 14 15]` to the noun `[2 [6 [14 15]]]` using `line 2` of Nock. 

In proper notation, we could write this as 

	nock([2 6 14 15])
		[2 [6 [14 15]]]

Where nock(noun) means "Apply Nock to this noun" and the new line signifies
equals or outputs.

If you'll remember from the previous section a noun can be represented by a
letter and we can rewrite nock(noun) as nock(a). Which brings us to the first
line of the Nock specification:

	1  ::    nock(a)             *a

This line is actually very simple. It's just giving as a new piece of notation.
All says is that the asterisk (\*) means the same thing as nock(a).

So we can write our previous reduction as 

	*[2 6 14 15] 
	*[2 [6 [14 15]]]

Or if we wanted to fill in the intermediate steps, with labels for the rules we
used, we could write

	*[2 6 14 15] 
	
		2  ::    a b c]           a [b c]]
	
		*[2 6 [14 15]]
	
		2  ::    a b c]           a [b c]]
	
		*[2 [6 [14 15]]]


We could also, if we really wanted to, write it this way:

	nock([2 6 14 15])
	
		1  ::    nock(a)             *a
	
		*[2 6 14 15]
	
		2  ::    a b c]           a [b c]]
	
		*[2 6 [14 15]]
		
		2  ::    a b c]           a [b c]]
	
		*[2 [6 [14 15]]]

This is actually the most complete way to describe a reduction, but since
reductions can grow very big and cumbersome, we'll often skip a lot of the
mechanical steps as we get further on and rely more on our intuitive
understanding of the system.

You might also have noticed that we've added the asterisk (`*`) to our outputs.
The reductions we did in the last section didn't have them because that likely
would have been an unnecessary level of detail too soon. Practically speaking,
the `*` is necessary, because it tells you that you need to run your noun 
through Nock again, but because all lines in a reduction will start with a `*`, we'll often remove it for the sake of minimalism.

But now, you're probably asking yourself, "If * means run the noun through
Nock, why does our final output have a `*`? I thought we had finished our
reduction."

Excellent question! This brings us right to the topic of how a Nock reduction
ends. Like many things in Urbit the answer is short and stupid: They don't. 

##A Nock that Never Ends##

Actually this isn't true, there are some operations that do terminate, but most of them, and nearly all the interesting ones, don't.

To see why they don't let's take a look at lines 6, 10, 17 and 35:

        6  ::    +[a b]              +[a b]
        10 ::    =a                  =a
        17 ::    /a                  /a
        35 ::    *a                  *a

On these lines, the input is the same as the output. Which means that the
reduction never ends and continues forever in a stream of something like: 

	35 :: *a
	35 :: *a
	35 :: *a
	35 :: *a

And so on. Of course in practice, you'll hopefully notice that this is occuring
and stop typing. The same principle is true when it's not you doing the
reduction by hand, but rather a computer program called an "interpreter".
Whether it's you or the interpreter, detecting an infinite loop and stopping is
known as an "out of band error." The good news is that this is how you know
when your reduction is done. your interpreter (either human or machine)
crashes, you look at the last thing it did and that's your final output.

Another question you probably have is how Nock avoids getting caught in an
infinite loop before the reduction is supposed to be done. Why can't you have a
loop that looks like this? :

	35 :: *[2 6 [14 15]]
	35 :: *[2 6 [14 15]]
	35 :: *[2 6 [14 15]]
	35 :: *[2 6 [14 15]]

The answer is something that we briefly mentioned earlier, you have to try and
apply the rules of Nock to your noun in the top-down order they appear in the
specification. You'll never get a loop that looks like the above, because
you're forced to try and apply lines 1 through 34 to your noun before you get
to try line 35. In practice with the above, since you can apply line 2 (our
bracket rule, if you remember), you have to apply line 2.

But line 35 isn't the only line that puts us into an infinite loop! We have
three more, lines 6, 10 and 17. (we call them "crash defaults"):

        6  ::    +[a b]              +[a b]
        10 ::    =a                  =a
        17 ::    /a                  /a

Actually these are not the only possible way to put Nock into an infinite loop
(Halting problem), but they are the only ones we care about for now. 

To read these lines, we'll have to learn the rest of our Nock pseudocode
notation. 

##More Notation, `+` `=` `?`##

Let's start with "+":

        6  ::    +[a b]              +[a b]
        7  ::    +a                  1 + a
 
"+" is very simple. It just means add 1 (or "increment"). Obviously you can
only add 1 to a number, so line 6 says that if you try to add 1 to a cell
you'll loop forever and crash. Line 6 comes before line 7 in the specification
to catch all cases of trying to add a number to a cell.

The next symbol to learn is "=":

	8  ::    =[a a]              0
	9  ::    =[a b]              1
	10 ::    =a                  =a
        
"=" means equals, or, more specifically, "Does the following cell contain a
pair of identical nouns?" If the cell does, then  "=[a a]" gets transformed
into the atom 0, or "yes" (line 8). If not, "=[a b]" gets transformed into the
atom 1, or "no" (line 9). If you try and do an equality test on an atom, you'll
loop forever and crash (line 10).

Before we cover our final crash default (line 17, and "/"), we should go over
the what "?" means, since it's pretty easy.

        4  ::    ?[a b]              0
        5  ::    ?a                  1

As with "=", "?" is just another test that produces "yes" or "no."
Specifically, "?" tests whether a noun is a cell. 

And now for the trickiest piece of notation, the "/", which we call the "slot"
operator:

The Slot Operator

	12 ::    /[1 a]              a
	13 ::    /[2 [a b]]          a
	14 ::    /[3 [a b]]          b
	15 ::    /[(a + a) b]        /[2 /[a b]]
	16 ::    /[(a + a + 1) b]    /[3 /[a b]]
	17 ::    /a                  /a

Since this is fairly complicated, we'll explain it in two ways. First, we'll
describe what the slot operator ("/") does at an intuitive level (what it's
intended to do). And then we'll dive into the mechanics of how it actually
works.

Intuitively, the slot operator is how we refer to individual nouns that are
inside of a larger cell. It's how we pull things out of the big tree-like cell
structure. Each noun in the tree gets a number and when we do /[b a], where b
is the number that corresponds to the noun and a is the larger cell that
contains the noun, we produce just the noun we referred to. Think of it as an
index or an address for a noun.

Since all cells are pairs of nouns that break down into other pairs, the
structure of our tree looks like this:

	            1
	       2          3
	    4    5     6     7
	   8 9 10 11 12 13 14 15
	
	[2 [6 [14 15]]]

1 is the slot address that matches the entire original cell (the root). 2
refers to the first noun of that cell (the head) and 3 refers to the second
noun of that pair (the tail).

Let's build some example nouns where every atom is equal to its slot address:

	1
	[2 3]
	[2 [6 7]]
	[[4 5] [6 7]]
	[[4 5] [6 [14 15]]]
	[[4 5] [[12 13] [14 15]]]
	[[4 [10 11]] [[12 13] [14 15]]]
	[[8 9] [10 11] [[12 13] [14 15]]]

Actually, all the examples we used earlier when we explained the line 2 bracket
rule follow this same pattern. 

Another way to think about this is that if you replace any atom with a value
"n" in the above tree with a cell, the atom at head of the cell will be equal
to two times "n" (2n) and the tail of the cell will be 2n + 1. Heads are even,
tails are odd.

Let's go into the mechanics of how this works with some more examples:

Say you have a noun [[100 101] 102 103]]. We'll use this noun to show how the
actual Nock rules produce what they're supposed to.

	12 ::    /[1 a]              a
	13 ::    /[2 [a b]]          a
	14 ::    /[3 [a b]]          b
	15 ::    /[(a + a) b]        /[2 /[a b]]
	16 ::    /[(a + a + 1) b]    /[3 /[a b]]
	17 ::    /a                  /a

Using addresses 1, 2, and 3 with the slot operator is fairly straightforward.

	/[1 [[100 101] 102 103]]
	
		 12 ::    /[1 a]             a
	
		 [[100 101] 102 103]
	
	/[2 [[100 101] 102 103]
	
		13 ::    /[2 [a b]]          a
	
		[100 101]
	
	/[3 [[100 101] 102 103]]
	
		14 ::    /[3 [a b]]          b
	
		[102 103]

(We've skipped the step of using line 2 to add brackets back in. The aspiring
Nock programmer needs to learn to do line 2 in their head.)

So now what about addresses that are greater than 3?

	/[4 [[100 101] 102 103]]
	
		15 ::    /[(a + a) b]        /[2 /[a b]]
	
		/[2 /[2 [[100 101] 102 103]]]
	
		13 ::    /[2 [a b]]          a   
	
		/[2 [100 101]]
	
		13 ::    /[2 [a b]]          a   
	
		100

We see that the (a + a) in line 15 is doing the same thing as saying that every
cell with an address n has a head with an address that's 2n.

	/[5 [[100 101] 102 103]]
	
		16 ::    /[(a + a + 1) b]    /[3 /[a b]]
	
		/[3 /[2 [[100 101] 102 103]]]
	
		13 ::    /[2 [a b]]          a   
	
		/[3 [100 101]]
	
		14 ::    /[3 [a b]]          b
	
		101

As an exercise, do `/[6 [[[100 101] 102 103]]` and `/[7 [[[100 101] 102 103]]` on your own.

In Chapter 3, we'll get into the real meat and bones of Nock: the Operators. 
