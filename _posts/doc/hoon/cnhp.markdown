---
layout: post
category: doc
title: `%-`, `cenhep`, `%cnhp`
---

###Synopsis###

`%-`, `cenhep`, `[%cnhp p=twig q=tusk]` is a synthetic hoon that
activates the unnamed arm of core `p` with the context `q`.

###Definition###

    ++  twig  
      $%  [%cnhp p=twig q=tusk]
      ==

###Regular form (tall)###

###Regular form (wide)###
%-(p i.q i.t.q)
###Irregular form###
(p i.q i.t.q)
###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnhp *]
      ==

###Notes###

