---
layout: post
category: doc
title: `^-`, `kethep`, `%kthp`
---

###Synopsis###

`^-`, `kethep`, `[%kthp p=tile q=twig]` is a synthetic hoon that
mates the type of tile `p` to the formula of twig `q`, minted 
on the same subject - so long as the type of `q` nests within the
type of `p`.

###Definition###

    ++  twig  
      $%  [%kthp p=tile q=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [ZZ *]
      ==

###Notes###

