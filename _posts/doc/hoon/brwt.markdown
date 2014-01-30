---
layout: post
category: doc
title: `|?`, `barwut`, `%brwt`
---

###Synopsis###

`|?`, `barwut`, `[%brwt q=twig]` is a synthetic hoon that
produces 

###Definition###

    ++  twig  
      $%  [%brwt p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brwt *]
        [%ktwt %brdt p.gen]
      ==

###Notes###
