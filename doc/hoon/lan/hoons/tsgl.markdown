---
layout: subpage
axis: doc-hoon
categories: tis rune
sort: 79
title: tisgal
---



#[tisgal, `=<`, %tsgl](#tsgl)

##Syntax

`=<`, `tisgal`, `[%tsgl p=twig q=twig]` is a synthetic hoon that
uses the product of `q` as the subject of `p`.

###Form

####Tall

    =<  p
    q

####Wide

    =<(p q)

####Irregular

    p:q

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%tsgl p=twig q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%tsgl *]  [%tsgr q.gen p.gen]
      ==

##Notes

None
