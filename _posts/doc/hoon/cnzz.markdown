---
layout: post
category: doc
title: `cenzaz`, `%cnzz`
---

###Synopsis###

`cenzaz`, `[%cnzz p=wing]` is a synthetic hoon that pulls
wing `p` from the subject.

###Definition###

    ++  twig  
      $%  [%cnzz p=wing]
      ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%cnzz *]  [%cnts p.gen ~]
      ==

###Notes###

