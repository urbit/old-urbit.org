---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 10
title: buctis
---


#[buctis, `$=`](#bcts)


##Syntax

`$=`, `bucts`, is a tile hoon that produces a `%bark`:

    [%bark p=term q=tile] 

A %bark wraps a name around a tile. `a=*` parses as `[%bark %a %noun]`.

###Form

`p` is a term
`q` is a tile

####Tall

    $=  p
    q


####Wide
None

####Irregular
None

###Reduction
None

###Examples

##Semantics

`%bark` is a tile.

###Definition

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%bark p=term q=tile]                     ::  name
              ==

##Notes

See the discussion of tiles in chapter 9.
