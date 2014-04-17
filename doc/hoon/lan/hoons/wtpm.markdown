---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 97
title: wutpam
---



#[wutpam %wtpm](#wtpm)

##Syntax

`?&`, `wutpam`, `[%wtpm p=tusk]` is a synthetic hoon that
computes the "and" of the loobeans in `p`.

###Form

####Tall

    ?&  i.p
        i.t.p
        i.t.t.p
    ==

####Wide

    ?&(i.p i.t.p i.t.t.p)

####Irregular

    &(i.p i.t.p i.t.t.p)

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtpm p=tusk]
      ==
    ++  tusk  (list twig)

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wtpm *]
        |-
        ?~(p.gen [%dtzz %f 0] [%wtcl i.p.gen $(p.gen t.p.gen) [%dtzz %f 1]])
      ==

##Notes

Short-circuiting and type inference work as expected in `?&`.