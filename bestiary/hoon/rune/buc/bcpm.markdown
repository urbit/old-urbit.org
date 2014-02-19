---
layout: subpage
category: buc
title: bucpam
---

`$&`, `bucpam`, is a tile hoon that produces a `%bush`, `[%bush p=tile q=tile]`, a tile in which there are two kinds of nouns: cells whose head is a cell `(tile p)` and cells whose head is an atom `(tile q)`. Its default value is the value of `q`.

###Definition###

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%bush p=tile q=tile]                     ::  pair/tag  
              ==

###Regular form (tall)###

    $&  p
        q
    ==

###Regular form (wide)###

    $&(p q)

###Notes###

See the discussion of tiles in chapter 9.
