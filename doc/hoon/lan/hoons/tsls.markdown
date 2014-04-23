---
layout: subpage
axis: doc-hoon
categories: tis rune
sort: 83
title: tislus
---



#[tislus, `=+`, %tsls](#tsls)

##Syntax

`=+`, `tislus`, `[%tsls p=twig q=twig]` is a synthetic hoon that
pushes `p` on the subject and sends it to `q`.

###Form

####Tall

     =+  p
    q

####Wide

    =+(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%tsls p=twig q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%tsls *]  [%tsgr [p.gen [~ 1]] q.gen]
      ==

##Notes

`%tsls` is the Hoon equivalent of Nock `8`.  It is a synthetic
hoon, though, because we recognize the Nock pattern and optimize
it in code generation.
