---
layout: post
category: doc
title: `|_`, `barcab`, `%brcb`
---

###Synopsis###

`|_`, `barcab`, `[%brcb p=tile q=(map term foot)]` is a synthetic
hoon that produces a `%gold` tray with sample `p`, arms `q`.

###Definition###

    ++  twig  
      $%  [%brcb p=tile q=(map term foot)]
      ==

###Regular form (tall)###

Kingside:

    |_  p
    ++  p.n.q
      q.n.q
    --

Queenside:
  
    |_  p  
      ++  p.n.q
        q.n.q
    --

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brcb *]
        [%tsls [%bctr p.gen] [%brcn q.gen]]
      ==

###Notes###

See the bestiary of core patterns in chapter 11.
