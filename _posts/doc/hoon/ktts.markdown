---
layout: post
category: doc
title: `^=`, `kettis`, `%ktts`
---

###Synopsis###

`^=`, `kettis`, `[%ktts p=togo q=twig]` is a natural hoon that
creates a `%face` with the name `p` and value `q`.
###Definition###

    ++  twig  
      $%  [%ktts p=togo q=twig]
      ==

###Regular form (tall)###
^=  p
q
###Regular form (wide)###
^=(p q)
###Irregular form###
p=q
###Compilation###
    
    ++  mint
      ?-  gen
        [%ktts *]  
      ==

###Notes###

