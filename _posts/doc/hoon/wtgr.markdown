---
layout: post
category: doc
title: `?>`, `wutgar`, `%wtgr`
---

###Synopsis###

`?>`, `wutgar`, `[%wtgr p=twig q=twig]` is a synthetic hoon that
asserts `p` is true before evaluating `q`, crashing if `p` is false.

###Definition###

    ++  twig  
      $%  [%wtgr p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtgr *]
      ==

###Notes###

