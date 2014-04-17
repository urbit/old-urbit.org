At present, the memo cache is cleared on every event.
---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 67
title: sigls
---



#[siglus, `~+`, %sgls](#sgls)

##Syntax

`~+`, `siglus`, `[%sgls p=twig]` is a synthetic hoon that
hints to the interpreter to memoize (cache) the computation 
of `p`.

###Form

####Tall
  
    ~+  p

####Wide

    ~+(p)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%sgls p=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%sgls *]  [%sggr [%memo %dtzz %$ p.gen] q.gen]
      ==

##Notes

At present, the memo cache is cleared on every event.