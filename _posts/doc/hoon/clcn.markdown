---
layout: post
category: doc
title: `:%`, `colcen`, `%clcn`
---

###Synopsis###

`:%`, `colcen`, `[%clcn p=tusk]` is a synthetic hoon that
accepts a list of twigs `p` and produces a [[p ~] ~] cell.

###Definition###

    ++  twig  
      $%  [%clcn p=twig]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###
%[1 2 3 ...]
###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clcn *]
      ==

###Notes###

