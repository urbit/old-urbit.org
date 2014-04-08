---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 39
title: centar
---


#[centar, `%*`, %cntr](#cntr)

##Syntax

`%*`, `centar`, `[%cntr p=wing q=twig r=tram]` is a synthetic rune that pull the wing `p` from a tray `q` with changes `r`.

###Form

`p` is a ++wing

++  wing  (list limb)                                   ::  part of subject

`q` is a twig. Should be a tray.

`r` is a tram

    ++  tram  (list ,[p=wing q=twig])                       ::

####Tall

    %*  p  q
    p.i.r  q.i.r
    p.i.t.r  q.i.t.r
    ==

####Wide

    %*(p q p.i.r q.i.r, p.i.t.r q.i.t.r)

####Irregular
None

###Reduction

    %*  wing
    'twig'
    tram 

reduces to

    =+  q
    %=  (weld p `wing`[[~ 2] ~])
    (turn r |=([p=wing q=twig] [p =>(+ q)]))

###Examples

##Semantics

%cntr is a twig.

###Definition

    ++  twig  
      $%  [%cntr p=wing q=twig r=tram]
      ==



###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%cntr *]
        :+  %tsls
          q.gen
        :+  %cnts
          (weld p.gen `wing`[[~ 2] ~])
        (turn r.gen |=([p=wing q=twig] [p [%tsgr [~ 3] q]]))
      ==

###Notes

