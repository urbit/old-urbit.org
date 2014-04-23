---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 95
title: wutlus
---



#[wutlus, `?+`, %wtls](#wtls)

##Syntax

`?+`, `wutlus`, `[%wtls p=wing q=twig r=tine]` is a synthetic
hoon that selects a case in `q` for the actual type of `p`.

###Form

####Tall

    Kingside:

    ?+  p
      q
      p.i.r      q.i.r
      p.i.t.r    q.i.t.r
      p.i.t.t.r  q.i.t.t.r
    ==

Queenside:

    ?+    p
      q
        p.i.r      
      q.i.r
        p.i.t.r    
      q.i.t.r
        p.i.t.t.r  
      q.i.t.t.r
    ==

####Wide

    ?+(p p.i.r q.i.r, p.i.t.r q.i.t.r, p.i.t.t.r q.i.t.t.r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtls p=wing q=twig r=tine]
      ==
    ++  tine  (list ,[p=tile q=twig])

###Expansion

    ++  open
      ^-  twig
      ?+    gen
          [%wtls *]
        [%wthp p.gen (weld r.gen `_r.gen`[[[%axil %noun] q.gen] ~])]
      ==

##Notes

`%wtls` is best understood by its expansion, which is a simple
use of `%wtts`.  Note that because `%wtts` does proper inference,
a spurious, duplicate or missing case will be detected.
