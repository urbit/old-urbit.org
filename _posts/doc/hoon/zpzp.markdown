---
layout: post
category: doc
title: `!!`, `zapzap`, `%zpzp`
---

###Synopsis###

`!!`, `zapzap`, `[%zpzp p=~]` is a natural hoon that
crashes every time.

###Definition###

    ++  twig  
      $%  [%zpzp p=~]
      ==

###Regular form (wide)###

    !!

###Compilation###
    
    ++  mint
      ?-  gen
        [%zpzp *]  [%void [%0 0]]
      ==

###Notes###

Crashing in Hoon is the normal way to respond to an error.
