---
layout: post
category: doc
title: `#>`, `haxgar`, `%hxgr`
---

###Synopsis###

`#>`, `haxgar`, `[%hxgr p=tusk]` is a synthetic hoon that invokes the
pretty-printer on `p`, producing a tape (byte string).

###Definition###

    ++  twig  
      $%  [%hxgr p=tusk]
      ==
  ++  tusk  (list twig) 

###Regular form (tall)###
None.
###Regular form (wide)###
None.
###Irregular form###
<i.p i.t.p ...>
###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%hxgr *]
      ==

###Notes###


