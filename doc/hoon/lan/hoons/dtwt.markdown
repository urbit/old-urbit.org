---
layout: subpage
axis: doc-hoon
categories: dot rune
sort: 47
title: dotwut
---

#[dotwut,`.?`, %dtwt](#dtwt)

##Syntax

`.?`, `dotwut`, `[%dtwt p=twig]` is a natural hoon that
applies nock `3` to a noun: if the noun is a cell, it returns the loobean `& (true)`; if the noun is an atom, it returns the loobean `| (false)`.

###Form
`p` is a twig

####Tall

    .?  p

####Wide

    .?(p)

####Irregular
None

###Reduction
None

###Examples 

##Semantics

###Definition

    ++  twig  
      $%  [%dtwt p=twig]
      ==  

###Expansion

    ++  mint
        ?-  gen
          [%dtwt *]  
        [(nice bean) [%3 q:$(gen p.gen, gol %noun)]]
        ==  

##Notes

