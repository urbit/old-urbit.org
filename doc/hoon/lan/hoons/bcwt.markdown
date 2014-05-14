---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 11
title: bucwut
---



#bucwut `$?` %bcwt

##Syntax

`$?`, `bucwut`, is a tile hoon that produces a `%fern`:

    [%fern p=[i=tile t=(list tile)]]

A non-empty list of cases; its icon is naturally a `%fork`. The programmer is
responsible for ensuring that the cases are actually orthogonal (unlike with
the structured forks, `%bush`, `%kelp` and `%reed`). A good general practice
is to use ferns only with leaves.

###Form
`p` is a tile
`q` is a tile

####Tall

    $?  p
        q
    ==

####Wide
None

####Irregular

    ?(p q)

###Reduction
None

###Examples

    ++  base  ?([%atom p=odor] %noun %cell %bean %null)     ::  axils, @ * ^ ? ~

In ++base, `?` (the irregular form of $?) specifies a list of orthoganal casesfor the %axil tile.

##Semantics

`%fern` is a ++tile.

###Definition

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%fern p=[i=tile t=(list tile)]]          ::  plain selection
              ==

###Expansion
None

##Notes
See the discussion of tiles in chapter 9.
