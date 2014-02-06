---
layout: post
category: doc
title: `=~`, `tissig`, `%tssg`
---

###Synopsis###

`=~`, `tissig`, `[%tssg p=tusk]` is a synthetic hoon that
composes a list of twigs.

###Definition###

    ++  twig  
      $%  [%tssg p=tusk]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

Kingside:

      =~  
    i.p
    i.t.p
    i.t.t.p
      ==
 
Queenside:

    =~  i.p
        i.t.p
        i.t.t.p
    ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tssg *]
      ==

###Notes###

`=~` is usually used for formatting high-level reefs without
losing base indentation.
