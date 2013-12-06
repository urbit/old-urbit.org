---
layout: post
category: doc
title: Urbit is Easy&#58; Chapter V (Hoon Attacks)
---

*"Like all men in Babylon, I have been proconsul; like all, a slave."*  
**(The Lottery in Babylon)**

##Principles of type##

By working through the Nock tutorial, you've actually come closer
than you know to knowing Hoon.  Hoon is actually not much more
than a fancy wrapper around Nock, more or less the way C is a
fancy wrapper around machine code.

For instance, it's easy to imagine how instead of calculating
tree axes by hand, we could actually assign *names* to different
parts of the tree - and those names would stay the same as we
pushed more data on the subject.  It can't hurt to dream, right?

The way we're going to do this is by associating something called
a `type` with the subject.  You may have heard of types before.
Technically, Hoon is a statically typed language, which just
means that the type is a data structure the compiler has when it
turns your Hoon into Nock; it's not in your program as it runs.

In some languages, especially functional languages, types are
dangerous scary concepts that involve a lot of math.  For those
who like this sort of thing, that's the sort of thing they like.
Hoon is a functional language, but not one of those scary ones.

A lot of other languages use dynamic types, in which the type of
a value is carried along with the data as you use it.  Even
languages like Lisp, which are nominally typeless, look rather
typed from the Hoon perspective.  For example, a Lisp atom knows
dynamically whether it's a symbol or an integer.  A Hoon atom is
just a Nock atom, which is just a number.  So without a static
type, Hoon doesn't even know how to print an atom properly.

When we parse a Hoon expression, file, etc, we produce what we
call a `hoon`, which (if you know the CS jargon) is an AST.  A
hoon is a noun that's converted into a Nock formula, with
the assistance of a type which describes the subject of the
formula:

    [subject-type hoon] => formula

But actually this isn't quite right, because Hoon does something
called "type inference."  When we have a type that describes the
subject for the formula we're trying to generate, as we generate
that formula we want to also generate a type for the product of
that formula on that subject.  So our compiler computes:

    [subject-type hoon] => [product-type formula]

As long as `subject-type` is a correct description of some
subject, you can take any `hoon` and compile it against
`subject-type`, producing a `formula` such that `*(subject
formula)` is a product correctly described by `product-type`.

Actually, this works well enough that in Hoon there is no direct
syntax for defining or declaring a type.  There is only a syntax
for constructing hoons.  Types are always produced by inference.

##Printing types##

Let's start looking at types with the simplest possible kind of
hoon - an atomic constant, which ignores the subject and its
type, and just produces its own.  Here's everyone's favorite
atomic constant:

    ~waclux-tomwyc/try=> 42
    42

Let's also print its type - in two different ways:

    ~zod/try=> :type; 42
    42
    @ud

    ~zod/try=> -:!>(42)
    [%atom p='ud']

W-what?  Since types are of course static, printing them out
dynamically involves a little bit of black magic at the Hoon
and/or Arvo levels.  This is not the place to explain black
magic - we'll get to that.

But a type, like everything else in Hoon, is a noun.  Suffice it
to say that `-:!>(42)` is just printing this noun, whereas 
`:type; 42` is rendering it intelligently as a string.  In this
case, the rendering is actually Hoon syntax, but in general it's
just a string. 

In this case, looking directly at the type noun is preferable.
But for a core, the type actually contains the entire codebase.
It is no problem to compute with this, but we can't look at it
without scrolling more or less to infinity.

##Atom examples##

Let's look at some more of these atoms:

    ~zod/try=> :type; 0x42
    0x42
    @ux

    ~zod/try=> :type; 'foo'
    'foo'
    @ta

    ~zod/try=> :type; ~2013.12.6
    ~2013.12.6
    @da

    ~zod/try=> :type; .127.0.0.1
    .127.0.0.1
    @if

    ~zod/try=> :type; ~m45
    ~m45
    @dr

    ~zod/try=> :type; `@da`(add ~2013.12.6 ~m45)
    ~2013.12.6..00.45.00
    @da

Okay, we got a little out of control with that last one.  But
the point should be clear.

Note again that there is no dynamic type here.  All these values
are atoms.  Let's cast them all to decimals to see (don't worry
about the cast syntax - we'll cover that later):

    ~zod/try=> `@ud`0x42
    66
    ~zod/try=> `@ud`'foo'
    7.303.014
    ~zod/try=> `@ud`.127.0.0.1
    2.130.706.433
    ~zod/try=> `@ud`~2013.12.6
    170.141.184.500.724.667.905.957.736.036.171.776.000
    ~zod/try=> `@ud`~m45
    49.806.208.999.015.789.363.200

(Yes, 45 minutes is actually quite a large number when your unit
of time is 2^-64 seconds.)

What are these atoms, anyway?  Let's look at the actual type noun
(which, without magic, exists only at compile time):

    ~zod/try=> -:!>(42)
    [%atom p='ud']

`p` is called the `odor` of the atom.  In this case, it's `'ud'`,
ie, unsigned decimal:

    ~zod/try=> `@ud`'ud'
    25.717

That's an unsigned-decimal interpretation of the atom 'ud', which
without a cast is an atom of odor `@ta`:

    ~zod/try=> :type; 'ud'
    'ud'
    @ta

    ~zod/try=> -:!>('ud')
    [%atom p='ta']

In case this is at all mysterious, we note:

    ~zod/try=> (add 'u' (mul 256 'd'))
    25.717

As a general convention, when we represent UTF-8/ASCII text as an
atom, we store it LSB first.  A text atom is generally called a
`cord`; if it is ASCII only, a `span`; if it is ASCII restricted
to the Hoon symbol subset (lowercase with hyphens), a `term`.

##The logic of smell##

What is an odor, anyway?  We've seen that the type of an atom
constant gets an odor which is a function of its syntax.  We've
also seen that when we print atoms on the console, the printer is
(in some black-magic way) aware of the odor, and can print the
atom in roughly the same syntax we originally entered it.

Hoon's type system is generally strong, but odors are weak.  The
parser itself will only generate a `@ta` for an actual ASCII
span, but not every atom is a constant.  For instance, consider
our construction of `'ud'`.  Let's look at the type:

    ~zod/try=> :type; 'u'
    'u'
    @ta

    ~zod/try=> :type; 256 
    256
    @ud

    ~zod/try=> :type; (add 'u' (mul 256 'd'))
    25.717
    @

Not only are we mixing atoms of different odors in our
arithmetic, but the result appears to be... odorless.  It is
odorless.  But we can cast it back:

    ~zod/try=> :type; `@ta`(add 'u' (mul 256 'd'))
    'ud'
    @ta

While Hoon's type system is quite intelligent in some ways, it is
by no means smart enough to evaluate your arithmetic and conclude
that it produces a valid ASCII span.  We can convert any atom to
any other odor of atom, without any sanity checks:

    ~zod/try=> `@dr`25.717
    ~.s0..0000.0000.0000.6475

    ~zod/try=> `@if`25.717
    .0.0.100.117

It so happens that `25.717` is a valid amount of time, and also a
valid IPv4 address.  But obviously not all atoms are meaningful
values of every odor.  We're not going to annoy you by stressing
out the console printer with bad ASCII, but we could.

(And why do we say `25.717` rather than `25,717`?  Are we...
Germans?  No, but we want all atom syntaxes to be URL-safe.)

Odors are a weak type system because the programmer often knows,
at a logical level not at all available to the type system, that
(for example) `(add 'u' (mul 256 'd'))` produces an ASCII span.
We want to keep the programmer from accidentally using a date as
if was text, but we don't want to keep her from intentionally
converting between odors or ascribing odor to the result of an
arbitrary computation.

An odor is exactly what it looks like - an ASCII span.  This span
is a taxonomy which grows more specific to the right.  For
instance, `@t` for UTF-8 text, `@ta` for ASCII text, `@tas` for a
symbol; or `@u` for an unsigned integer, `@ux` for an unsigned
integer formatted as hexadecimal.

The general principle of type enforcement is that atoms change
freely either up or down the taxonomy, but not across.  For
instance, you can treat a `@tas` as a `@t`, as in a strong type
system; but you can also treat a `@t` as a `@tas`, or an `@` as
anything.  However, passing a `@t` to a function that expects an
`@ux` is a type error.

Even the ability to cast a `@ud` to a `@dr` is a syntactic hack;
casts in Hoon do not evade type enforcement.  When you write

    `@dr`25.717

the parser actually produces the equivalent of 

    `@dr``@`25.717

because we can't turn `@ud` directly into `@dr`, but we can turn
`@ud` into `@` and `@` into `@dr`.

##The smell of size##

Besides these prefixes, which indicate the rendering and/or
meaning of atoms, the odor system has another orthogonal
mechanism to restrict the size of atoms.  Like the prefix, this
mechanism is weak - it is not enforced and trivially evaded.

An odor span contains two parts, both optional: a lowercase
prefix and an uppercase suffix.  The suffix, if present, is a
single character A-Z `c` which indicates an atom less than `n`,
where `n` is `(1 + c - 'A')`.  Thus, `@tD` is a single UTF-8
byte; `@tN` is a kilobyte or less of UTF-8.

When enforcing conversions, `@t` has no size information and can
be used as `@tD`; and `@tD`, of course, can be used as `@t`.  But
using `@tN` as `@tD` is an error.  There is no way to generate
the smell of size from a constant without a cast, and of course
arithmetic results have no odor at all.

While the utility of this mechanism is debatable, at worst it
serves as a comment which documents the programmer's intentions.

##Known and unknown odors##

The variety of units and formats which an atom can represent is
essentially infinite.  The set of syntaxes which Hoon can parse
and print is fundamentally limited.

For instance, Hoon has no syntax which means "number of miles."
But within your program, nothing stops you from using the odor
system to distinguish a number of miles from, for instance, a
number of kilometers:

    ~zod/try=> `@udm`25.717
    25.717
    ~zod/try=> `@udk`25.717
    25.717

The printer has no idea what a `@udm` is, but it knows what a
`@ud` and can print accordingly.  Then, if you have a function
which expects a `@udm` and you try to pass it a `@udk`, it will
fail.  The feature seems banal, but spacecraft have been laid low
by less.

##Known odors##

Hoon knows about the following odors, with defined meanings:

    @c              UTF-32 codepoint
    @d              date
      @da           absolute date
      @dr           relative date (ie, timespan)
    @f              yes or no (inverse boolean)
    @n              nil
    @p              phonemic base
    @r              IEEE floating-point
      @rd           double precision  (64 bits)
      @rh           half precision (16 bits)
      @rq           quad precision (128 bits)
      @rs           single precision (32 bits)
    @s              signed integer, sign bit low
      @sb           signed binary
      @sd           signed decimal
      @sv           signed base32
      @sw           signed base64
      @sx           signed hexadecimal
    @t              UTF-8 text (cord)
      @ta           ASCII text (span)
        @tas        ASCII symbol (term)
    @u              unsigned integer
      @ub           unsigned binary
      @ud           unsigned decimal
      @uv           unsigned base32
      @uw           unsigned base64
      @ux           unsigned hexadecimal

Each of these forms has a URL-safe syntax:

###Codepoint, `@c`###

Lorem ipsum.

###Absolute date, `@da`###

Lorem ipsum.

###Relative date, `@dr`###

Lorem ipsum.

###Loobean, `@f`###

Lorem ipsum.

###Nil, `@n`###

Lorem ipsum.

###Phonemic, `@p`###

Lorem ipsum.

###Double, `@rd`###

Lorem ipsum.

###Half, `@rh`###

Lorem ipsum.

###Quad, `@rq`###

Lorem ipsum.

###Single, `@rs`###

Lorem ipsum.

###Signed binary, `@sb`###

Lorem ipsum.

###Signed decimal, `@sd`###

Lorem ipsum.

###Signed base32, `@sv`###

Lorem ipsum.

###Signed base64, `@sw`###

Lorem ipsum.

###Signed hexadecimal, `@sx`###

Lorem ipsum.

###UTF-8 text, `@t` (cord)###

Lorem ipsum.

###ASCII text, `@ta` (span)###

Lorem ipsum.

###Symbol text, `@tas` (term)###

Lorem ipsum.

###Unsigned binary, `@sb`###

Lorem ipsum.

###Unsigned decimal, `@sd`###

Lorem ipsum.

###Unsigned base32, `@sv`###

Lorem ipsum.

###Unsigned base64, `@sw`###

Lorem ipsum.

###Unsigned hexadecimal, `@sx`###

Lorem ipsum.

##Other constant forms##

Lorem ipsum.

