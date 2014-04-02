---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 90
title: wutgar
---



`?>`, `wutgar`, `[%wtgr p=twig q=twig]` is a synthetic hoon that
produces `q`, asserting that `p` is no (`|`, 1).

###Definition###

    ++  twig  
      $%  [%wtgr p=twig]
      ==

###Regular form (tall)###

    ?>  p
    q

###Regular form (wide)###

    ?>(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%wtgr *]   [%wtcl p.gen q.gen [%zpzp ~]]
      ==
