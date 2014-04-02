---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 41
title: cenzey
---



`cenzey`, `[%cnzy p=term]` is a synthetic hoon that pulls limb
`p` from the subject.

###Definition###

    ++  twig  
      $%  [%cnzy p=term]
      ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%cnzy *]  [%cnts [p.gen ~] ~]
      ==

