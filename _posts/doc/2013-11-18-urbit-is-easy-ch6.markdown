---
layout: post
category: doc
title: Urbit Is Easy&#58; Chapter VI (Hoon Goes Wild)
---

[**Prev**: Hoon Attacks](urbit-is-easy-ch5.html)

*"What good is a phone call if you're unable to speak?"*
**(The Matrix)**

##More simple types##

Before we actually do some programming with Hoon, let's meet two 
more kinds of type - `%face` and `%fork`:

    ++  type  $|  ?(%noun %void)
              $%  [%atom p=term]
                  [%cell p=type q=type]
                  [%cube p=* q=type]  
                  [%face p=term q=type]
                  [%fork p=type q=type]
              ==

###`%fork`###

`%fork` is simply a union type.  A type is a set of nouns -
`[%fork p q]` means "it could be a p, or maybe a q."

Any branching computation in which different branches produce
different types will generate a fork.  For example, without
worrying too much about what this expression means:

    ~zod/try=> :type; ?:(& %foo [13 10])
    %foo
    {%foo [@ud @ud]}

    ~zod/try=> -:!>(?:(& %foo [13 10]))
    [ %fork
      p=[%cube p=7.303.014 q=[%atom p=%tas]]
      q=[%cell p=[%atom p=%ud] q=[%atom p=%ud]]
    ]

Here we start to understand why the type renderer is useful, as
`{%foo [@ud @ud]}` (which is *not* in any way Hoon syntax) is a
little easier to read than the actual type noun.

(Readers of a mathematical bent may ask: since Hoon has a union
type, where is the intersection type?  There is none.  Hoon is
not one of these languages whose goal is to be as mathematically
powerful as possible.  Since a programming language is a UI for
programmers, and programmers are not mathematicians, Hoon is
designed to be as powerful as it has to be - and no more.)

###`%face`###

A type is not just a set of nouns - it's also a semantics for
that set.  In practice, this means a namespace.

Let's use this feature:

    ~zod/try=> foo=42
    foo=42
    ~zod/try=> :type; foo=42
    foo=42
    foo=@ud
    ~zod/try=> -:!>(foo=42)
    [%face p=%foo q=[%atom p=%ud]]

With `%face`, we've simply wrapped a label around another type.
Note that this doesn't impair our ability to compute with the
value, which is of course the same noun it always was:

    ~zod/try=> (add 17 foo=42)
    59

But how do we use this namespace?

To play comfortably with names, it'll help if we introduce some
Arvo shell syntax.  As in Unix, you can bind variables in the
Arvo shell:

    ~zod/try=> =test 42
    ~zod/try=> test
    42
    ~zod/try=> (add 17 test)
    59

(`=variable expression` is *not* in any way Hoon syntax - any
Hoon expression is a valid Arvo command, but not every Arvo
command is a Hoon expression.)

Let's put a `%face` inside this shell variable and try to use it:

    ~zod/try=> =test foo=42
    ~zod/try=> test
    foo=42
    ~zod/try=> foo.test
    42

You probably expected it to be `test.foo`.  This disoriented
feeling should vanish in a few minutes.  Let's go further:

    ~zod/try=> =test foo=42
    ~zod/try=> test
    foo=42
    ~zod/try=> foo.test
    42

    ~zod/try=> =test bar=foo=42
    ~zod/try=> test
    bar=foo=42
    ~zod/try=> -:!>(test)
    [%face p=%bar q=[%face p=%foo q=[%atom p=%ud]]]

    ~zod/try=> bar.test
    foo=42
    ~zod/try=> -:!>(bar.test)
    [%face p=%foo q=[%atom p=%ud]]

    ~zod/try=> foo.bar.test
    42
    ~zod/try=> -:!>(foo.bar.test)
    [%atom p=%ud]

    ~zod/try=> foo.test
    ! -find-limb.foo
    ! find-none
    ! exit

###Name resolution###

We're starting to learn a little about name resolution in Hoon.
We've seen that `foo.bar.test` means "foo in bar in test."  We've
seen that faces have to be unwrapped a layer at a time, so "foo in
test" is an error.

Let's try some cells:

    ~zod/try=> =test [cat=3 dog=4]
    ~zod/try=> cat.test
    3
    ~zod/try=> =test [cat=3 dog=[pig=9 rat=12]]
    ~zod/try=> rat.dog.test
    12

We see that name resolution seeks into cells.  This solves one of
the problems we had when programming in Nock.  For example:

    ~zod/try=> =test [cow=97 test]
    ~zod/try=> cow.test
    97
    ~zod/try=> rat.dog.test
    12

By replacing `test` with `[cow=97 test]`, we've done exactly the
same thing as nock `8`.  (And we'll do more of it.)  Note that
because we didn't wrap a face around `test`, we seek into it when
looking for `dog`, and `rat.dog.test` works just the same way.
Even though `dog` is now at a different axis within `test`.

Interesting cases tell us more about the search algorithm:

    ~zod/try=> =test [cat=3 cat=[pig=9 rat=12]]
    ~zod/try=> cat.test
    3
    ~zod/try=> pig.cat.test
    ! -find-limb.pig
    ! find-none
    ! exit

We see that when we search a cell, we search the head first.  It
is not in any way an error to have two faces with the same name.
And in fact, we can even work with this constraint:

    ~zod/try=> ^cat.test
    [pig=9 rat=12]
    ~zod/try=> pig.^cat.test
    9

A `limb` to resolve is not just a name - it takes a prefix which
is an arbitrary number of `^` characters.  This count is the
number of name instances to ignore before matching.  For
instance: 

    ~zod/try=> =test [cat=3 cat=[pig=9 rat=12] cat=42]
    ~zod/try=> ^^cat.test
    42

We're actually ready to describe the full resolution model...

###Wing resolution###

A `wing` is a dot-separated list, reading outside to in from
right to left.  Each element is a `limb`.  We've seen one kind of
limb - the name, with `^` prefixes.

But we can also use axes directly from Hoon.  For instance:

    ~zod/try=> +3.test
    dog=[pig=9 rat=12]
    ~zod/try=> dog.test
    [pig=9 rat=12]

Note the difference between these two...

