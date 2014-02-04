---
layout: post
category: doc
title: `|?`, `barwut`, `%brwt`
---

###Synopsis###

`|?`, `barwut`, `[%brwt q=twig]` is a synthetic hoon that produces a
dry `%lead` trap.

###Definition###

    ++  twig  
      $%  [%brwt p=twig]
      ==

###Regular form (tall)###

Kingside:

    |?
    p
 
Queenside:

    |?  p

###Regular form (wide)###

    |?(p)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brwt *]
        [%ktwt %brdt p.gen]
      ==

###Notes###

See the bestiary of core patterns in chapter 11.
