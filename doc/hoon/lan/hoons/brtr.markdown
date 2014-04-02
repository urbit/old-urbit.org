---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 20
title: bartar
---



`|*`, `bartar`, `[%brtr p=tile q=twig]` is a synthetic hoon that
produces a vulcanized wet gate with arm `q`, sample `[%bctr p]`.

###Definition###

    ++  twig  
      $%  [%brtr p=tile q=twig]
      ==

###Regular form (tall)###

    |*  p
    q

###Regular form (wide)###

    |*(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brtr *]
        [%brfs p.gen (~(put by *(map term foot)) %$ [%elm q.gen])]
      ==

###Notes###

See the bestiary of cores in Chapter 11.  See also the discussion
of vulcanization.
