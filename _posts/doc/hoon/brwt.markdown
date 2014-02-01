---
layout: post
category: doc
title: `|?`, `barwut`, `%brwt`
---

###Synopsis###

`|?`, `barwut`, `[%brwt q=twig]` is a synthetic hoon that creates a
bivariant gate (i.e. a %lead core with a single unnamed arm) with the
bunt of tile `p` in its context.

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
