---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 15
title: bardot
---

#[bardot, `|.`, %brdt](#brdt)


##Syntax

`|.`, `bardot`, `[%brdt p=twig]` is a synthetic hoon that produces
a dry `%gold` trap (cores, link). `|.` takes a twig.

###Form

`p` is a twig.
  
###Tall

    |.  p 

###Wide

    |.(p)

###Irregular
None

###Reduction

    |.  p

reduces to 

    |%  ++  $
        p
    --

###Examples

    ++  reel                                                ::  right fold
      ~/  %reel
      |*  [a=(list) b=_=|([p=* q=*] |.(q))]
      |-  ^+  q.b
      ?@  a
        q.b
      (b i.a $(a t.a))

In ++reel, `|.` is used to specify the body of the expression to right fold over a given list.

##Semantics

`%brdt` is a twig.

###Definition

    ++  twig  
      $%  [%brdt p=twig]
      ==

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%brdt *]  
        [%brcn (~(put by *(map term foot)) %$ [%ash p.gen])]
      ==

##Notes
