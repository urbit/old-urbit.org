---
layout: post
category: doc
title: `?:`, `wutcol`, `%wtcl`
---

###Synopsis###

`?:`, `wutcol`, `[%wtcl p=twig q=twig r=twig]` is a natural hoon that
evaluates `q` if `p` evaluates to true, otherwise `r` is
evaluated. This is Hoon's "if".

###Definition###

    ++  twig  
      $%  [%wtcl p=twig q=twig r=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtcl *]
      ==

###Notes###

