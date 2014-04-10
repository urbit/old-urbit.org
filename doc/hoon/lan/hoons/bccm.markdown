---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 3
title: buccom
---

#[buccom, `$,`, %bccm](#bccm)

##Syntax

`$,`, `buccom`, `[%bccm p=tile]` is a synthetic rune that produces a
normalizing gate (clam) for `p`. 

###Form

`p` is a tile.

####Tall

    $,  p

####Wide
None

####Irregular

    ,p

###Reduction

    $,  p

reduces to

    ~(clam al p)

###Examples

++  cord  ,@t                                           ::  text atom (UTF-8)

In ++cord, `,` creates a gate that validates atoms of the odor @t. 

##Semantics

`%bccm` is a twig.

###Definition

    ++  twig  
      $%  [%bccm p=tile]
      ==

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%bccm *]
        ~(clam al p.gen)
      ==

###Notes

The clam reduction generates a gate which accepts an arbitrary noun and produces a member of the tile's icon. Ie, clam generates a validator function for the icon. Perhaps you can see how this might be useful, at least, on the Internets.

Moreover, a clam for any tile, if passed a member of the type, is guaranteed to produce its sample. If passed a noun outside the type, it will normalize and/or default. It won't crash - except for the custom cases of %herb and %weed.

See the discussion of tiles in chapter 9.
