---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 25
title: colfas
---



`:/`, `colfas`, `[%clfs p=twig]` is a synthetic hoon that
produces `[%$ [%$ p ~] ~]`, ie, `[0 [0 p 0] 0]`.

###Definition###

    ++  twig  
      $%  [%clfs p=twig]
      ==

###Regular form (tall)###

    :/  p

###Regular form (wide)###

    :/(p)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clfs *]
        [%clfs *]  =+(zoy=[%dtzz %ta %$] [%clsg [zoy [%clsg [zoy p.gen] ~]] ~])
      ==

###Notes###

In practice, `:/` is only used in the bowels of string interpolation.
