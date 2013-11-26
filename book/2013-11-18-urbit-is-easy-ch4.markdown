---
layout: post
category: doc
title: Urbit Is Easy&#58; Chapter IV (Using Nock)
---

#*"But are you crazy enough?"*#
###(Point Break)###

##Using Nock##

Now we're going to actually do some cool stuff with Nock.

Fortunately, we have an entire OS, Arvo, which is built on Nock.
Unfortunately, there's really no practical reason to work
directly in Nock when you're using Arvo - except for learning
Nock, which you do once and never again.  So the things we'll
have to do are a little bit cumbersome.

What Arvo is good at is evaluating Hoon.  And it's possible to
evaluate Nock from Hoon, much the way you can put inline assembly
in C.  Through this indirection, we have two ways to run Nock in
Hoon: on the command line and via an app file.

###Command line###

From the Arvo command line, you can run one-liners with the Hoon
rune `.*`:

    ~zod/try=> .*(42 [4 0 1])
    43

###Application file###

Unfortunately, the Arvo command line doesn't do multiline input
well, and if there's any hope of writing complex Nock formulas
it's by using plenty of whitespace and linebreaks.

So we've constructed a template for writing Nock formulas as Arvo
applications.  Unfortunately Arvo is a young OS and has no way to
edit a file.  But Arvo runs on Unix and Unix is a very old OS.
Arvo syncs its filesystem with your `$URBIT_HOME` directory,
propagating changes on either side.

Let's assume your `$URBIT_HOME` is `urb/`, and your ship is
`~zod`.  The Nock application template is in

    urb/zod/try/bin/nock.hoon

Its text should be:

    !:             ::  To write Nock as an Arvo application in Hoon
    |=  *          ::
    |=  [a=* ~]    ::  For educational purposes only
    :_  ~  :_  ~   ::
    :-  %la        ::  Preserve this mysterious boilerplate square
    %+  sell  %noun::
    .*  a          ::  Replace the formula with your own
    :::::::::::::::::
                   ::  Formula: increment
    [4 0 1]

Test this by running:

    ~zod/try=> :nock 42
    43

Our first complex example will be a decrement function.  With or 
without `vere` running, copy the template from Unix:

    $ cp urb/zod/try/bin/nock.hoon urb/zod/try/bin/dec.hoon

Then, use a Unix editor to change "Formula: increment" to
"Formula: decrement" in `dec.hoon`.

Either next time you start `vere`, or on your next keyboard event
if you're already running it, you'll see something like

    \+ /~zod/try/1/bin/dec/hoon

Arvo has slurped up dec.hoon from your filesystem.  To test it,

    ~zod/try=> :dec 42
    43

Well, we didn't change the formula, so it still increments.  But
it's a start.

###Decrement###

The only arithmetic operation in Nock is increment.  So how do we
decrement?  The algorithm is obvious: to decrement `n`, start
from `0`, and count up to `n-1`.  Or rather, count up to a number
`m` such that `m+1` equals `n`.

(Is this going to be an `O(n)` algorithm?  It is.  How do we
compute effectively in a platform where decrement is `O(n)`?
Gosh, it seems difficult, doesn't it?  We'll get to that.)

The first thing we're going to need is a counter.  Right now
our subject is just the atom we're trying to decrement - `/1`,
referenced with the formula `[0 1]`.  Thus, to increment it,
the formula is `[4 0 1]`.

Let's try to put the counter into the subject with one of our 
macros operators, `8`.  Recall our revised rule for `8`:

    34r::    *[a 8 b c]       *[[*[a b] a] c]

The formula `c` is applied to the subject `[*[a b] a]`.  What is
our `b`?  It should just produce our initial counter value - 0.
So, use operator `1` to produce a constant - `[1 0]`.  Let's 
put this counter in the subject, and then increment as usual.

Edit `dec.hoon` so that the formula reads

    [ 8
      [1 0]
      [4 0 1]
    ]

Note that for these tall bracket structures, the space after `[`
is essential.  Then, you'll see the file automatically update in
Arvo:

    : /~zod/try/2/bin/dec/hoon
    ~zod/try=> :dec 42

Whoops!  It crashed:

    ! /~zod/try/~2013.11.26..00.01.38..499b/bin/dec/:<[4 1].[13 2]>
    ! /~zod/try/~2013.11.26..00.01.38..499b/bin/dec/:<[4 8].[13 2]>
    ! /~zod/try/~2013.11.26..00.01.38..499b/bin/dec/:<[5 1].[13 2]>
    ! /~zod/try/~2013.11.26..00.01.38..499b/bin/dec/:<[6 1].[13 2]>
    ! /~zod/try/~2013.11.26..00.01.38..499b/bin/dec/:<[7 1].[13 2]>
    ! exit

What did we do wrong?  We forgot that the subject had changed.
When we get to `[4 0 1]`, the subject is not `42`, but `[0 42]` -
the counter is there.  So our original argument, `42`, is
actually at `/3`: 

    [ 8
      [1 0]
      [4 0 3]
    ]

    : /~zod/try/3/bin/dec/hoon
    ~zod/try=> :dec 42
    43

Okay, at least it increments again.  (Constantly readjusting tree
addresses by hand is one good reason to use a higher-level
language, like Hoon.) But now, perhaps, we can build a decrement
that works for at least one input value - `1`.

Obviously at some point we'll have to build a loop.  But for now,
all we need is an if statement that compares the incremented
counter to the original argument.  We know the original argument
is at `/3`, and the counter is at `/2`; we use the if operator,
`6`, and the equality test operator `5`.  If the comparison
fails, we shrug our shoulders and keep incrementing the argument.

    [ 8
      [1 0]
      [ 6
        [5 [4 0 2] [0 3]]
        [0 2]
        [4 0 3]
      ]
    ]

    : /~zod/try/4/bin/dec/hoon
    ~zod/try=> :dec 42
    43
    ~zod/try=> :dec 1
    0

We're getting closer.  But now, that loop...

Up till now, our subject has contained only data.  If we want to
loop, we're obviously going to have to bite the bullet and put
code in our subject - which will become a `[code data]` cell.
In Nock (and Hoon) this is called a `core`.

Suppose we take our `6` formula and put it in the subject.  Then,
with this core subject `[formula counter argument]`, we'll run
the formula itself.  With this subject, the formula is `/2`, and
of course the core itself is `/1`.  So we can activate the core
with `[2 [0 1] [0 2]]`.

Of course, since the subject has changed again, we need to change
the addresses again.  The counter is now `/6` and the argument
is now `/7`:

    [ 8
      [1 0]
      [ 8
        [ 1 
          [ 6
            [5 [4 0 6] [0 7]]
            [0 6]
            [4 0 7]
          ]
        ]
        [2 [0 1] [0 2]]
      ]
    ]

This does exactly the same thing as before:

    : /~zod/try/5/bin/dec/hoon
    ~zod/try=> :dec 42
    43
    ~zod/try=> :dec 1
    0

But somehow, we feel it *could* do better.  Why?  Because where
we do the useless `[4 0 7]`, we have a subject containing the
code we want to invoke.  It's just that the counter is wrong.

We need to do the same thing as `[2 [0 1] [0 2]`, but the subject
is not `[0 1]`.  That would be `[formula counter argument]`.  We
need `[formula (counter + 1) argument]`.

So, `formula` is `[0 2]`, `counter` is `[0 6]`, and `argument` is
`[0 7]`.  With autocons, we can just put them together to make a
(superfluous) formula for `[formula counter argument]` - ie, 

    [[0 2] [0 6] [0 7]]

But we actually want to increment the counter:

    [[0 2] [4 0 6] [0 7]]

And to invoke our formula on this modified core:

    [2 [[0 2] [4 0 6] [0 7]] [0 2]]

If we put this into the decrement, it should actually work:

    [ 8
      [1 0]
      [ 8
        [ 1 
          [ 6
            [5 [4 0 6] [0 7]]
            [0 6]
            [2 [[0 2] [4 0 6] [0 7]] [0 2]]
          ]
        ]
        [2 [0 1] [0 2]]
      ]
    ]

And it does:

    : /~zod/try/6/bin/dec/hoon
    ~zod/try=> :dec 42
    43

But there's one more step.  Remember operator `9`?

    35 ::    *[a 9 b c]       *[a 7 c 2 [0 1] 0 b]
    35r::    *[a 9 b c]       *[*[a c] *[*[a c] 0 b]]

Suppose `c` is a formula that produces a core.  Then we see
immediately what `9` does: it activates a core, using the formula
at `[0 b]`.  

(There's only one formula in our core.  So `b` is always `2`.  But
in the general case, we could have an entire *battery* of
formulas that all work on the same core.  Sort of like an
object... hm...)

So we can rewrite our decrement to use `9`:

    [ 8 
      [1 0] 
      [ 8 
        [ 1 
          [ 6 
            [5 [4 0 6] [0 7]] 
            [0 6] 
            [9 2 [0 2] [4 0 6] [0 7]]
          ]
        ]
        [9 2 0 1]
      ]
    ]

Seems to work nicely:

    : /~zod/try/6/bin/dec/hoon
    ~zod/try=> :dec 42
    43

Of course, there are limits:

    ~zod/try=> :dec 0

You'll have to hit ^C, and you'll see a big ugly error stack.
