---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 4
title: buccen
---

#buccen `$%` %bccn

##Syntax

`$%`, `buccen`, is a tile hoon that produces a %kelp. `$%` takes a list of lines, which are labeleed cases, closed by `==`.

###Form

`p`,`q` and `r` are ++line, which look like `[%foo *]`, where `*` is any noun. 
####Tall

    $%  p
        q
        q
    ==

####Wide
None

####Irregular
None

###Reduction
None

###Examples

++  foot  $%  [%ash p=twig]                             ::  dry, geometric
              [%elm p=twig]                             ::  wet, generic
              [%oak ~]                                  ::  XX not used
              [%yew p=(map term foot)]                  ::  XX not used
          ==     

In ++foot, `$%` creates a %kelp, which is a list of possible cases. That is, a ++foot can be either %ash, %elm, %oak or %yew.

##Semantics

`$%` is a tile.

###Definition###


    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%kelp p=[i=line t=(list line)]]          ::  tag selection
              ==

    ++  line  ,[p=[%leaf p=odor q=@] q=tile]                ::  kelp case labels

###Notes###

A kelp is the workhorse of tiles - it provides the most common data structure in any language, the discriminated union.

In Hoon, the head (which must be a leaf) is called the stem. The tail (which can be anything) is the bulb. Cases of a kelp are known inevitably as fronds.

See the discussion of tiles in chapter 9.
