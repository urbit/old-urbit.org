---
layout: post
category: doc
title: Chapter 5 &#58; Hoon's Moronic Type System
---

No, we're quite serious about this word _moronic_.  (Since you
ask, it rhymes with _electronic_.) _Scientifically_, we speak of
_moronic type inference_ (MTI).

Why _moronic_?  Here is Hoon's type system - or at least, all
the data structures it uses?

	  |%
	  ++  coil  $:  p=?(%gold %iron %lead %zinc)
	                q=type
	                r=[p=?(~ ^) q=(map ,@tas foot)]
	            ==
	  ++  foot  $%  [%ash p=gene]
	                [%elm p=gene]
	                [%oak ~]
	                [%yew p=(map ,@tas foot)]
	            ==
	  ++  type  $|  ?(%noun %void)
	            $%  [%atom p=@tas]
	                [%cell p=type q=type]
	                [%core p=type q=coil]
	                [%cube p=* q=type]
	                [%face p=term q=type]
	                [%fork p=type q=type]
	                [%hold p=(list ,[p=type q=gene])]
	            ==
	  --

`%oak` and `%yew` are for inheritance, a feature we're not using
yet, but we leave them in for completeness.

(Compare to Professor Pierce's great work on type theory, which
surely somewhere right now is keeping a door open.  We had one
except the dog peed on it.  "PL theory" is in fact a beautiful
symphony of mathematics with many fascinating implications for
programmers.  But if "type" means to you what it means to
Professor Pierce, Hoon actually has no types at all.  Nor don't
we miss 'em.)

The only dependency not included above is `++gene`, a gene being
a node in Hoon's AST.  Ie, one of the mysterious digraphic runes
we saw in the last chapter.  You can look up `++gene` in
`hoon.hoon` - to be fair, it's pretty big.

And of course, there is a bunch of code that uses this structure.
But not as much as one might think.  `++ut` is the Hoon backend,
which combines type inference and Nock code generation.  It's
only a couple thousand lines of code - most of `hoon.hoon` is
actually just standard library.  

Basically, if you understand `++ut`, you understand Hoon.  On the
other hand, 2K lines of Hoon is kind of a cubic fsckton of Hoon.
So we don't mean to oversell our simplicity here.

(The Hoon parser `++vast`, however, is rather gnarly.  It uses
higher-order gonadic combinators, which will assemble a very
elegant looking parser - for a grammar that isn't gnarly.  Hoon's
grammar being immaculate except for the gnarly part, `++scat`.

(_Gonadic combinators_?  Yes - using our _gonad_ rune, `semsig` or
`;~`.  If you are a sophisticated professor type and understand
monads, gonads may seem real familiar to you.  Out here in
Urbit world we are just dumb country peasants and all we got is
gonads.  Which have nothing to do with Golang, alas.  Really, if
you're not into Hoon you better at least be into Go - it's really
almost as stupid.))

But how expressive is this country type system?  It is definitely
less powerful than your slick city Hindley-Milner stuff.  It
didn't seem to have anything to do with crop rotation, so we 
never learned any of this "category theory" in our ag schools.
Moronic type inference - one weird trick CS professors hate.

Love it or hate it, a good test for a type inference system is
whether it can infer the type of the AST from an executable
grammar / top-down LL parser.  Extra credit, if the grammar is
composed as a combinator of general-purpose primitives.

Can Hoon do this?  Can it, for instance, infer or at least check
the `++gene` type against the Hoon grammar that produces it?  Hey, 
we like our suspense around here.  Let's go back to `++type`.

First, even though this is Hoon and you can't read Hoon, you may
find that you're actually able to read these definitions.  For
example, what they're saying is that a `++type` is (like all
nouns) either an atom or a cell.  If it's an atom, it's either 
`%noun` or `%void` - ie, either `0x6e75.6f6e` or `0x6469.6f76`.
If a cell, its head is one of 

	?(%atom %cell %core %cube %face %fork %hold)

and its tail is the corresponding tuple.  Maw always said if you
can milk a cow, you can understand `bucbar` and `bucwut`.  Also,
in a "tagged noun" or `%kelp` of the form `[%cell p=type q=type]`, 
`%atom` is called the `%stem` and `[p=type q=type]` the `%bulb`.
Hoon's doxology thus combines two of our great interests out here
in the real America, plants and four-letter words.

What's extremely strange and confusing, however, is that there is
actually no Hoon syntax which is converted directly, as an AST or
something like it, to one of these `++type` nouns.

In Hoon, a type is always the `range of a function`.  Nouns the
function can produce for some input - or, at least, are suspected
to produce, by our far-less-than-perfect algorithm - are in the
type.  Thus, like a type in any old language, it defines a set 
of values, and also a namespace for acting on those values.

When you do all this `bucbar` manure, you are actually defining
not a type, but a function - specifically, a function whose
_sample_ (Hoon is a single-argument language) is `%noun`.  Ie,
it's a function which converts an untyped noun to a typed noun,
if possible identical with the argument - but in the general
case, a normalizer.

What this means is that if you have some function which needs a
`bar`, and some fool from two counties down sends you a big
binary blob (an `%atom`), `foo`, he can call `(bar (cue foo))` to
deserialize, validate and type this totally untrusted input.  If
poorly formed, it will end up as a default.  Or, if normalization
is not desired, use `((hard bar) (cue foo))`, and you'll exit
(Hoon is big into "crash-only") if anything is wrong.

Validating external data - a lot of your slick city type systems
have trouble with this basic job we do every day down on the
farm.  We guess Haskell is a pretty cool language if you're more
interested in proving some theorem, than making sure cowpox don't
get into the hogpen.  Some of us never proved a theorem in our
lives and we feel just fine.

And one of the unnerving things about unification-based type
inference, as used in Haskell and other (for realz) fine
higher-order typed languages, is that it _reasons backward_.

Perhaps that's all right for Yale.  At Yale, thinking backward,
that's just something you do.  Out here, it's not considered
normal and people is going to look at you funny. 

If we keep our type inference strictly _forward_ as obviously
the good Lord intended, we are left with this basic interface,
which is a simplified version of the real `++ut`:

	  |%
	  ++  nock  $&  [p=nock q=nock]
	            $%  [0 p=@]
	                [1 p=*]
	                [2 p=nock q=nock]
	                [3 p=nock]
	                [4 p=nock]
	                [5 p=nock q=nock]
	                [6 p=nock q=nock r=nock]
	                [7 p=nock q=nock]
	                [8 p=nock q=nock]
	                [9 p=@ q=nock]
	                [10 p=?(@ [p=@ q=nock]) q=nock]
	                [11 p=nock]
	            == 
	  ::
	  ++  mint  |=  [sut=type gen=gene]
	            ^-  [p=type q=nock]
	            !!
	  -- 

`nock` is obviously a Nock formula.  (But why does it go to 11?
Why is there a watermelon there?) In any case, the basic function
of forward type inference is this here function `mint`, which
maps `[sut=type gen=gene]` to a pair `[p=type q=nock]`.

What does `mint` mean?  It means: when you compile `gen` for the
subject type `sut`, `gen` representing in a sense the abstract
Hoon equivalent of a Nock formula, you produce the actual Nock
formula `q`.  And for any subject noun `s`, `nock(s q)` will be
of type `p`.  

All of Hoon's semantics, besides the parser, are in `mint`.  If
this seems not very smart to you maybe you're looking for the
gifted-talented room, it's down the hall.

(What happens if there's an error?  Like, a type error?  Duh, the
compiler crashes.  Hey, at Yale, what do they do if there's an
error?  I don't know but it's probably some kind of fancy
exception thing.  

I'll bet they even have multiple error messages depending on what
failed.  We just say `type-fail`, which is a little backward -
even by Hoon standards.  (Our line and column reports, however,
are always exact - columns especially tell you a lot.))

You could see how this could infer a type, I guess.  Although
it's maybe not so clear when you get to loops and stuff.  But
don't worry, we'll get to that.

It's a general good idea to define your data structures before
you go messing around with code.  So, the only data structure for
which we still don't know what it means, is this `++type` thing.
What is the structure of a `type` and what does it mean?

Let's look at the structure again:

	  ++  type  $|  ?(%noun %void)
	            $%  [%atom p=@ta]
	                [%cell p=type q=type]
	                [%core p=type q=coil]
	                [%cube p=* q=type]
	                [%face p=term q=type]
	                [%fork p=type q=type]
	                [%hold p=(list ,[p=type q=gene])]
	            ==

First, note that `type` is no mere `%kelp` but in fact a `%bush`,
because we overload a set of atoms on a set of cells.  Like
riding ATVs without a helmet, this may seem risky but in fact is
perfectly all right.

`%noun` and `%void` ought to be obvious.  Meaning - the set
of all nouns, and the set of no nouns, respectively.  It's in
fact illegal to `mint` any gene against a `%void` subject.

`%atom` is slightly interesting.  Obviously, it means... atom.
As in, unsigned integer.  But what is the bulb here?

It's a `@tas`, which means an %odor of `%tas`.  This string is
really an extremely compressed way of specifying a conventional
subset hierarchy - in this case _text, ascii, symbol_.  Of
course, Nock stores no dynamic atom type information, but we can
certainly track the encoding and semantics of these unsigned
integers in a static type system.

Other than generating them automatically from parser rules, Hoon
has no idea what these odors mean.  There is no custom semantics
bound to any of them.  Rather, a weak type methodology is applied
to them - data can be converted either up or down the odor stack,
but not across.  Hence `++ut` does not complain if a `@t` is used
as a `@tas`, or a `@tas` as a `@t` (mere Unicode text), but will
dump on you if you send a `@ud` (unsigned decimal).  

Odors are a little floppy but actually work quite well.  Also, you
can place a completely orthogonal capital letter on the tail of
the odor string, to bound the size of the atom.  This follows the
`++bex` function.  A chart is useful for the congenitally dense:

	A   1 bit
	B   2 bits
	C   4 bits
	D   8 bits; 1 byte
	E   16 bits; 2 bytes
	F   32 bits; 4 bytes
	G   64 bits; 8 bytes
	H   128 bits; 16 bytes
	I   256 bits; 32 bytes
	J   512 bits; 64 bytes 
	K   1024 bits; 128 bytes
	L   2048 bits; 256 bytes
	M   4096 bits; 512 bytes
	N   8192 bits; 1K bytes
	O   2K bytes
	P   4K bytes
	Q   8K bytes
	R   16K bytes
	S   32K bytes
	T   64K bytes
	U   128K bytes
	V   256K bytes
	W   512K bytes
	X   1MB
	Y   2MB
	Z   4MB

(Since big computations should be chunked in some way, anyone
needing to manipulate atoms larger than 4MB (which is obviously
perfectly normal and fine) is operating not only outside the type
system, but also way in the future or maybe in Europe.)

Eg: `@tasF` is four letters or less of symbolic ASCII text.
As with the qualitative side of the odor, Hoon has no real idea
what this means and no way to enforce it - the odor is simply a
superficial description.  However, it is still useful to dump if
a `@taG` is being stuffed into a `@tasF`.

Some will find this funky.  Some will find all of Hoon funky.
Anyway.  That's enough for atoms.  Atoms are actually boring.

Stepping through the stems, then there's `%cell`.  This one is
pretty obvious, I hope.

Then there's `%core`.  There are actually only two interesting
type stems, `%core` and `%hold`.  Let's wait for these and step
quickly through the others.

`%cube` is a typed constant.  `p` is the constant, `q` is the
type.  This should probably be the other way around, just out of
good Hoon style, but it'd be a pain to change it.  (For obvious
reasons, `++ut` is some of the oldest Hoon code.)

`%face` wraps a name around a type.  This is obviously orthogonal
to the set of nouns that the type defines, but of course affects
its semantics against Hoon genes.

`%fork` is a union type.  There is no order to %fork -
conflicting semantics are an error.  The real America being
of course union America, Hoon has no intersection type.

Actually `%hold` isn't that interesting.  We only need it
because, unlike that fancy "lazy" FP language everyone is talking
about, Hoon is "strict" or rather just plain country simple.

In that other language they have infinite lists and stuff.  Well,
duh, we heard that and we thought - hey, Professor, you may have an
infinite list but we don't have infinite memory.  How about that!
Guess you should of thought harder about the customer, Professor.

And we left that meeting feeling plenty smart.  But later, we
heard the Professor doesn't have infinite memory either.  He just
builds a data structure which kind of _represents_ an infinite
list.  Guess it warn't for nothing he got that cushy college gig.

Well, _representing_ stuff!  We can do that too.  Except that
instead of an _implicit_ (special fancy) data structure, we'll
have to use an _explicit_ (simple country) one.  This country
approach has a number of distinct advantages, like, for instance,
you can, like, send it over the network without coughing up a
giant mathematical loogie.

The bulb of `%hold` is a list of `[p=type q=gene]` pairs.  The
semantics each is simply defined as the type inferred by `++mint`
with subject `p` and gene `q`.  The combination is a union,
`%fork` style.  

Since this structure is only logically infinite, traversing its
infinitude lazily (and thus not ending up in an infinite loop) is
the responsibility of the traversing algorithm.  A responsibility
which is not papered over - various users do it different ways.
Thus, the strict, stupid approach actually affords more control.

Finally, we arrive at `%core`.  Really the only interesting kind
of `++type`.

In Nock, how do you build a function - a classic closure or
lambda?  (Speaking of which, is the lambda calculus - is it one
of them gay things?  Cause we keep trying to figure that out.
Not meaning anything bad by it mind you.) 

Anyone trying to construct a function in Nock will produce
something more or like this noun, which we call a `%gate`:

	gate
	[formula payload]
	[formula [sample context]]

The `formula` is the Nock formula which executes the function.
The subject for this formula is the _entire gate_, obviously
because we want the function to be able to recurse.

As for the payload, `sample` is the argument (which may obviously
have tuple structure), and `context` is any other data and/or
code the function may need to do its job.

This structure may seem quite general, but it's easy to improve.
First, we can abstract over the structure of the payload, for
which a `[sample context]` cell is just one design pattern.
Second, a formula is a general case of:

	core
	[battery payload]

where a `battery` is just a tuple tree of formulas.  Again, each
of these formulas takes as its subject the entire core.

In short, in Hoon the "ultimate" lambda appears as a humble
special case of something very like a plain old country _object_.
(A very important special case, to be sure!)  

Not that the formulas in a Hoon battery should be confused for
classical OO methods.  They are more like computed attributes.
An actual method is a computed attribute that produces a gate.
Obviously, this is a very common but not exclusive pattern.

The formulas (or `%foot`s) in a battery are referenced, of course,
by name.  One sneaky little trick is that that name (a `@tas`)
can be _empty_.  As a `@tas` you enter the null term as `%$`, but
as a naked symbol it is just `$` - or `buc`.

We are now ready to explain this ungodly structure.  Let's see
the whole type system again:

	  |%
	  ++  coil  $:  p=?(%gold %iron %lead %zinc)
	                q=type
	                r=[p=?(~ ^) q=(map ,@tas foot)]
	            ==
	  ++  foot  $%  [%ash p=gene]
	                [%elm p=gene]
	                [%oak ~]
	                [%yew p=(map ,@tas foot)]
	            ==
	  ++  type  $|  ?(%noun %void)
	            $%  [%atom p=@tas]
	                [%cell p=type q=type]
	                [%core p=type q=coil]
	                [%cube p=* q=type]
	                [%face p=term q=type]
	                [%fork p=type q=type]
	                [%hold p=(list ,[p=type q=gene])]
	            ==
	  --

We notice that most of its complexity is within `%core`.
Actually, you could build a very solid, not at all fancy
proto-Hoon with a much simpler type system:

	  |%
	  ++  type  $|  ?(%noun %void)
	            $%  [%atom p=@tas]
	                [%cell p=type q=type]
	                [%core p=type q=(map @tas gene)]
	                [%cube p=* q=type]
	                [%face p=term q=type]
	                [%fork p=type q=type]
	                [%hold p=(list ,[p=type q=gene])]
	            ==
	  --

But then we'd miss out on these weird "woods" and "metals."

First, the metals.  Metals define variance.  Every core is
assigned a metal, initially `%gold`.  From `%gold` to any other
metal is a relaxation.  From any other metal to `%lead` is a
relaxation.  Gold turns into anything, anything turns into lead.

If you know these terms, this table may explain the metals:

	%gold   invariant
	%zinc   covariant
	%iron   contravariant
	%lead   bivariant

These are different points on the well-known tradeoff between
variance and opacity.  

In a %gold core, the whole payload is both readable and writable,
but the core is not compatible with another unless the payload
type nests in both directions.  Hence, invariance.

In a %lead core, the entire payload is opaque, so any core with
the same battery type is compatible.  Hence, bivariance.

In an %iron core (normal gates, ie functions/lambdas, are either 
%gold or %iron), the sample is write-only.  Hence, a core with a 
less restrictive sample can be substituted - contravariance.  The
payload is opaque.

In a %zinc core, the sample is read-only and the payload is
opaque - covariance.  We haven't used this much but someone
smarter might find something it's good for.

In any case, we call metal work with variance _geometric
polymorphism_.  And then, we have our woods, `%ash` and `%elm`.
Feet of `%ash` are also called `%dry`, and `%elm` `%wet`.
Wet work is _generic polymorphism_, and does much the same job
that typeclasses do in some fancy language from Europe.

Consider this peculiar process of invoking a core.  When we
create a core, we simply start with a payload subject and wrap a
battery in it.  But we very quickly lose interest in invoking
formulas on the subject we started with.

Rather, to do interesting things, we change the payload.  For
instance, when calling a function, we replace the dummy or
default sample that we produced the gate with, with our argument.

But since we may have arbitrary type on the argument, and this
may differ from the sample type, we really can't avoid the fact
that we're _changing the type_ of this core.  There are two ways
to deal with this.

One is the %ash way.  In %ash feet, when we infer into the foot,
we simply reset the payload type to the type the foot was
compiled with.  Effectively, our case for the substitution is the
case that our payload is a subtype of this original type - we are
disguising our modified payload as a case of the sample.

Here is a simple example of the difference between %ash and %elm.
%ash, then %elm:

  	~doznec/try=> (|=([a=* b=*] [b a]) -<- %foo)
  	[7.303.014 170.141.184.500.621.432.791.952.199.169.123.287.040]
  	~doznec/try=> (|*([a=* b=*] [b a]) -<- %foo)
	[%foo ~2013.10.2..05.27.01..f5b8]

In the first case (`%ash`), we lose the type of the arguments.
In the second (`%elm`), we infer right through the function.

How does this work?  Its stupid might surprise you.

In %elm feet, we ask: suppose we compiled the foot with the type
in the argument, not in the sample?  Or more generally, with the
changed payload?  We didn't, of course.  We compiled it with the
sample.

But, if we were to treat it as if it had been compiled with the
argument, would we get the wrong result?  Well, one simple test
is to _compile it again with the argument type_.  Then, we can
simply test the two formulas (statically, of course) for
equality.  The actual algorithm, in `++mung`, is a little more
complicated than this (consider, for instance, branches that
would not be taken in the specialized version) but not much.

Essentially, with generic polymorphism, we're treating the foot
as a macro and compiling through it.  This allows us to build
things like container types without turning everything back into
`%noun`.

And, we're done!  If you understand all this, you understand the
Hoon type system.  Or rather, of course, "type system."  

If you didn't know nothing about no actual _types_ before you
started reading - you sure don't know nothing now.   For those
still innocent of genuine type theory, and genuine desire for
learning, I quite sincerely recommend Professor Pierce's very
excellent and comprehensive treatise.  I was honestly going to
read this, and everyone says it's very good.

A good exercise is designing a function `++nest` which, given two
types `a` and `b`, can decide conservatively whether every noun
in `b` is also in `a`.  No peeking!
