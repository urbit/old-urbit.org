---
layout: post
category: doc
title: `$,`, `buccom`, `%bccm`
---

###Synopsis###

`$,`, `buccom`, `[%bccm p=tile]` is a synthetic hoon that produces a
validator core (clam) for `p`, which, when activated, will either
produce the value given to it if valid, or the default value for `p`
otherwise.

###Definition###

    ++  twig  
      $%  [%bccm p=tile]
      ==

###Regular form (tall)###
$,  p
###Regular form (wide)###
None.
###Irregular form###
,p
###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bccm *]
        ~(clam al p.gen)
      ==

###Notes###

