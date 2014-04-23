---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 91
title: wuthep
---



#[wuthep, `?-`, %wthp](#wthp)

##Syntax

`?-`, `wuthep`, `[%wthp p=wing q=tine]` is a synthetic hoon that
selects a case in `q` for the actual type of `p`.

###Form

####Tall

    Kingside:

    ?-  p
      p.i.q      q.i.q
      p.i.t.q    q.i.t.q
      p.i.t.t.q  q.i.t.t.q
    ==

Queenside:

    ?-    p
        p.i.q      
      q.i.q
        p.i.t.q    
      q.i.t.q
        p.i.t.t.q  
      q.i.t.t.q
    ==

####Wide

    ?-(p p.i.q q.i.q, p.i.t.q q.i.t.q, p.i.t.t.q q.i.t.t.q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wthp p=wing q=tine]
      ==
    ++  tine  (list ,[p=tile q=twig])


###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wthp *]
        |-
        ?@  q.gen
          [%zpfs [%cnzz p.gen]]
        :^    %wtcl
            [%wtts p.i.q.gen p.gen]
          q.i.q.gen
        $(q.gen t.q.gen)
      ==

##Notes

`%wthp` is best understood by its expansion, which is a simple
use of `%wtts`.  Note that because `%wtts` does proper inference,
a spurious, duplicate or missing case will be detected.
