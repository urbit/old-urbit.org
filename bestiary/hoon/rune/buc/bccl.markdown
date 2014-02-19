---
layout: subpage
category: buc
title: buccol
---

`$:`, `buccol`, is a tile hoon that declares a tile autocons,`[p=tile q=tile]`.

Tiles autocons, just like twigs - a cell of tiles is a tile of a cell. But we shouldn't skip the differences too lightly.

A cell of twigs is also a twig of a cell. But in the cell of twigs, the subject of either leg is the original subject. Whereas when applying a tile in a whip or clam, the subject is split in half for equally obvious reasons.

(Otherwise, how would `(,[@ @] [4 5])` be `[4 5]`? Clearly, this should be the same as `[(,@ 4) (,@ 5)]`. Clearly, it should not be the same as `[(,@ [4 5]) (,@ [4 5])]` - which would produce merely `[0 0]`.)

###Definition###

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair

###Regular form (tall)###

    $:  p
        q
    ==

###Regular form (wide)###

    $:(p q)

###Irregular form###

    [p q]

###Notes###

See the discussion of tiles in chapter 9.
