---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 89
title: wutgal
---



#[wutgal %wtgl](#wtgl)

##Syntax

`?<`, `wutgal`, `[%wtgl p=twig q=twig]` is a synthetic hoon that
produces `q`, asserting that `p` is no (`|`, 1).

###Form

####Tall

    ?<  p
        q

####Wide

    ?<(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtgl p=twig]
      ==


###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%wtgl *]   [%wtcl p.gen [%zpzp ~] q.gen]
      ==

##Notes

None
