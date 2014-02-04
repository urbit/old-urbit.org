---
layout: post
category: doc
title: `|^`, `barket`, `%brkt`
---

###Synopsis###

`|^`, `barket`, `[%brkt p=twig q=(map term foot)]` is a synthetic hoon
that creates a core with the unnamed arm `p` and named arms `q`, then
activates the unnamed arm.

###Definition###

    ++  twig  
      $%  [%brkt p=twig q=(map term foot)]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brkt *]
        [%tsgr [%brcn (~(put by q.gen) %$ [%ash p.gen])] [%cnzy %$]]
      ==

###Notes###

