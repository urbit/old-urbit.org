---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 22
title: barwut
---

#[barwut, `|?`, %brwt](#brwt)

##Syntax

`|?`, `barwut`, `[%brwt q=twig]` is a synthetic hoon that produces a
dry `%lead` trap.

###Form

`p` is a twig

####Tall

    |?  p

####Wide

    |?(p)

####Irregular
None

###Reduction

    |?  p

reduces to

    ^?  |. p

reduces to [`|.` link]

    ^?
    |%  ++  $
        p
    --

###Examples


##Semantics

`%brwt` is a twig.

###Definition###

    ++  twig  
      $%  [%brwt p=twig]
      ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brwt *]
        [%ktwt %brdt p.gen]
      ==

###Notes###

See the bestiary of core patterns in chapter 11.
