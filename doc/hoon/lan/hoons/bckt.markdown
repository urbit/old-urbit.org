---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 5
title: bucket
---



`$^`, `bucket`, is a tile hoon that declares an `%herb`:

    [%herb p=twig]

An `%herb` is just a gate, accepting a sample of * and normalizing it as you choose. If you use a twig as a tile, it's treated as an herb.

###Definition###

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
            $%  [%herb p=twig]                            ::  gate     
            ==

###Regular form (tall)###

    $^  p
        q
    ==

###Regular form (wide)###

    $^(p q)

###Notes###

See the discussion of tiles in chapter 9.
