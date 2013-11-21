---
layout: post
category: doc
title: Urbit Made Easy&#58; Chapter IV
---

#Basic Math in Nock#

In the last chapter we wrote Decrement, 

	[a
	   [8 
		[1 0]                                       ::declare variable b

	        8 [1                                        ::build core

		   [6                                       ::if    
			[5 [4 0 6] 0 7]                     ::=[+b a]
			[0 6]                               ::then b
			[9 2 [0 2] [4 0 6] 0 7]             ::else loop		   
		   ]
	          ]

		[9 2 0 1]                                   :: activate core

	        ]
           ]



On one line:

	[8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]


Now we're going to write Add.

Add takes a cell [a b] and returns an atom a + b. 

Let's describe our algorithm in english:

Just like decrement counted up from 0 to a - 1, add is going to count up from a to a + b. 

We'll create a new variable c (with Nock 8) and set that to 0.  

	[0 [a b]] 

And then we'll test whether c is equal to b, if not we'll increment c and a, and if it is, we'll produce a. That way we should loop through b cycles of incrementing c, and if for b cycles, we add one to a, we're effectively adding b times one, or just b to a.

So our add function is going to have a lot of the same pieces as decrement. Let's write some code comments:

	:: declare c = 0 
	:: build core [0 [a b]]
			
	::if    
	::=[c b]
	::then a
	::else +a, +c and loop	
	
	:: activate core
			

The first two lines are easy, exactly like decrement

	[[a b]

	    [8                                              :: declare c = 0 
		[1 0]                                       :: [0 [a b]]
		
And making our core ([test subject]):

     		8 [1  

Our if statement is a little different. We have a little work to do to keep our tree addresses straight. Remember that our subject [c [a b]] is in the tail of our core with an address of 3. c is at 6, a is at 14 (2 times 7) and b is at 15.

		   [6                                       ::if    
			[5 [0 6] 0 15]                      ::=[c b]
			[0 14]                              ::then a

Pretty easy so far. Our else formula is a little trickier. But there's really not a huge leap between
`[+c [+a b]]`, (where c is at [0 6], a is at [0 14] and b is at [0 15]), and the following:

			[9 2 [0 2] [4 0 6] [[4 0 14] 0 15]]                ::else +a, +c and loop				


And finally we activate our core:


   ]
	        ]

		[9 2 0 1]                                   :: activate core
	   ]
	]


All together:

	[[a b]

	    [8                                              :: declare c = 0 
		[1 0]                                       :: build subject [0 [a b]]

     		8 [1                                        :: build core

		   [6                                       ::if    
			[5 [0 6] 0 15]                      ::=[c b]
			[0 14]                              ::then a
			[9 2 [0 2] [4 0 6] [[4 0 14] 0 15]] ::else +a, +c and loop				
		   ]

		[9 2 0 1]                                   :: activate core
	   ]
	]


And that's add in Nock. Easy peasy.

On one line:

	[8 [1 0] 8 [1 6 [5 [0 6] 0 15] [0 14] 9 2 [0 2] [4 0 6] [4 0 14] 0 15] 9 2 0 1]


Now let's do subtraction. Subtract (or "sub") is exactly like add, except instead of counting up from a to a + b, we count down from a to a - b. How do we count down? Simple, we just wrote a handy decrement function ("dec"). The only different thing about sub is that we've now got two loops, one nested inside the other.

Here's add:

	[[a b]

	    [8                                              :: declare c = 0 
		[1 0]                                       :: build subject [0 [a b]]

     		8 [1                                        :: build core

		   [6                                       ::if    
			[5 [0 6] 0 15]                      ::=[c b]
			[0 14]                              ::then a
			[9 2 [0 2] [4 0 6] [[4 0 14] 0 15]] ::else +c, +a and loop				
		   ]
	        ]

		[9 2 0 1]                                   :: activate core
	   ]
	]


And we'll just swap out our else formula

	[9 2 [0 2] [4 0 6] [[4 0 14] 0 15]] 

with 

	[9 2 [0 2] [4 0 6] [[dec (0 14)] 0 15]] 


Decrement on a single line:

	[8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]


And now our new else statement. We'll apply dec to [0 14] using Nock 7, since we want to apply them sequentially to the subject.

	[9 2 [0 2] [4 0 6] [7 [0 14] [8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]] [0 15]]

It looks a little bulky, but it gets the job done. 


	[[a b]

	    [8                                              :: declare c = 0 
		[1 0]                                       :: build subject [0 [a b]]

     		[8 1                                        :: build core

		   [6                                       ::if    
			[5 [0 6] 0 15]                      ::=[c b]
			[0 14]                              ::then a
			[9 2 [0 2] [4 0 6]                  ::else, +c, dec a and loop

				[7 [0 14]                             

        		 [8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]
			 ] 

			[0 15]			
		  	]
	        ]

		[9 2 0 1]                                   :: activate core
	   ]
	]

On one line:


	[8 [1 0] 8 [1 6 [5 [0 6] 0 15] [0 14] 9 2 [0 2] [4 0 6] [7 [0 14] [8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]] 0 15] 9 2 0 1]


Works perfectly well, but isn't really very elegant. Instead, let's try putting decrement in our core:

[[sub dec] subject]

	[[a b]

	    [8                                              :: declare c = 0 
		[1 0]                                       :: build subject [0 [a b]]

     		8 [1                                        :: build core
		   
		   [6                                       ::sub  
			[5 [0 6] 0 15]                      ::=[c b]
			[0 14]                              ::then a
			[9 4                                ::else
				[0 2] 
				[4 0 6]                     ::+c
				[2 [0 14] [0 5]]            ::dec a
				[0 15]                      ::b
                        ]
		
		   ]
                                                            ::decrement in core
		[8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]
		   		  ]
	

		[9 4 0 1]                                   :: activate core with sub
	   ]
	]

We've had to change some tree addresses, because our core now is `[[sub dec] [0 [a b]]]` instead of `[sub [0 [a b]]]`

On one line:


	[8 [1 0] 8 [1 [6 [5 [0 6] 0 15] [0 14] 9 4 [0 2] [4 0 6] [2 [0 14] [0 5]] 0 15] [8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]] 9 4 0 1]


Which is a little better, but not much. 

However now that we have dec in our core we can use it in multiple places in our code. Which means we can restructure our subtraction function:

	[[a b]                                              ::suject [a b]

     		[8                                          :: build core
		   [1
		   [6                                       ::sub  
			[5 [1 0] 0 7]                       ::=[0 b]
			[0 6]                               ::then a
			[9 4                                ::else
				[0 2] 
				[2 [0 6] [0 5]]             ::dec a
				[2 [0 7] [0 5]]             ::dec b
                        ]
		
		   ]
                                                            ::decrement in core

		   [8 [1 0] 8 1 6 [5 [4 0 6] 0 7] [0 6] [9 2 [0 2] [4 0 6] [9 2 0 1]]] 
		  ]

		[9 4 0 1]                                   :: activate core with sub
	   ]
	]


We've now gotten rid of our variable c, and are just counting down from b to 0. We decrement a and b together and when b equals 0, a will equal a - b. This required some more tree address changes because our core here is now `[[sub dec] [a b]]`, meaning a is at `[0 6]` and b is at `[0 7]`.


On one line:

	[8 [1 [6 [5 [1 0] 0 7] [0 6] 9 4 [0 2] [2 [0 6] [0 5]] [2 [0 7] [0 5]]] [8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]] 9 4 0 1]


Putting multiple formulas in a core is a useful technique to simplify our Nock. Effectively, we can now assemble a library of functions in our core and then pick and choose which ones we want to run.


Cool? Cool. Now let's do multiply:

It's a lot like our multi-formula subtract, except we need our variable c again, and we have to include add as well as dec in our core. Our core will now be `[[mul [dec add]] [0 [a b]]]`



	[[a b]                                              ::suject [a b]

	    [8                                              :: declare c = 0 
		[1 0]                                       :: build subject [0 [a b]]

     		[8                                          :: build core
		   [1
		   [6                                       ::mul  
			[5 [1 0] 0 15]                      ::=[0 b]
			[0 6]                               ::then c
			[9 4                                ::else
				[0 2]
				[2 [[0 6] [0 14]] [0 11]]   ::$(c (add a c))
				[0 14]                      ::a
				[2 [0 15] [0 10]]           ::$(b (dec b))
	                        ]
		
		   ]
                                                            ::decrement in core

	[8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1]
	
						            ::add in core
	
	[8 [1 0] 8 [1 6 [5 [0 6] 0 15] [0 14] 9 2 [0 2] [4 0 6] [4 0 14] 0 15] 9 2 0 1]
 	
		  ]

		[9 4 0 1]                                   :: activate core with sub
	   ]
	]



On one line:

	[8 [1 0] 8 [1 [6 [5 [1 0] 0 15] [0 6] [9 4 [0 2] [2 [[0 6] [0 14]] [0 11]] [0 14] [2 [0 15] [0 10]]]] [8 [1 0] 8 [1 6 [5 [4 0 6] 0 7] [0 6] 9 2 [0 2] [4 0 6] 0 7] 9 2 0 1] [8 [1 0] 8 [1 6 [5 [0 6] 0 15] [0 14] 9 2 [0 2] [4 0 6] [4 0 14] 0 15] 9 2 0 1]] 9 4 0 1]



If you followed all that, you likely now know Nock to the point of frustration. Next chapter we'll start to introduce Hoon, a language built on top of Nock to make Nock practical. 
