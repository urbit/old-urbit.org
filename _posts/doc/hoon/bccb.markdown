---
layout: post
category: doc
title: `$_`, `buccab`, `%bccb`
---

###Synopsis###

`$_`, `buccab`, `[%bccb p=tile]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%bccb p=tile]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bccb *]
        ~(bunt al p.gen)
      ==

###Notes###

