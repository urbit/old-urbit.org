---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 8
title: bucpat
---

#bucpat `$@` %bcpt

##Syntax

`$@`, `bucpat`, `[%bcpt p=wing q=tile]` is a (just barely) natural 
hoon that whips (normalizes) wing `p` into tile `q`.

###Form
`p` is a wing
`q` is a tile

####Tall

    $@  p
    q

####Wide

    $@(p q)

####Irregular

    p@q

###Reduction
None

###Examples

##Semantics

`%bcpt` is a twig

###Definition

    ++  twig  
      $%  [%bcpt p=wing q=tile]
      ==
    ++  wing  (list limb)
    ++  limb  $|(term $%([%& p=axis] [%| p=@ud q=term]))

###Compilation
 
    ++  mint
      ?-    gen
          [%bcpt *]  
        $(gen (~(whip al q.gen) p:(seep %read p.gen)))
    ==

###Notes

Not only is whip the same thing as clam, it's what clam uses internally. All clam does is make a gate whose sample, an arbitrary noun +< (glus, .6), it whips into its tile.
See the description of `++whip` in Chapter 9.
