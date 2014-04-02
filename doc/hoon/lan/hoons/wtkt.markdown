---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 93
title: wutket
---



`?^`, `wutket`, `[%wtkt p=wing q=twig r=twig]` is a synthetic hoon
that evaluates `r` if `p` is equal to the bunt for its tile, otherwise
`q` is evaluated.
###Definition###

    ++  twig  
      $%  [%wtkt p=wing q=twig r=twig]
      ==

###Regular form (tall)###

    ?^  p
      q
    r

###Regular form (wide)###

    ?^(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%wtkt *]   [%wtcl [%wtts [%axil %atom %$] p.gen] r.gen q.gen]
      ==
