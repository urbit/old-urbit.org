---
layout: post
category: doc
title: Urbit Is Easy&#58; Chapter VII (Hoon Bites Back)
---

[**Prev**: Hoon Goes Wild](urbit-is-easy-ch6.html)

*"I've only been in love with a beer bottle and a mirror."*
**(Sid Vicious)**

##Syntax##

Is Hoon actually an improvement on Nock?  The jury holds out.
Here is our old decrement function, from the Nock battery:

    [ 8
      [1 0]
      [ 8
        [ 1
          [ 6
            [5 [4 0 6] [0 30]]
            [0 6]
            [9 2 [0 2] [4 0 6] [0 7]]
          ]
        ]
        [9 2 0 1]
      ]
    ]

This clearly it is not for the little boys and girls.  But wait -
is Hoon any less formidable?  The Hoon equivalent:

          |=  a=@
          =+  b=@
          |-  ?:  =(a +(b))
                b
              $(b +(b))

Whaa?  We can also write the exact same decrement as:

    |=(a=@ =+(b=@ |-(?:(=(a +(b)) b $(b +(b))))))

for instance:
  
    ~zod/try=> (|=(a=@ =+(b=@ |-(?:(=(a +(b)) b $(b +(b)))))) 42)
    41

or even more cryptically, 

    ~zod/try=> %.(42 |=(a=@ =+(b=@ |-(?:(=(a +(b)) b $(b +(b)))))))
    41

And I showed this to my daughter, who ran away in tears.  Dear
reader, I hope you're not tempted to do the same.

Hoon actually is easy!  It's much easier than Nock.  Nock really
isn't that hard itself, unless you want to do something useful
with it.  But to learn Hoon, you just have to accept that it's
really quite orthogonal to any or all of those *20th-century*
languages you knew already.  Even the functional ones, mostly.
If anything, this knowledge makes it harder to learn Hoon.

Our mutual hope is that by the time you do know Hoon, you will
simply be able to *see* a twig like

          |=  a=@
          =+  b=@
          |-  ?:  =(a +(b))
                b
              $(b +(b))

and, far from merely able to follow this code, *actually observe
in your mind's eye the function itself* - not unlike Keanu with
kung fu.  You will simply look at this strange collection of
squiggles and *see decrement*.  Trust me, man - it's heavy.

(Our feeling is that the use of reserved words in most languages,
by instead activating the verbal lobes, disrupts this sense of
directly, or at least visually, perceiving the program itself.
If you object that this sounds too much like Science, Science
implies testing hypotheses whereas we generally just wing it.)

Think of learning Hoon as learning to program all over again.  If
nothing else, it's a sort of eccentric adventure sport.  Or even
a mystery - can an language be esoteric, yet useful?  Click here
to find out more.

###Glyphs###

It's actually worse than that - learning Hoon is learning to
_read_ all over again.  Again, Hoon is a reserved-word-free
language - any text in the program is part of the program.

We use so many of these ASCII glyphs that we like to be able
to read them out loud.  A language is meant to be _said_.  The
squiggles have conventional names, sort of, some of them easy to
say, others not so much.  So we've renamed them:
 
    ace  space      gal  <          per  )
    bar  |          gar  >          sel  [
    bas  \          hax  #          sem  ;
    buc  $          hep  -          ser  ]
    cab  _          kel  {          sig  ~
    cen  %          ker  }          soq  '
    col  :          ket  ^          tar  *
    com  ,          lus  +          tec  `
    doq  "          pam  &          tis  =
    dot  .          pat  @          wut  ?
    fas  /          pel  (          zap  !

You just have to memorize these names.  Sorry.  We accept
that they are vile, barbaric and loathsome.

###Runes###

But is this at least enough symbols?  Alas, nowhere near.
ASCII's glyph supply is not the greatest, but we can make all the
squiggles we need by forming digraphs, or _runes_.  For example:
`bartis`, ie, `|=`.  

To pronounce a rune, concatenate the glyph names, stressing the
first syllable and softening the second vowel into a "schwa."
Hence, to say `~.`, say "sigdot."  To say `|=`, say "bartis."
Which has an inevitable tendency to turn into "barts" - a sin
to be encouraged.  In any language actually spoken by actual
humans, benign indolence soon rounds off any rough edges.

Let's look at that decrement gate again:

          |=  a=@
          =+  b=@
          |-  ?:  =(a +(b))
                b
              $(b +(b))

If we had to read this twig, omitting the spaces (which only a
real purist would pronounce), we'd say: "bartis a is pat barlus b
is pat barhep wutcol tispel a luspel b perper b bucpel b luspel b
perper."  The authorities would then arrive, and drag us out in a
big net. Definitely don't do this at the airport.

Hoon has almost 90 digraphic runes.  Worse, "Hoon runes" are
inevitably shortened to "hoons" - a ridiculous non-English word
due originally to Wallace Stevens, which also has the unique
property of reducing Australians to convulsions.

None of this should scare you.  First, this is not a lot compared
to, say, Chinese.  Second, they are easier than you'd expect to
organize in your head, because the choice of glyph is not random.  
Third, no one lives in Australia and nobody cares.

The second glyph in a hoon means little or nothing, but the first
defines a rough semantic category.   These categories are:

    |  bar    core construction
    $  buc    tiles and tiling
    %  cen    invocations
    :  col    tuples
    .  dot    nock operators
    ^  ket    type conversions
    ;  sem    miscellaneous macros
    ~  sig    hints
    =  tis    compositions
    ?  wut    conditionals, booleans, tests
    !  zap    special operations

##Twigs and tiles##

Earlier, we said a block of Hoon parses into a `twig`.  While
this remains true, it is true only for certain values of "true."
Unfortunately, Hoon is more complicated than that.

One of the nice features of Lisp is that Lisp is both homoiconic
(can be represented in its own data structures) and homogeneous
(every complex node in the tree is the same thing, ie, a Lisp
function).  Hoon is homoiconic but not homogeneous.  (It also has
its `++homo` gate - whose function, naturally, is to homogenize.)

When parsed, a Hoon file becomes a strange hodgepodge of `++twig`
and `++tile` nouns.  (Pro tip: when we write `++tile`, we point
to a twig preceded by the search string "lus lus ace ace tile" -
to use the vile jargon we just defined above.)

We cannot even say that twigs never contain twigs - or that tiles
never contain twigs.  Except that both are ways of producing a
Nock formula, the semantics and purpose of a twig and a tile are 
more or less orthogonal.  Just to warn ya.

In general, when you see a hoon in `$`, like `$:`, you are
looking at a tile.  Unless it's `$,` `$_`, `$@`, `$*` or `$!` -
that is, `buccom`, `buccab`, `bucpat`, `buctar` or `buczap` -
in which case you are looking at a twig wrapped around a tile.
This will one day make sense and even more if you're drunk.

###The noble twig###

We have already defined the noble twig - in chapter 5.  But
let's simply *reprint* that text:

When we parse a Hoon expression, file, etc, we produce what we
call a `twig`, which (if you know the CS jargon) is an AST.  A
twig is a noun that's converted into a Nock formula, with
the assistance of a type which describes the subject of the
formula:

    [subject-type twig] => formula

But actually this isn't quite right, because Hoon does something
called "type inference."  When we have a type that describes the
subject for the formula we're trying to generate, as we generate
that formula we want to also generate a type for the product of
that formula on that subject.  So our compiler computes:

    [subject-type twig] => [product-type formula]

As long as `subject-type` is a correct description of some
subject, you can take any twig and compile it against
`subject-type`, producing a `formula` such that `*(subject
formula)` is a product correctly described by `product-type`.

Actually, this works well enough that in Hoon there is no direct
syntax for defining or declaring a type.  There is only a syntax
for constructing twigs.  Types are exclusively formed by inference.

Is this a macro system?  Yes - it's a macro system without
user-defined macros.  (This may be a future feature.)

###The savage tile###

Perhaps the most confusing aspect of Hoon is the difference
between a type (the data structure formed by type inference) and
a tile.  In normal languages these concepts are seldom distinct.
In Hoon they are very distinct.

A tile is actually a proto-twig.  Precisely, a tile is the input
to a suite of functions which convert it, in various styles, to 
produce a twig.  This twig is then used to construct or handle
well-typed data given the Hoon inference algorithm (not at all
an intelligent algorithm, at least as type inference goes).

So a tile, while it looks like a type, goes through multiple
layers of indirection before it generates a type.  It has to be
turned into a twig, which has to be applied to a subject type,
producing both a product type and a formula.

##Irregular and regular syntax##

Like most natural languages, Hoon has both regular and irregular
forms - for both twigs and tiles. 

[...]
The regular 

Wing reduction:


