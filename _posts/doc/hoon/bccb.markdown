---
layout: post
category: doc
title: `$_`, `buccab`, `%bccb`
---

###Synopsis###

`$_`, `buccab`, `[%bccb p=tile]` is a synthetic hoon that
produces the bunt (default value) for `p`.

###Definition###

    ++  twig  
      $%  [%bccb p=tile]
      ==

###Regular form (tall)###

    $_  p

###Regular form (wide)###

    $_(p)

###Irregular form###

    _p

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bccb *]
        ~(bunt al p.gen)
      ==

###Notes###

See the discussion of tiles in chapter 9.
