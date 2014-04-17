---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 0
title: bucbar
rune: $|
tile: bcbr
---

#bucbar `$|` %bcbr

##Syntax

`$|`, `bucbar`, is a tile rune that takes `++tile` `p` and `q` and produces a `%reed`,  

    [%reed p=tile q=tile]

a `%reed` is a tile whose icon contains two kinds of nouns: atoms of tile `p` and cells of tile `q`.

###Form
`p` is a tile
`q` is a tile

####Tall

    $|  p
        q
    ==

####Wide

    $|(p q)

####Irregular
None

###Reduction
None

###Examples

    ++  list  |*  a=_,*                                     ::  null-terminated list
              $|(~ [i=a t=(list a)])                        ::

In ++list, $| specifies that every element in a noun that can be cast to a ++list is either the atom ~ or the cell [i=a t=(list a)]. 

##Semantics

###Definition

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%reed p=tile q=tile]                     ::  atom/cell
              ==

###Expansion

##Notes

See the discussion of tiles in chapter 9.
