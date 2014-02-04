---
layout: post
category: doc
title: `$!`, `buczap`, `%bczp`
---

###Synopsis###

`$!`, `buczap`, `[%bczp p=base]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%bczp p=base]
      ==
    ++  base  ?([%atom p=odor] %noun %cell %bean %null)

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bczp *]
        [%bccb %axil p.gen]
      ==

###Notes###
