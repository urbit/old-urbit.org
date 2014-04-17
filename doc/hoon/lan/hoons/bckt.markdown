---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 5
title: bucket
---

#bucket `$^` %bckt

##Syntax

`$^`, `bucket`, is a tile hoon that declares an `%herb`:

    [%herb p=twig]

An `%herb` is just a gate, accepting a sample of * and normalizing it as you choose. If you use a twig as a tile, it's treated as an herb.

###Form
`p` is a twig

####Tall

    $^  p
        q
    ==


####Wide

    $^(p q)

####Irregular
None

###Reduction
None

###Examples

##Semantics

`%herb` is a tile

###Definition

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
            $%  [%herb p=twig]                            ::  gate     
            ==


###Expansion
    
##Notes

See the discussion of tiles in chapter 9.
