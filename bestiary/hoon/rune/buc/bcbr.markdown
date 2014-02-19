---
layout: subpage
category: buc
title: bucbar
---

`$|`, `bucbar`, is a tile hoon that produces a `%reed`,  

    [%reed p=tile q=tile]

a `%reed` is a tile whose icon contains two kinds of nouns: atoms of tile `p` and cells of tile `q`.

###Definition###

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%reed p=tile q=tile]                     ::  atom/cell
              ==

###Regular form (tall)###

    $|  p
        q
    ==

###Regular form (wide)###

    $|(p q)

###Notes###

See the discussion of tiles in chapter 9.
