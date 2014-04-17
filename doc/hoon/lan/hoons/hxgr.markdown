---
layout: subpage
axis: doc-hoon
categories: hax rune
sort: 51
title: haxgar
---



#[haxgar, `#>`, %hxgr](#hxgr)

##Syntax

`#>`, `haxgar`, `[%hxgr p=tusk]`is a synthetic hoon that
slams the assumed gate `cain` on `[%zpgr %cntr p]`.

###Form

####Tall

    ?

####Wide

    ?

####Irregular

    <i.p i.t.p i.t.t.p>

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%hxgr p=tusk]
      ==
    ++  tusk  (list twig) 

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%hxgl *]
      [%cnhp [%cnzy %noah] [%zpgr [%cltr p.gen]] ~]
      ==

##Notes

`cain` is one of four "Biblical" names that the Hoon compiler,
violating its usual principles, generates automatically.

Of course the compiler cannot control what `noah` produces when
pulled from the subject, but the convention is that it should be
a gate that accepts a `vase` (type-value cell) and produces a 
`tape` (list of UTF-8 bytes).