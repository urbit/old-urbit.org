---
layout: post
category: doc
title: Urbit Made Easy&#58;  Chapter IV
---

#Chapter IV: Decrement#

Let's say we have an atom 42. In Nock, incrementing 42 is easy: `*[42 4 0 1]`
returns 43. But what if instead of adding 1 to 42 we wanted to subtract 1 and
get 41?

As you may have noticed, Nock has an increment operator ("+", Nock 4) but no
decrement operator. This means that we'll have to build one. 

Our criteria for a decrement function in Nock is that it has to be some formula
that when given any atomic subject a, produces a - 1.

The first piece of decrement that we'll need is a test for whether an atom b is
equal to one less than an atom a. In other words, is b equal to a decremented.
Which is equivalent to testing whether a is equal to b incremented. Of course,
to test whether two things are equal, we'll use Nock 5. 

	*[[a b] 5 0 1]
	=*[[a b] 0 1]
	=[a b]

	*[[a b] 5 [0 2] [4 0 3]]
	=*[[a b] [0 2] [4 0 3]]
	=[*[[a b] 0 2] *[[a b] 4 0 3]] 
	=[a +b]

Now we've got our test `[5 [0 2] [4 0 3]]`, time to put that in an if statement.
If our test is true, we want to return b. If it's false, then let's say we want
to return [a +b]

	*[[a b] 6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]

Let's test our if statement with the cell 42 41:

	*[[41 42] 6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]

	6r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]

	*[[41 42] *[[0 2] [[4 0 2] 0 3]] [0 *[[2 3] [0 ++*[[41 42] [5 [4 0 2] 0 3]]]]]
 
	*[[41 42] *[[0 2] [[4 0 2] 0 3]]  [0 *[[2 3] [0 ++=[+41 42]]]]]

	*[[41 42] *[[0 2] [[4 0 2] 0 3]]  [0 *[[2 3] [0 ++=[42 42]]]]]

	*[[41 42] *[[0 2] [[4 0 2] 0 3]] [0 *[[2 3] [0 ++0]]]]

	*[[41 42] *[[0 2] [[4 0 2] 0 3]]  [0 *[[2 3] [0 2]]]]

	*[[41 42] *[[0 2] [[4 0 2] 0 3]]  [0 2]]

	*[[41 42] [0 2]]

	41

And now with the cell: [40 42]

	*[[40 42] 6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]

	6r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]

	*[[40 42] *[[0 2] [[4 0 2] 0 3]] [0 *[[2 3] [0 ++*[[40 42] [5 [4 0 2] 0 3]]]]]
 
	*[[40 42] *[[0 2] [[4 0 2] 0 3]] [0 *[[2 3] [0 ++=[+40 42]]]]]

	*[[40 42] *[[0 2] [[4 0 2] 0 3]] [0 *[[2 3] [0 ++=[41 42]]]]]

	*[[40 42] *[[0 2] [[4 0 2] 0 3]] [0 *[[2 3] [0 ++1]]]]

	*[[40 42] *[[0 2] [[4 0 2] 0 3]] [0 *[[2 3] [0 3]]]]

	*[[40 42] *[[0 2] [[4 0 2] 0 3]] [0 3]]

	*[[40 42] [4 0 2] 0 3]

	[*[[40 42] [4 0 2]] *[[40 42] 0 3]]

	*[41 *[[40 42] 0 3]]

	[41 42]

If we took [41 42] and ran that back through our if statement (which is exactly
what we did the first time), it would produce 41, which is, of course, 42 - 1
or 42 decremented.

Now imagine what would happen if we put the cell [0 42] into our if statement.
The test would say that =[+0 42] is "no" and would return [+0 42], which is [1
42]. If we then ran [1 42]we'd get [2 42]. And if we kept daisy-chaining the
output of the if statement back in, after another 39 tries we'd get [41 42],
which would test "yes" and our if statement would return41.

That's roughly going to be the structure of our decrement algorithm. We take an
atom a, create the cell [0 a], run the cell through the above if statement, and
then keep looping through Nock 6 (output turning into input etc. etc.) until
the 0 in [0 a] counts up to a - 1. Simply,  We're calculating a minus one by
counting up from 0. At which point, we exit the loop and end.

It's pretty easy to see how we can do this manually. But that would take a
while, and besides, wouldn't fulfill our criteria for a decrement function. 

Let's figure out how to create the cell [0 a] first and then we'll attack the
problem of looping. Remember that our decrement criteria specificied that our
Nock code has to accept an atom, unlike our decrement test, which accepts only
cells.

Fortunately, we've got Nock 8,

	8r ::     *[a 8 b c]        *[[*[a b] a] c]

which takes a subject, applies a formula to it, and turns it into the new
subject `[*[a b] a]]` before applying a second formula to it.

Let's say our decrement test is the second formula (corresponding to c). As a
big blob this looks like:

	*[a 8 b [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]

We want to figure out what to set b as in order to turn `[*[a b] a]] into [0 a]`.

We'll use Nock 1, which produces an argument without reference to the subject.

	22 ::    *[a [1 b]]          b

If we say that b is 0,` *[a [1 0]]` will just produce 0.

Which means that with:

	*[a 8 b [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]

If we set our first formula for Nock 8 as [1 0], `[*[a b] a]]` will simply turn
into [0 a], which is what we wanted.

Walking through it:

	*[a 8 [1 0] [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]

	8r ::     *[a 8 b c]        *[[*[a b] a] c]

	*[[*[a [1 0]] a] [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]

	22 ::    *[a [1 b]]          b

	*[[0 a] [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]



Now let's figure out how to loop:

	*[42 8 [1 0] [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]

to make this easier to read, we'll replace our Nock 6 decrement test with
"test"

	*[42 8 [1 0] test]

	*[[0 42] test]

which of course, returns [1 42]. 

What we want to do is create some code that runs "test" on [0 42] forty-one
times, piping the output of the first into the input of the second, until the
subject of the last test is [41 42]. Obviously this would be silly, but you
could think of this structure as looking something like:

	[[0 42] [test [test [test [test ... etc.]]]]

Problem is, the number of tests is going to depend on size of a in [0 a], in
this case, 42. So what we have to do instead is give our test a way to refer to
itself. If =[+b a] produces "no", instead of our else formula just producing
[+b a], we want it to automatically call the entire test and run it on [+b a].

Our current test says:

	[6 
	[5 [4 0 2] 0 3]        ::if =[+b a]
		[0 2]          ::then b
		[[4 0 2] 0 3]] ::else [+b a]

we want it to say:

	[6 
	[5 [4 0 2] 0 3]        ::if =[+b a]
		[0 2]          ::then b
		?		::else [[+b a] test]

To do this, we're going to do something we've never done before, we're going to
put code, in this case "test" into our subject and we're going to build a
formula "sel" that will allow us to select our test and apply it .

We'll use Nock 8 for this:

	*[[0 42] 8 [1 test] sel]

		8r ::     *[a 8 b c]        *[[*[a b] a] c]

	*[[*[[0 42] [1 test]] [0 42]] sel]

And then Nock 1:

	*[[test [0 42]] sel]


The subject [test [0 42]] is called a core. Nearly everything interesting in
Urbit is done using cores.

We want to figure out how to write "sel" to turn 

	*[[test [0 42]] sel]

into 

	*[[test [0 42]] test]

Since we have two copies of test, we can have one refer to the other if the
test returns "no.


Okay, so for sel, 

Nock 0, [0 2] allows us to refer to "test" which is in the head of our subject.

However, simply doing:

	*[[test [0 42]] sel]

	*[[test [0 42]] 0 2]

	*[test]

which isn't useful. So we'll have to get creative. Remember, we're looking to
get:

	*[[test [0 42]] test]

Let's try adding Nock 2, with formula-b set as [0 1] and formula-c set as [0
2]:

	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]

	*[[test [0 42]] 2 [0 1] 0 2]

	*[*[[test [0 42]] [0 1]] *[[test [0 42]] 0 2]]

	*[[test [0 42]] test]

Success! sel is now set as [2 [0 1] 0 2].


Now let's add our test back in so we can edit our else formula:

	*[[test [0 42]] [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]

There's a small fix we have to make first, when we changed the subject of our
test from [0 42] to [test [0 42]] we change the slot addresses of 0 and 42. 

With a subject [0 42], 0 has the slot address /2 and 42 has the address /3.
With [test [0 42]], 0 is at /6  and 42 is at /7 (because we we moved [0 42]
down one step the tail branch. [0 42] itself is now at /3).

So let's fix the addresses:

	*[[test [0 42]] [6 [5 [4 0 2] 0 3] [0 2] [[4 0 2] 0 3]]]

We'll just replace every 2 with a 6 and every 3 with a 7:

	*[[test [0 42]] [6 [5 [4 0 6] 0 7] [0 6] [[4 0 6] 0 7]]]

Now let's change our else formula [[0 6] 4 0 7]. 

If our test returns "no", we want our else formula, instead of producing [1 42]
to produce:

	*[[test [1 42]] test]

So we want to do pretty much exactly what we already did with sel:

	[2 [0 1] 0 2].

Let's try just setting our else formula to sel

	*[[test [0 42]] [6 [5 [4 0 6] 0 7] [0 2] [2 [0 1] 0 2]]]

if our test returns "no":

	*[[test [0 42]] [2 [0 1] 0 2]]

	*[*[[test [0 42]] [0 1]] *[[test [0 42]] 0 2]]

	*[[test [0 42]] test]

Small problem, since we got rid of the Nock formula that actually does the work
of incrementing 0, ([[0 6] 4 0 7]), we'll just keep doing the same thing over
and over again. we've got a loop alright, it's an infinite loop.

So let's add to sel so that it actually implements [[4 0 6] 0 7].

We'll use Nock 7, since we want to apply [[4 0 6] 0 7] and sel `(2 [0 1] [0 2]]`)
to [test [0 42]] in order. 


	[test [0 42]] [7 [[4 0 6] 0 7] 2 [0 1] [0 2]]

	7r ::     *[a 7 b c]         *[*[a b] c]

	*[*[[test [0 42]] [[4 0 6] 0 7]] 2 [0 1] [0 2]]

	*[[1 42]] 2 [0 1] [0 2]]

Oops, looks like we accidentally got rid of test!

Let's try it again, but we'll add a [0 2] this time so that doesn't happen:

	[7 [0 2] [[4 0 6] 0 7] 2 [0 1] [0 2]]


	*[[test [0 42]] [7 [[0 2] [[4 0 6] 0 7]] 2 [0 1] [0 2]]

	7r ::     *[a 7 b c]         *[*[a b] c]


	*[*[[test [0 42]] [0 2] [[4 0 6] 0 7]] 2 [0 1] [0 2]]

	19 ::    *[a [b c] d]      [*[a b c] *[a d]]

	*[[*[[test [0 42]] [0 2]] *[[test [0 42]]] [4 0 6] 0 7] 2 [0 1] [0 2]]

	21 ::    *[a [0 b]]          /[b a]

	*[[test *[[test [0 42]] [4 0 6] 0 7]] 2 [0 1] [0 2]]

	21 ::    *[a [0 b]]          /[b a] 25 ::    *[a [4 b]]          +*[a b]

	*[[test [1 42]] 2 [0 1] [0 2]]

	23 ::    *[a [2 [b c]]]      *[*[a b] *[a c]]

	*[*[[test [1 42]] 0 1] *[[test [1 42]] 0 2]]

	21 ::    *[a [0 b]]          /[b a]

	*[[test [1 42]] test]

Which is exactly what we wanted.

You'll notice that before we ran our test, we had the noun:

	*[[test [0 42]] test]

and after, we had produced the noun:

	*[[test [1 42]] test]

Which has exactly the same structure. And the above will produce

	*[[test [2 42]] test]

And so on and so forth. Until we get to 

	*[[test [41 42]] test]

We know from our test that =[+41 42] will return "yes", which will activate our
then formula, which is simply [0 6]:

	*[[test [41 42]] [0 6]]

	41

Now that we have a good idea of how the loop in decrement works, let's put the
pieces together:

We start with an atom a:

	[a

we use Nock 8 to turn it into the cell [0 a]

	[8 
		[1 0]

we'll use another Nock 8 and our test to produce a core:

	[8 1
	[6 
		[5 [4 0 6] 0 7]                      ::if =[+b a]
		[0 6]                                ::then b
		[7 [0 2] [[4 0 6] 0 7] 2 [0 1] 0 2]  ::else [[test [+b a]] test]
	]
	
	]
And finally, we'll add "sel", which allows us to select a formula (an "arm") 
from our core, turning [test [0 a]] into [[test [0 a]] test]:

	 [2 [0 1] 0 2]
	]
	]

And all together:

	[a
	   [8 
		[1 0]                                        ::declare variable b

	        [8 1                                         ::build core

		   [6                                        ::if    
			[5 [4 0 6] 0 7]                      ::=[+b a]
			[0 6]                                ::then b
			[7 [0 2] [[4 0 6] 0 7] 2 [0 1] 0 2]  ::else [[test [+b a]] test]
		   ]

	        ]

		[2 [0 1] 0 2]                                :: activate core
	   ]
	]


And that's decrement in Nock. 

However, we can actually simplify this, by using Nock 9. Now that you know
decrement, Nock 9 is trivially simple:

Nock 9:

##`9` Reduction:##

	31 :: *[a 9 b c]        *[a 7 c [2 [0 1] [0 b]]]
    
	*[a 7 c [2 [0 1] [0 b]]]
    
	7r ::     *[a 7 b c]         *[*[a b] c]
    
	*[*[a c] [2 [0 1] [0 b]]]
	
	23 ::     *[a 2 b c]        *[*[a b] *[a c]]
    
	*[*[*[a c] [0 1]] *[*[a c] [0 b]]]
    
	21 ::     *[a 0 b]          /[b a]
    
**`9` Reduced:**    

	9r ::     *[a 9 b c]        *[*[a c] *[*[a c] 0 b]] 


Looking at the line 31 in Nock:

	31 :: *[a 9 b c]        *[a 7 c [2 [0 1] [0 b]]]

We notice that the definition on Nock 9 is exactly the same structure as our
else formula:

	[7 [0 2] [[4 0 6] 0 7] 2 [0 1] 0 2] 

Which we could rewrite as:

	[9 2 [4 0 6] 0 7]

Really, that's a lot cleaner, don't you think?

Nock 9 is designed to do operations on cores.

We can also replace our old friend sel with Nock 9:

	[2 [0 1] 0 2]   

turns into:

	[9 2 0 1]

Not a whole lot simpler, but still simpler.

Simplified, Decrement looks like this:


	[a
	   [8 
		[1 0]                                       ::declare variable b

	        [8 1                                        ::build core

		   [6                                       ::if    
			[5 [4 0 6] 0 7]                     ::=[+b a]
			[0 6]                               ::then b
			[9 2 [4 0 6] 0 7]                   ::else loop		   ]

	        ]

		[9 2 0 1]                                   :: activate core
	   ]
	]


And that's the whole Nock specification. Nothing more, nothing less. If you
followed all that closely, you likely feel like you understand Nock somewhat,
but by no means feel mastery over it.

In the next section, we'll expand on our understanding of cores and write
addition, subtraction, multiplication, and division functions, as well as a
less-than function. 

 
