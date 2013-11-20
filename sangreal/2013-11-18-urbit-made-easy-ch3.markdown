---
layout: post
category: doc
title: Urbit Made Easy&#58; Chapter III
---

#Chapter III: Nock Operators#

"You get used to it. I don’t even see the code. All I see is blonde, brunette,
red-head."


This is where we get into the real meat and bones of Nock: the Operators. Nock
has ten operators, numbered `1` through `10`. The symbols for these operators
are just plain ordinary atoms. Remember how we said that real Nock code doesn't
have letters? It doesn't have any symbols (like `+`) either. If we want to
add 1 to a number, we'll have to use a number to do it.

I think you know enough Nock by now not to be intimidated by a sample of real
Nock code:

	  [8 
	    [1 0] 
	    [ 8 
	      [ 1 
	        [ 6 
	          [5 [0 7] [4 0 6]]
	          [0 6]
	          [9 2 [[0 2] [4 0 6] [0 7]]]
	        ]
	      ]
	      [9 2 0 1]
	    ]
	  ]

Or, on one line with the the brackets removed.

	[8 [1 0] 8 [1 6 [5 [0 7] 4 0 6] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]

That's decrement (or "subtract 1"). Right now, it just looks like like a
meaningless blob of numbers. When you utterly master Nock, you won't even see
the atoms, you'll see what they do. But,to be fair, there's a very good reason
why no one uses Nock for real programming. There's also a very good reason why,
to understand Urbit, you need to learn it anyway.

Each atom in the decrement blob is there because it represents a function. Most
of these functions, you already know.

We'll start with the first five, since not only are they easy to understand,
but they actually are the only fundamental operators in Nock. Operators `6`
through `10` are just macros made up of Operators `1` through `5`.

	21 ::    *[a [0 b]]          /[b a]
	22 ::    *[a [1 b]]          b
	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]
	24 ::    *[a [3 b]]          ?*[a b]
	25 ::    *[a [4 b]]          +*[a b]
	26 ::    *[a [5 b]]          =*[a b]

Most of these operators are just doing things we already know. 

	21 ::    *[a [0 b]]          /[b a]

Nock `0` is just our good old friend the slot operator. But it's in a different
order than `/` on its own.

The reason for this is that the convention in Nock is for any actual code to be
of the form:

	*[subject formula]

The head of a noun is the subject (i.e. the thing we want to operate upon) and
the tail is the formula, which has the actualy operation (function) we're going
to perform. The outcome of applying a formula to a subject is called the
product.

All operators should be thought of as acting on, or doing something to the head
of their cell, always denoted by the letter a. After the operator are its
arguments, which are the nouns that are getting applied in some way to the
subject a.

Moving on:

	22 ::    *[a [1 b]]          b

Nock `1` is the constant operator. It produces the argument and drops the
subject.

        24 ::    *[a [3 b]]          ?*[a b]
        25 ::    *[a [4 b]]          +*[a b]
        26 ::    *[a [5 b]]          =*[a b]

We'll go slightly out of order here and skip Nock `2` for a moment. Nock `3`,
`4` and `5` do exactly what the notation says. Nock `3` tests if the product of
`b` applied to `a` is a cell. Nock `4` increments the outcome, and Nock `5`
tests if it has a head and a tail that are equal.

We should note though, that if you wanted to write a Nock expression that
increments a number, you would have to take into account that you cannot
increment a cell and would have to write it like this:

	*[42 4 0 1]
	
		24 ::    *[a [4 b]]          +*[a b]
	
		+*[42 0 1]
	
		21 :: *[a [0 b]]             /[b a]
	
		+42
	
		7  ::    +a                  1 + a
	
		43

Nock `2` looks complicated, but actually isn't. All Nock `2` does is distribute the subject `a` over the arguments `b` and `c` and evaluate them independently.

	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]

For example, lets say that `a` is the noun `[[101 102] 103 104]`, `b` is the noun `[0 4]` and `c` is the noun `[0 6]`:

	*[[101 102] 103 104] [2 [[0 4] [0 6]]]]
	
		23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]
	
		*[*[[101 102] 103 104] 0 4] *[[101 102] 103 104] 0 6]
	
		21 ::    *[a [0 b]]          /[b a]
		
		*[/[4 [101 102] 103 104]] /[6 [101 102] 103 104]]
	
		/ operator (full steps ommitted)
	
		*[101 103]

As you can see, Nock `2` is pretty useful. It lets us apply multiple formulas to
the same subject. 

Before we move into the macro operators `6` through `10`, there's one more line of Nock that we need to cover, `line 19`:

	19 ::    *[a [[b c] d]]      [*[a b c] *[a d]]

`Line 19` is actually quite similar to Nock `2`. If you understand Nock `2`,
you understand `Line 19`.

	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]

In less formal terms, if you have a two formulas (call them b and c), Nock `2`
does this:

	*[subject-a 2 [formula-b formula-c]]
	
		*[*[subject-a formula-b] *[subject-a formula-c]]
	
		*[product-ab product-ac]

Line 19, on the other hand, does this:

	*[subject-a [formula-b] formula-c]
	
		[*[subject-a formula-b] *[subject-a formula-c]]
	
		[product-ab product-ac]

As you can see, here they look almost identical. Let's redo our previous
example from Nock `2` using line 19 instead.

	*[[[101 102] 103 104] [0 4] [0 6]]
	
		19 ::    *[a [[b c] d]]      [*[a b c] *[a d]]
	
		[*[[101 102] 103 104] 0 4] *[[101 102] 103 104] 0 6]
	
		21 ::    *[a [0 b]]          /[b a]
	
		[/[4 [101 102] 103 104]] /[6 [101 102] 103 104]]
	
		/ operator 
	
		[101 103]

Almost, exactly the same result. So why do we have two different ways of doing
the same thing? If you compare the rules again:
	
	19 ::    *[a [[b c] d]]      [*[a b c] *[a d]]
	
	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]

You'll see that Nock `2` is a bit more general, because the first argument of
Nock `2` can be any noun, whereas line 19 has to have a cell as its first
argument. But the real difference is the extra `*`. Line 19 just distributes the
subject onto `formula-x` and `formula-y`, but Nock `2` actually forces you to
evaluate the result of `*[product-x product-y]`.

Let's change our previous example slightly to illustrate. We'll change the
subject to `[[[101 102] [4 0 1] [3 0 1]]`. As you can see, our new subject has
two cells inside it that contain the operators 3 and 4.

Using line 19:
	
	*[[[101 102] [4 0 1] [3 0 1]] [0 4] [0 6]]
	
		19 ::    *[a [[b c] d]]      *[*[a b c] *[a d]]
	
		[*[[[101 102] [4 0 1] [3 0 1]] 0 4] *[[[101 102] [4 0 1] [3 0 1]] 0 6]]
	
		21 ::    *[a [0 b]]          /[b a]
	
		[/[4 [[101 102] [4 0 1] [3 0 1]]] /[6 [[101 102] [4 0 1] [3 0 1]]]]
	
		/ operator 
	
		[101 4 0 1]

But with Nock `2`:
	
	*[[[101 102] [4 0 1] [3 0 1]] 2 [0 4] [0 6]]
	
	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]
	
	[*[[[101 102] [4 0 1] [3 0 1]] 0 4] *[[[101 102] [4 0 1] [3 0 1]] 0 6]]
	
	21 ::    *[a [0 b]]          /[b a]
	
	*[/[4 [[101 102] [4 0 1] [3 0 1]]] /[6 [[101 102] [4 0 1] [3 0 1]]]]
	
	/ operator 
	
	*[101 4 0 1]
	
	25 ::    *[a [4 b]]          +*[a b]
	
	?*[101 0 1]
	
	21 ::    *[a [0 b]]          /[b a]
	
	+101
	
	7  ::    +a                1 + a
	
	102

Nock `2` actually carries through the whole evaluation. Let's say we change the
arguments that `2` uses in our prior example. The subject is the same, but
we're varying the formulas. 
	
	*[[[101 102] [4 0 1] [3 0 1]] 2 [0 5] [0 7]]
	
	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]
	
	[*[[[101 102] [4 0 1] [3 0 1]] 0 5] *[[[101 102] [4 0 1] [3 0 1]] 0 7]]
	
	21 ::    *[a [0 b]]          /[b a]
	
	*[/[5 [[101 102] [4 0 1] [3 0 1]]] /[7 [[101 102] [4 0 1] [3 0 1]]]]
	
	/ operator 
	
	*[102 3 0 1]
	
	24 ::    *[a [3 b]]          ?*[a b]
	
	?*[101 0 1]
	
	21 ::    *[a [0 b]]          /[b a]
	
	?101
	
	5  ::    ?a                  1
	
	1

Our subject has some formulas inside it. Nock `2` lets us select which formula
to use and which part of the subject to evaulate it against. Line 19, on the
other hand, doesn't carry through the whole evaluation and always returns a
cell (of the form `[product-ab product-ac]`). A Nock programmer might very well
use that cell as a subject for another formula, but that's outside the scope of
what we've covered so far.

Be very careful though when reducing line 19 or Nock `2`. One of the most
common mistakes when doing reductions by hand is accidentally adding or
removing an asterisk.


Congratulations! You've now learned all the essential details of Nock.
Operators 6-10 add nothing new except a convenient way to do certain series of
operations over and over again. And Operators 6-10 are entirely composed of
things you already know. Hang on to your seatbelts, we're about to take the
plunge:

        28 ::    *[a [6 [b [c d]]]]  *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]
        29 ::    *[a [7 [b c]]]      *[a 2 b 1 c]
        30 ::    *[a [8 [b c]]]      *[a 7 [[7 [0 1] b] 0 1] c]
        31 ::    *[a [9 [b c]]]      *[a 7 c 2 [0 1] 0 b]
        32 ::    *[a [10 [[b c] d]]] *[a 8 c 7 [0 3] d]
        33 ::    *[a [10 [b c]]]     *[a c]

Although you might not realize it, you already know how to do all of these.

Let's start with Nock `7`, since it's the simplest:

	29 ::    *[a [7 [b c]]]      *[a 2 b 1 c]

Almost exactly like Nock `2`, except with the twist that instead of evaluating
formula `b` and formula `c` in parallel, you evaluate them on subject-a one
after the other. Like so:

Nock `2`:

	*[subject-a 2 [formula-b formula-c]]
	
		*[*[subject-a formula-b] *[subject formula-c]]
	
		*[product-ab product-ac]

Nock `7`:

	*[subject-a 7 [formula-b formula-c]]	
	
		*[*[subject-a formula-b] formula-c]
	
		*[product-ab formula-c]
	
		[product-abc]

Let's use an example: 
	
	*[101 [7 [4 0 1] 4 0 1]]
	
	29 ::    *[a [7 [b c]]]      *[a 2 b 1 c]
	
	*[101 2 [4 0 1] [1 4 0 1]]
	
	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]
	
	*[*[101 4 0 1] *[101 1 4 0 1]]
	
	22 ::    *[a [1 b]]          b
	
	*[*[101 4 0 1] [4 0 1]]
	
	25 ::    *[a [4 b]]          +*[a b]
	
	*[102 4 0 1]
	
	25 ::    *[a [4 b]]          +*[a b]
	
	*[103]

If we had just used Nock `2`, we would have ended up with:
	
	*[101 [2 [4 0 1] 4 0 1]]
	
	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]
	
	*[*[101 4 0 1] *[101 4 0 1]]
	
	25 ::    *[a [4 b]]          +*[a b]
	
	*[102 102]

For Nock `7`, and for the rest of the macro operators, we'll work through a
reduction that puts the macro in the simplest psuedo-code.
	
##`7` Reduction:##
	
	29 ::    *[a 7 b c]        *[a 2 b 1 c]
	
	*[a 2 b 1 c]
	
	23 ::    *[a 2 b c]        *[*[a b] *[a c]] 
	
	*[*[a b] *[a 1 c]]
	
	22:    *[a 1 b]          b
	 
	*[*[a b] c]
	 
**`7` Reduced:**

	7r ::     *[a 7 b c]         *[*[a b] c]

We'll reuse this reduced Nock `7` rule in the future, since it's easier to
read, and much quicker when you're doing reductions by hand.


Moving on to Nock `8`:

	30 ::    *[a 8 [b c]]        *[a 7 [[7 [0 1] b] 0 1] c]

Nock `8` is extremely similar to Nock `7`. Instead of just applying both
formulas to the subject, Nock `8` applys the first formula, but preserves the
original subject as the tail of the cell that the second formula gets applied
to. Like so:

Nock `7`:
	 
	*[subject 7 [formula-x formula-y]]
		*[*[subject formula-x] formula-y]
		*[product-x formula-y]
		[product-xy]
	
Nock `8` does
	
	*[subject 8 [formula-b formula-c]]
		*[[*[subject-a formula-b] subject-a] formula-c]
		*[[product-ab subject-a] formula-c]

In more formal pseudo-code, here's what the reduction looks like:

##`8` Reduction:##

	30 ::    *[a 8 b c]        *[a 7 [[7 [0 1] b] 0 1] c]
	
	*[a 7 [[7 [0 1] b] 0 1] c]   
	
	7r ::     *[a 7 b c]         *[*[a b] c]
			
	*[*[a [7 [0 1] b] 0 1]] c]
	
	19 ::    *[a [b c] d]      [*[a b c] *[a d]]
	
	*[[*[a [7 [0 1] b]] *[a 0 1]] c]
 		
	21 ::    *[a 0 b]          /[b a]
	
	*[[*[a [7 [0 1] b]] /[1 a]] c]
		
	12 ::    /[1 a]            a
	
	*[[*[a [7 [0 1] b]] a] c]
	
	7r ::     *[a 7 b c]         *[*[a b] c]
		
	*[[*[*[a 0 1]] b] a] c]
	
**`8` Reduced:**

	8r ::     *[a 8 b c]        *[[*[a b] a] c]

Let's work through an example of how you might use Nock `8`:

Let's say we have a subject and we want to test whether it's a cell, but we
also want to preserve the subject:
	
	*[101 [8 [3 0 1] 0 1]]
	
	8r ::     *[a 8 b c]        *[[*[a b] a] c]
	
	*[[*[101 [3 0 1] 101] 0 1]]
	
	24 ::    *[a [3 b]]          ?*[a b] 5  ::    ?a                  1
	
	*[[1 101] 0 1] [1 101]

Or if the subject is a cell:
	
	*[[101 102] [8 [3 0 1] 0 1]]
	
	8r ::     *[a 8 b c]        *[[*[a b] a] c]
	
	*[[*[[101 102] [3 0 1] 101] 0 1]]
	
	24 ::    *[a [3 b]]          ?*[a b] 5  ::    ?a                  1

	*[[0 [101 102]  0 1] [0 [101 102]]



Nock `10`:

	32 ::    *[a [10 [[b c] d]]] *[a 8 c 7 [0 3] d]
	33 ::    *[a [10 [b c]]]     *[a c]

Nock `10`, in the context of everything we've learned so far, does nothing.
Literally, it takes an argument `b`, or an argument that's a cell `[b c]` and
throws it away. 

You can see that very clearly in line 33, and if you do the reduction in line
32:

##`10` Reduction:##
	
	*[a 10 [b c] d]   *[a 8 c 7 [0 3] d]
		
	8r ::     *[a 8 b c]        [[*[a b] a] c]
	
	*[[*[a c] a] 7 [0 2] d]
		
	7r ::     *[a 7 b c]        *[*[a b] c]
	
	*[*[[*[a c] a] 0 3] d]
		
	21 ::     *[a 0 b]          /[b a]

**`10` reduced:**

	10r ::    *[a 10 [b c] d]   *[a d]

Nock `10` is really only ever used for one specialized purpose that has to do
with making a computer run Nock faster (it's how you declare "jets"). We'll
cover Nock `10` more in later chapters. For now, you can safely ignore it.


Nock `6`:

	28 ::    *[a [6 [b [c d]]]]  *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]

Nock `6` looks pretty complicated, but actually is doing something very simple:
it's an if-then-else statement. a is a subject, b is some test (such as Nock `3`,
perhaps) that you apply to the subject, if the test returns 0, or "yes", you
apply the formula c to the subject a. If the test returns 1, or "no," you
instead apply d to a.

You can see this much more clearly if you work through the reduction of Nock
`6` and examine the reduced form.

##`6` Reduction:##
	
	28 ::    *[a 6 b c d]      *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]
		
	*[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]
	
	23 ::    *[a 2 b c]        *[*[a b] *[a c]]
		
	*[*[a 0 1] *[a 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]]
	
	21 ::    *[a 0 b]          /[b a]
		
	*[a *[a 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]]
		
	23 ::    *[a 2 b c]        *[*[a b] *[a c]]
		
	*[a *[*[a [1 c d]] *[a [1 0] 2 [1 2 3] [1 0] 4 4 b]]]
		
	22 ::    *[a 1 b]          b
		
	19 ::    *[a [b c] d]      [*[a b c] *[a d]]
		
	*[a *[[c d] [*[a 1 0] *[a 2 [1 2 3] [1 0] 4 4 b]]]]
	
	22 ::    *[a 1 b]          b
		
	*[a *[[c d] [0 *[a 2 [1 2 3] [1 0] 4 4 b]]]]
		
	23 ::    *[a 2 b c]        *[*[a b] *[a c]]
		
	*[a *[[c d] [0 *[*[a [1 2 3]] *[a [1 0] 4 4 b]]]]]
		
	22 ::    *[a 1 b]          b
		
	*[a *[[c d] [0 *[[2 3] *[a [1 0] 4 4 b]]]]]
		
	19 ::    *[a [b c] d]      [*[a b c] *[a d]]
		
	*[a *[[c d] [0 *[[2 3] [*[a [1 0]] *[a 4 4 b]]]]]]
		
	22 ::    *[a 1 b]          b
		
	*[a *[[c d] [0 *[[2 3] [0 *[a 4 4 b]]]]]]
		
	25 ::    *[a 4 b]          +*[a b]
		
	*[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]
	
**`6` Reduced:**

	6r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]

A simpler version of Nock `6` would be 

	6s ::   *[a 6 b c d]               *[a *[[c d] [0 ++*[a b]]]]]]

`*[a b]` returns either 0 or 1, because `b` is a true or false test. Then you
increment the 0 or 1 twice, which gives you either 2 or 3. If you remember from
our discussion on the slot operator and Nock `0`, `/[2 cell]` selects the head
of the cell, whereas `/[3 cell]` selects the tail. 

Let's work through an example using our simpler Nock `6` (`6s`), where we want to
test if our subject is a atom. If it is, we'll increment it, if our subject is
instead a cell, we'll just return the cell.

	*[a 6 [3 0 1] [0 1] [4 0 1]] 
		6s ::   *[a 6 b c d]               *[a *[[c d] [0 ++*[a b]]]]]]
	
		*[a *[[[0 1] [4 0 1]] [0 ++*[a [3 0 1]]]]]
	
		24 ::    *[a [3 b]]          ?*[a b]
	
		*[a *[[[0 1] [4 0 1]] [0 ++?*[a 0 1]]]]
	
		21 ::    *[a [0 b]]          /[b a]
	
		*[a *[[[0 1] [4 0 1]] [0 ++?/[1 a]]]]
	
		12 ::    /[1 a]              a
		
		*[a *[[[0 1] [4 0 1]] [0 ++?a]]

Now let's say that our subject `a` is the atom 42:

	*[42 *[[[0 1] [4 0 1]] [0 ++?42]]]
	
		5  ::    ?a                  1
	
		*[42 *[[[0 1] [4 0 1]] [0 ++1]]]
	
		7  ::    +a                  1 + a
	
		*[42 *[[[0 1] [4 0 1]] [0 3]]]
	
		21 ::    *[a [0 b]]          /[b a]
	
		*[42 \[3 [[0 1] [4 0 1]]]]
	
		14 ::    /[3 [a b]]          b
	
		*[42 [4 0 1]]
		
		25 ::    *[a [4 b]]          +*[a b]
	
		+*[42 0 1]
	
		21 ::    *[a [0 b]]          /[b a]
	
		+/[1 42]
	
		12 ::    /[1 a]              a
	
		+42
	
		7  ::    +a                  1 + a
	
		43

And if our subject was instead the cell `[42 42]`:
	
	*[[42 42] *[[[0 1] [4 0 1]] [0 ++?[42 42]]]]
		
		4  ::    ?[a b]              0
	
		*[[42 42] *[[[0 1] [4 0 1]] [0 ++0]]]
	
		7  ::    +a                  1 + a
	
		*[[42 42] *[[[0 1] [4 0 1]] [0 2]]]
	
		21 ::    *[a [0 b]]          /[b a]	
	
		*[[42 42] /[2 [[0 1] [4 0 1]]]]
	
		13 ::    /[2 [a b]]          a
	
		*[[42 42] [0 1]]
	
		21 ::    *[a [0 b]]          /[b a]
	
		/[1 [42 42]]
	
		12 ::    /[1 a]              a
	
		[42 42]


But why in actual Nock, do we use:

	28 ::    *[a [6 [b [c d]]]]  *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]

which reduces to:

	6r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]

Instead of the simpler:

	28s ::    *[a [6 [b [c d]]]]  *[a 2 [0 1] 2 [1 c d] [1 0] 4 4 b]

which would reduce to:

	6s ::   *[a 6 b c d]               *[a *[[c d] [0 ++*[a b]]]]]]

The answer is that the simpler version of Nock `6` (`6s`) would do strange
things if we had a test that returned anything other than 0 ("yes") or 1
("no").

Let's use our prior example with the subject 42 and this time we'll change the
test `b` from `[3 0 1]` to `[7 [3 0 1] 4 0 1]` (remember that 7 daisy-chains
formulas) so it returns a "2"
	
	*[42 6 [7 [3 0 1] 4 0 1] [0 1] [4 0 1]]
	
		6s ::   *[a 6 b c d]               *[a *[[c d] [0 ++*[a b]]]]]]
	
		*[42 *[[[0 1] [4 0 1]] [0 ++*[42 [7 [3 0 1] 4 0 1]]]

		7r ::     *[a 7 b c]         *[*[a b] c]
	
		*[42 *[[[0 1] [4 0 1]] [0 ++*[*[42 [3 0 1]] 4 0 1]]]
	
		24 ::    *[a [3 b]]          ?*[a b] 
		5  ::    ?a                  1
	
		*[42 *[[[0 1] [4 0 1]] [0 ++*[1 4 0 1]]]
	
		25 ::    *[a [4 b]]          +*[a b]
	
		*[42 *[[[0 1] [4 0 1]] [0 ++2]]]
	
		7  ::    +a                  1 + a
	
		*[42 *[[[0 1] [4 0 1]] [0 4]]
	
		/ operator
	
		*[42 0]


As you can see, having the test return an atom greater than 1 means that the
slot operator will select some partial subset of our then or else formulas. In
this case `/[4 [0 1] [4 0 1]]` produces just 0, but it should be fairly easy to
imagine how, with a more complicated then r else formula, this could produce
significant strangeness.

What we really want is for Nock `6` to crash if the our test formula `b`
produces anything other than 0 or 1.

We do this by adding a second slot operator selection. Since we want to select
either our then formula c or our else formula d, but not any partial piece of
either, we want to restrict our slot operation to either `/[2 [c d]]` or `/[3 [c
d]]`. If we try to do a slot operation with any other tree-address, we want Nock
6 to crash.

 We can do this by recognizing that the only way a slot operation  will
complete is if the subject of the operation actually has a tree structure with
a matching address. In other words, if you try to do `/[4 a`] and a doesn't have
anything that matches a slot 4 (such as if a is `[1 2]` for example), the slot
operation will crash. 

	6r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]

Our real Nock `6` is exactly like our simplified Nock `6s` except we've add the
cell [2 3]. Our test` *[a b]]` will produce some number and then  `*[[2 3] [0
++*[a b]]]` will slot that number with the cell `[2 3]`. Since `[2 3] `only has
the slots 1, 2 and 3, the only way that the operation will complete is if
`++*[a b]` equals 1, 2 or 3. `++*[a b`] can't equal 1 since that would imply
that `*[a b]`equal -1 and there are no negative numbers in Nock. Therefore, for
Nock `6` to complete, `*[a b]` can only be `0` or `1`.


We now know everything we need to build our decrement function. We're going to
skip over Nock `9` for now and come back to it later. Nock `9` is just a macro,
it doesn't let us do anything new; it lets us do something in a single
operation that would have otherwise take several. But the purpose of Nock `9`
doesn't really make a lot of sense until we've sunk our teeth into some real
Nock code.


 
