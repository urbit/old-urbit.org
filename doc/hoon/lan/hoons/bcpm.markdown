---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 7
title: bucpam
---

#[bucpam, `$&`](#bcpm)

##Syntax

`$&`, `bucpam`, is a tile rune that produces a `%bush`, `[%bush p=tile q=tile]`, a tile in which there are two kinds of nouns: cells whose head is a cell `(tile p)` and cells whose head is an atom `(tile q)`. Its default value is the value of `q`.

###Form

`p` is a tile
`q` is a tile

####Tall

    $&  p
        q
    ==

####Wide

    $&(p q)

####Irregular
None

###Reduction
None

###Examples

We don't have to look very far to find a bush - ++tile is one, as is ++twig and ++nock. The rune is $& (bucpam). See ++tile above - p is [p=tile q=tile], q is the $%.

##Semantics

`$&` is a tile.

###Definition

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%bush p=tile q=tile]                     ::  pair/tag  
              ==
###Expansion
None

###Notes
What's the use of a bush? Often in a variety of data structures we have something like autocons, in which forming a cell of two instances has an obvious default semantics.

Sure, we could attach these semantics to an atom, and just use a %kelp. In twigs, tiles, or nock formulas, we could have an explicit cons stem of some sort. But it would be a bulky and annoying pain in the butt as compared to autocons.
See the discussion of tiles in chapter 9.
