---
layout: post
category: doc
title: `$,`, `buccom`, `%bccm`
---

###Synopsis###

`$,`, `buccom`, `[%bccm p=tile]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%bccm p=tile]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bccm *]
        ~(clam al p.gen)
      ==

###Notes###

