---
layout: subpage
category: buc
title: buccom
---

`$,`, `buccom`, `[%bccm p=tile]` is a synthetic hoon that produces a
normalizing gate (clam) for `p`. 

###Definition###

    ++  twig  
      $%  [%bccm p=tile]
      ==

###Regular form (tall)###

    $,  p

###Regular form (wide)###

    None.

###Irregular form###

    ,p

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bccm *]
        ~(clam al p.gen)
      ==

###Notes###

See the discussion of tiles in chapter 9.
