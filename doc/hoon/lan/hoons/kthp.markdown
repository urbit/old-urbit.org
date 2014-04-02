---
layout: subpage
axis: doc-hoon
categories: ket rune
sort: 54
title: kethep
---



`^-`, `kethep`, `[%kthp p=tile q=twig]` is a synthetic hoon that
casts `q` to `~(bunt al p)`, ie, the icon of `p`.

###Definition###

    ++  twig  
      $%  [%kthp p=tile q=twig]
      ==

###Regular form (tall)###

    ^-  p
    q

###Regular form (wide)###

    ^-(p q)

###Irregular form###

    `p`q

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%kthp *]  [%ktls ~(bunt al p.gen) q.gen]
      ==

###Notes###

See the discussion of tiles in chapter 9.
