---
layout: post
category: doc
title: Urban Reference Manual&#58; Chapter XI (Odds, Ends, Quirks)
---

**(Carlyle)**

[**Prev**: Type Inference](http://www.urbit.org/2013/11/19/urbit-is-easy-ch10.html)

##A bestiary of cores##

The Hoon core is just not a gadget you're familiar with from
your Earth programming career.  A core is not a lambda, a
closure, a library, an object, etc.  Or perhaps we should say:
when we translate any of these into Hoon, we get a core.  So we
cannot translate "core" into any one of them.

But clearly in practice there are lots of different kinds of
practical cores.  For example, we have already met Hoon's
equivalent of the lambda, the `gate`.  Every gate is a core, but
not every core is a gate.  And the gate is by no means the only
subspecies of core.  So describing cores becomes a big part of
the Hoonist's alien vocabulary.  

Let's review briefly what we know about cores.  A core is a noun
of the form

    [battery payload]

where the `battery` is a tree of formulas, each invoked with the
entire core as the subject, and the payload is any noun.

There are three main ways we can talk about a core: its variance
model, `%gold`, `%iron`, `%zinc` or `%lead`, `%gold` by default;
the inference approach of each of its feet, `%ash` or `%elm`,
informally `dry` or `wet`, `dry` or `ash` by default; and its
payload pattern, which makes it a `gate`, `reef`, `book`,
`trap` or `tray`.  There are also several ways of using cores:
you can `pull`, `kick`, `slam` or `slug` them.

For an explanation of variance and inference, see chapter 10.
Here, let's go over the payload patterns.  Unlike most concepts
in Hoon, these are strictly informal conventions.  A core is a
core - there is no code in `hoon.hoon` that deals with a `gate`
per se.  Nonetheless, these definitions are precise and
unambiguous.

###Book###

A core whose payload is either another core, or a constant
(`%cube`), is a `book`.

###Reef###

A book whose payload is either another reef, or a cube, is a
`reef`.  Effectively, a reef is an entirely constant core.

###Trap###

Any core with one arm named `%$` is a trap.  "It's a trap!"

###Gate###

A gate is a trap whose payload has the form `[sample context]`,
`sample` being dynamic data and `context` being anything.

###Tray###

A tray is any core whose payload has the form `[sample
context]`.

###Categories###

Every reef is a book.  Every gate is a trap.  Every gate is a
tray.

###Using cores###

As we already know, a name or axis (which of course applies to
all nouns, not just cores) is a `limb`.  A list of limbs is a
`wing`.  

To access a wing or limb in a core is to `pull` it.  When we
write `a.b.x`, we pull the wing `a.b` (ie, `a` within `b`) from
`x`.  If the result is defined as a subtree of `x`, the wing is a
`leg`.  If it is computed from `x` by a formula, it's an `arm`.

To pull `%$` - the empty name - on a core is to `kick` it.  To
replace the sample with `a` in gate `g` then kick the gate, is
to `slam g with a`.  

(The archaic usage of "call" for `slam` is discouraged, but
common.  Please at least do not use "call" to mean `pull`.)

Slamming is a special case of `slug`, which pulls any limb on a
tray after replacing the sample.  To replace the sample with `a`
on tray `t`, then pull `m`, is to `slug t to m with a`.

Thus when we write

    (~(get by foo) bar)

`++by` produces a tray.  We slug `by` to `get` with `foo`,
producing a gate that searches the map `foo`, and slam this gate
with `bar`.  This is the most normal possible thing in the
universe, though it must seem strange to you now.

[**Prev**: Type Inference](http://www.urbit.org/2013/11/19/urbit-is-easy-ch10.html)
