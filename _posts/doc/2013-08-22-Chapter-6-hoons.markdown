---
layout: post
category: doc
title: Chapter 5 &#58; 29 ways of looking at a hoon
---

Since writing the last chapter (this here is a _living document_,
darn it), we've bowed to the inevitable and changed the name of
the Hoon AST node type from the vague and pretentious `gene`, to
the bold country-flavored `hoon`.  

This can and will be deployed broadly - it is ridiculous to speak
of "Hoon runes" when you could just say "hoons."  Somehow the
same word means the symbol, the source code, the expression, etc.

Let's start off with two big hoons.  The first is the definition
of `++hoon` (in /~ship/arvo=/hoon/hoon):

  |%                                                      ::
  ++  axis  ,@                                            ::
  ++  beer  $|(@ [~ p=hoon])                              ::
  ++  foot  $%  [%ash p=hoon]                             ::
                [%elm p=hoon]                             ::
                [%oak ~]                                  ::
                [%yew p=(map term foot)]                  ::
            ==                                            ::
  ++  gens  (list hoon)                                   ::
  ++  gent  (list ,[p=hoon q=hoon])                       ::
  ++  genu  (list ,[p=term q=hoon])                       ::
  ++  goon  (list (unit hoon))                            ::
  ++  hoon  $&  [p=hoon q=hoon]                           ::
            $%                                            ::
              [%$ p=axis]                                 ::
            ::                                            ::
              [%bcbr p=hoon q=hoon]                       ::
              [%bccb p=hoon]                              ::
              [%bccl p=gens]                              ::
              [%bccn p=hoon q=gens]                       ::
              [%bccm p=hoon]                              ::
              [%bckt p=hoon]                              ::
              [%bcpm p=hoon q=hoon]                       ::
              [%bctr p=hoon]                              ::
              [%bcts p=bozo]                              ::
              [%bcwt p=hoon q=gens]                       ::
            ::                                            ::
              [%brbr p=hoon q=hoon]                       ::
              [%brcb p=hoon q=(map term foot)]            ::
              [%brcl p=hoon q=(map term foot)]            ::
              [%brcn p=(map term foot)]                   ::
              [%brdt p=hoon]                              ::
              [%brkt p=hoon q=(map term foot)]            ::
              [%brhp p=hoon]                              ::
              [%brls p=hoon q=hoon]                       ::
              [%brtr p=hoon q=hoon]                       ::
              [%brts p=hoon q=hoon]                       ::
              [%brwt p=hoon]                              ::
            ::                                            ::
              [%clcb p=hoon q=hoon]                       ::
              [%clcn p=gens]                              ::
              [%clfs p=hoon]                              ::
              [%clkt p=hoon q=hoon r=hoon s=hoon]         ::
              [%clhp p=hoon q=hoon]                       ::
              [%clls p=hoon q=hoon r=hoon]                ::
              [%clsg p=gens]                              ::
              [%cltr p=gens]                              ::
              [%clzp p=gens]                              ::
            ::                                            ::
              [%cnbc p=term]                              ::
              [%cncb p=wing q=gent]                       ::
              [%cncl p=hoon q=hoon]                       ::
              [%cndt p=hoon q=hoon]                       ::
              [%cnhp p=hoon q=gens]                       ::
              [%cnhx p=wing]                              ::
              [%cntr p=wing q=hoon r=gent]                ::
              [%cnkt p=hoon q=hoon r=hoon s=hoon]         ::
              [%cnls p=hoon q=hoon r=hoon]                ::
              [%cnsg p=wing q=hoon r=hoon]                ::
              [%cnts p=wing q=gent]                       ::
            ::                                            ::
              [%dtkt p=hoon]                              ::
              [%dtls p=hoon]                              ::
              [%dtpt p=term q=@]                          ::
              [%dtsg p=term q=*]                          ::
              [%dttr p=hoon q=hoon]                       ::
              [%dtts p=hoon q=hoon]                       ::
              [%dtwt p=hoon]                              ::
            ::                                            ::
              [%hxgl p=gens]                              ::
              [%hxgr p=gens]                              ::
            ::                                            ::
              [%ktbr p=hoon]                              ::
              [%ktls p=hoon q=hoon]                       ::
              [%ktdt p=hoon q=hoon]                       ::
              [%kthp p=hoon q=hoon]                       ::
              [%ktpm p=hoon]                              ::
              [%ktsg p=hoon]                              ::
              [%ktts p=term q=hoon]                       ::
              [%ktwt p=hoon]                              ::
            ::                                            ::
              [%sgbr p=hoon q=hoon]                       ::
              [%sgcl p=[p=@ q=@] q=hoon]                  ::
              [%sgcn p=chop q=hoon r=genu s=hoon]         ::
              [%sgfs p=chop q=hoon]                       ::
              [%sggl p=$|(term [p=term q=hoon]) q=hoon]   ::
              [%sggr p=$|(term [p=term q=hoon]) q=hoon]   ::
              [%sgbc p=term q=hoon]                       ::
              [%sghx p=term q=hoon]                       ::
              [%sgkt p=hoon q=hoon]                       ::
              [%sgls p=@ q=hoon]                          ::
              [%sgpm p=@ud q=hoon r=hoon]                 ::
              [%sgts p=hoon q=hoon]                       ::
              [%sgwt p=@ud q=hoon r=hoon s=hoon]          ::
              [%sgzp p=hoon q=hoon]                       ::
            ::                                            ::
              [%smcb p=hoon q=hoon]                       ::
              [%smcl p=hoon q=gens]                       ::
              [%smcm p=hoon q=gens]                       ::
              [%smcn p=gens]                              ::
              [%smdt p=hoon q=gens]                       ::
              [%smdq p=(list beer)]                       ::
              [%smgl p=hoon q=hoon r=hoon]                ::
              [%smgr p=hoon q=hoon r=hoon]                ::
              [%smkt p=hoon q=hoon]                       ::
              [%smhp p=hoon q=hoon]                       ::
              [%smhx p=(list beer)]                       ::
              [%smls p=hoon q=hoon]                       ::
              [%smpm p=hoon q=gens]                       ::
              [%smsg p=hoon q=gens]                       ::
              [%smsm p=hoon q=hoon]                       ::
              [%smtr p=hoon q=hoon]                       ::
              [%smts p=hoon q=hoon]                       ::
              [%smwt p=hoon q=hoon]                       ::
            ::                                            ::
              [%tsbr p=hoon q=hoon]                       ::
              [%tscl p=gent q=hoon]                       ::
              [%tsdt p=hoon q=hoon r=hoon]                ::
              [%tsgl p=hoon q=hoon]                       ::
              [%tsgr p=hoon q=hoon]                       ::
              [%tskt p=hoon q=hoon r=hoon s=hoon]         ::
              [%tsls p=hoon q=hoon]                       ::
              [%tshp p=hoon q=hoon]                       ::
              [%tssg p=gens]                              ::
            ::                                            ::
              [%wtbr p=gens]                              ::
              [%wthp p=hoon q=gent]                       ::
              [%wtcl p=hoon q=hoon r=hoon]                ::
              [%wtcn p=hoon q=hoon]                       ::
              [%wtdt p=hoon q=hoon r=hoon]                ::
              [%wtkt p=hoon q=hoon r=hoon]                ::
              [%wtgl p=hoon q=hoon]                       ::
              [%wtgr p=hoon q=hoon]                       ::
              [%wtls p=hoon q=hoon r=gent]                ::
              [%wtpm p=gens]                              ::
              [%wtpt p=hoon q=hoon r=hoon]                ::
              [%wtsg p=hoon q=hoon r=hoon]                ::
              [%wtts p=hoon q=hoon]                       ::
              [%wtzp p=hoon]                              ::
            ::                                            ::
              [%zpcb p=spot q=hoon]                       ::
              [%zpcm p=hoon q=hoon]                       ::
              [%zpcn ~]                                   ::
              [%zpfs p=hoon]                              ::
              [%zpgr p=hoon]                              ::
              [%zpsm p=hoon q=hoon]                       ::
              [%zpts p=hoon]                              ::
              [%zpzp ~]                                   ::
            ==                                            ::
  ++  limb  $|(term $%([& p=axis] [| p=@ud q=term]))      ::
  ++  pint  ,[p=[p=@ q=@] q=[p=@ q=@]]                    ::
  ++  spot  ,[p=path q=pint]                              ::
  ++  term  ,@tas                                         ::
  ++  wing  (list limb)                                   ::
  --

Wha?  Of course, we learned to use this subset of Hoon in the
last chapter.  We know that `++hoon` is a function which
normalizes an untyped noun into a hoon.  (And Australians,
really, you can stop laughing now.)

But perhaps we missed the `$&` hoon.   This tells us that hoons
use the same "autocons" trick as Nock formulas.  

A hoon is always a cell.  If the head of that hoon is also a
cell, the whole hoon is a cell [p=hoon q=hoon], and its product
against any subject is the equivalent of Lisp `(cons p q)`.  But
there is no `cons` in Hoon - you just say `[p q]`.

The next simplest kind of hoon is exactly the same as the Nock
formula.  `%$` is the empty formula and an `axis` is just `@`,
so `[%$ p=axis]` just means the cell `[0 p]`, as in Nock `/p`.

This reminds us that Hoon is just Nock in a fancy suit.  In Nock,
we write a Nock formula that specifies a function of the subject.
In Hoon we write a hoon that, with the semantic assistance of the
subject type, is converted into a Nock formula.  Much as C is
just a fancy macro assembler for machine code, Hoon is just a
fancy macro assembler for Nock.

The basic function in this assembler is `++mint`, which maps a 
cell `[type hoon]` to a cell `[type nock]`.  (If you look at the
code for `++mint`, you'll see it also takes a second type `gol`,
but this goal type is only for more accurate error location.)

But in the compiler core, `++ut`, there are only three arms
where we `?-` on this giant clan of hoons.  These are `++mint`;
`++play`, an abbreviated mint that only does type inference;
and `++mung`, which implements generic polymorphism.  Let's look
at `++play`, because it's the simplest.

  |%
  ++  play  
    ~/  %play
    =>  .(vet |)
    |=  gen=hoon
    ?-  gen
      [^ *]      (cell $(gen p.gen) $(gen q.gen))
      [%brcl *]  (heir(sut $(gen p.gen)) q.gen)
      [%brcn *]  (core sut %gold sut [[%0 0] p.gen])
      [%cnts *]  =+  lar=(foil (seek %read p.gen))
                 =+  mew=(swab q.gen)
                 =+  rag=q.q.lar
                 %-  fire
                 |-  ^-  (list ,[p=type q=foot])
                 ?~  mew
                   rag
                 $(mew t.mew, rag q:(tock p.i.mew ^$(gen q.i.mew) rag))
      [%dtkt *]  %noun
      [%dtls *]  [%atom %$]
      [%dtpt *]  ?:(=(%f p.gen) ?>((lte q.gen 1) bean) [%atom p.gen])
      [%dtsg *]  [%cube q.gen ?:(.?(q.gen) %noun [%atom p.gen])]
      [%dttr *]  %noun
      [%dtts *]  bean
      [%dtwt *]  bean
      [%ktbr *]  (wrap(sut $(gen p.gen)) %iron)
      [%ktdt *]  $(gen (snap(sut $(gen p.gen)) q.gen))
      [%ktls *]  $(gen p.gen)
      [%ktpm *]  (wrap(sut $(gen p.gen)) %zinc)
      [%ktsg *]  $(gen p.gen)
      [%ktts *]  (face p.gen $(gen q.gen))
      [%ktwt *]  (wrap(sut $(gen p.gen)) %lead)
      [%sggr *]  $(gen q.gen)
      [%tsgr *]  $(gen q.gen, sut $(gen p.gen))
      [%wtcl *]  =+  [fex=(gain p.gen) wux=(lose p.gen)]
                 %+  fork
                   ?:(=(%void fex) %void $(sut fex, gen q.gen))
                 ?:(=(%void wux) %void $(sut wux, gen r.gen))
      [%wtcn *]  bean
      [%zpcb *]  ~!((show %o p.gen) $(gen q.gen))  
      [%zpcm *]  (play p.gen)
      [%zpcn ~]  p:seed
      [%zpfs *]  %void
      [%zpsm *]  (cell $(gen p.gen) $(gen q.gen))
      [%zpts *]  %noun
      [%zpzp ~]  %void
      *          =+  doz=~(open ap gen) 
                 ?:  =(doz gen)
                   ~!  (show [%c 'hoon'] [%q gen])
                   ~|(%play-open !!)
                 $(gen doz)
    ==
  --

The first thing we notice about this code, which almost fits on a
page but doesn't quite, is that there are only 28 runes we
evaluate directly.  The rest go into `++open` in `++ut`, where
they are expanded as macros.

Which makes no difference at all if you're trying to learn Hoon
from the top down, tutorial style.  We'll do that later.  But if
you're trying to understand it from the bottom up... that means,
there are only 28 runes we have to understand.  And honestly,
most of them are pretty minor.

Let's start with a simple but important one:

    %wtcl ?: "wutcol" [%wtcl p=hoon q=hoon r=hoon]

This is exactly the same as the C operator and has the same
semantics.  It's also the same as Nock operator `6`.

So how do we infer type through it?  Since both `q` and `r` are
applied to the same subject as the original hoon, you might think 
the code would be 
 
      [%wtcl *]  [%fork $(gen q.gen) $(gen r.gen)]

But in fact, it's 

      [%wtcl *]  =+  [fex=(gain p.gen) wux=(lose p.gen)]
                 %+  fork
                   ?:(=(%void fex) %void $(sut fex, gen q.gen))
                 ?:(=(%void wux) %void $(sut wux, gen r.gen))

What's going on here is that we analyze `p.gen`, the test in the
if, to refine the subject type.  On either branch, we've learned
something about the subject, so we should have a new type -
created by `++gain` for the yes branch, `++lose` for the no.
Then, the product type is the union of both branches.

The power of `+gain` and `++lose` shouldn't be overstated.  It
can analyze boolean logic (but is not a SAT solver) and can use
the results of `?%` (which is normally used through the macro
`?=`, testing if a noun matches a type.  

Moreover, this is not enforced in `++play`, but when the type
system figures out that a path isn't taken, that's an error -
you'll see `mint-vain`, meaning that your code is in vain.

When you see the `?-` pattern-matching macro, it simply resolves
down to a series of `?:` tests.  Eventually it should probably be
pulled into `++ut`, to be more efficient than linear search.

`wutcol` is actually the second most important hoon.  Let's do the
most important and complex:
 
    %cnts %= "centis" [%cnts p=wing q=gent]

`centis` could be described as "query with changes."  First let's
look at the data structures it uses:

    ++  axis  ,@
    ++  gent  (list ,[p=hoon q=hoon])
    ++  limb  $|(term $%([& p=axis] [| p=@ud q=term]))
    ++  term  ,@tas
    ++  wing  (list limb)

`p` is the query, `q` the changes.  Let's forget about `q` and
just think about `p` for right now.

What is a `wing`?  It's a way to reference either a part of a
typed noun (a fragment, as in Nock `/`; or `leg`), or a computed
expression (`arm`).  Each `limb` in the wing can be either a tree
address (like `+3`, meaning Nock's `/3`) or a name (like `foo`).
Syntactically, these run outward from right to left, so

    +3.foo.bar.+7.moo

means "+3 in foo in bar in +7 in moo" - ie, the opposite of the 
"object.attribute" order you're used to from Earth languages.

Obviously, `+3` is always a leg.  Whereas `moo` can resolve
either when it finds a `%face`, or when it finds a `%core`.
When searching in a type, the search stops at a `%face` that
conflicts with the term we're looking for, but continues into 
the payload of a `%core` that doesn't have an arm that matches
the term we're looking for.  Moreover, a term limb has a
numeric parameter that lets us skip the first `p` matches; so,
`moo` means the first `moo` we find, but `^^moo` means "skip
over the first 2 `moo`s we find and accept the third."

This explains mysterious usages like `^^$`.  `$` is just a syntax
for the empty symbol - `$` compares to `%$` as `moo` to %moo.
The one is a limb, the other a constant.  In practice, `$` is
used for "the nameless function or loop we're inside."  

So `^$` gives us the functional equivalent of multi-level break.
Indeed, if there is one practical problem with most functional
languages, it's the inability to refer to anonymous functions
that you're inside.

Then we have the changes.  Actually, Hoon in Hoon is relatively
old code, and done right it would be 

    ++  gent  (list ,[p=wing q=hoon])

But a wing is one case of a hoon, so we just parse it as a
general hoon and reduce it by brute force.

This isn't rocket science: we produce the query described in `p`,
with each of the wings in `q` replaced by the corresponding hoon
(computed against the current subject).  So, for example, when
calling a classic function, we produce a gate or "lambda" of the
form 

    [formula [sample context]]

and evaluate the formula (typically named `$`) with the sample, 
(`+6`), replaced with your actual argument.  Hence, the code 
for this, supposing you have your gate in `moo`, and your
argument is `bar`, would look like

    %=  $.moo
      +6  bar
    ==

and `centis` in this case means "replace the sample with the
argument, and execute the function body."


