---
layout: post
category: doc
title: `$*`, `buctar`, `%bctr`
---

###Synopsis###

`$*`, `buctar`, `[%bctr p=tile]` is a synthetic hoon that
produces the bunt (default value) for `p` as a compile-time constant.

###Definition###

    ++  twig  
      $%  [%bctr p=tile]
      ==

###Regular form (tall)###
$*  p
###Regular form (wide)###
None.
###Irregular form###
*p
###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bctr *]
        [%ktsg ~(bunt al p.gen)]
      ==

###Notes###

