---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 32
title: cencab
---


#[cencab, `%_`, %cncb](#cncb)

##Syntax

`%_`, `cencab`, `[%cncb p=wing q=tram]` is a synthetic hoon that
evaluates `p` with the changes specified in `q`, then casts the
product back to `p`.

###Form

`p` is a wing
`q` is a tram, a list of wing twig pairs 
`p.i.q` is a wing
`q.i.q` is a twig
`p.i.t.q` is a wing 
`q.i.t.q` is a twig

####Tall

    %_  p
      p.i.q  q.i.q
      p.i.t.q  q.i.t.q
    ==

####Wide

    %_(p p.i.q q.i.q, p.i.t.q q.i.t.q)

####Irregular
None

###Reduction
 
    %_  p
      p.i.q  q.i.q
      p.i.t.q  q.i.t.q
    ==
    
reduces to

    ^+  p
    %=  p
       p.i.q  q.i.q
      p.i.t.q  q.i.t.q
    ==

###Examples

##Semantics

`%cncb` is a twig.

###Definition

    ++  twig  
      $%  [%cncb p=wing q=tram]
      ==
    ++  tram  (list ,[p=wing q=twig]) 

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%cncb *]
        [%ktls [%cnzz p.gen] %cnts p.gen q.gen]
      ==

##Notes

