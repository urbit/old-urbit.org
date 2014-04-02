---
layout: subpage
category: hax
title: haxgal
---

`#<`, `haxgal`, `[%hxgl p=tusk]` is a synthetic hoon that
slams the assumed gate `noah` on `[%zpgr %cntr p]`.

###Definition###

    ++  twig  
      $%  [%hxgl p=tusk]
      ==
    ++  tusk  (list twig) 

###Irregular form###

    >i.p i.t.p i.t.t.p<

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%hxgl *]  [%cnhp [%cnzy %noah] [%zpgr [%cltr p.gen]] ~]
      ==

###Notes###

`noah` is one of four "Biblical" names that the Hoon compiler,
violating its usual principles, generates automatically.

Of course the compiler cannot control what `noah` produces when
pulled from the subject, but the convention is that it should be
a gate that accepts a `vase` (type-value cell) and produces a 
`tank` (pretty-printer input).

