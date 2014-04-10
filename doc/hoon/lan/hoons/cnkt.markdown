---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 36
title: cenket
---


#[cenket, `%^`, %cnkt](#cnkt)

##Syntax

`%^`, `cenket`, `[%cnkt p=twig q=twig r=twig s=twig]` is a 
synthetic hoon that slams gate `p` with `[%cntr q r s]`.

###Form

`p` `q` `r` and `s` are twigs.

####Tall

    %^    p
        q
      r
    s

####Wide

    %^(p q r s)

####Irregular
None

###Reduction

    %^    p
        q
      r
    s

reduces to

    %-  p
    [q r s]

reduces to

    ?~  [q r s]
      =>  p  $
    %*  $  p
      +<  [q r s]
    ==
    
###Examples

##Semantics

%cnkt is a twig

###Definition

    ++  twig  
      $%  [%cnkt p=twig q=twig r=twig s=twig]
      ==

###Expansion
 
    ++  open
      ^-  twig
      ?-    gen
          [%cnkt *]
        [%cnhp p.gen q.gen r.gen s.gen ~]
      ==

##Notes

