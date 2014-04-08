---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 37
title: cenlus
---


#[cenlus, `%+`, %cnls](#cnls)

##Syntax

`%+`, `cenlus`, `[%cnls p=twig q=twig r=twig]` is a synthetic hoon 
that slams gate `p` with `[%cntr q r]`.

###Form

####Tall

    %+  p
      q
    r


####Wide

    %+(p q r)

####Irregular
None

###Reduction

    %+  p
      q
    r

reduces to

    %-  p
      [q r]

reduces to

    ?~  [q r]
      =>  p  $
    %:  p
    [q r]

reduces to

    ?~  [q r]
      =>  p  $
    %*  $  p
      +<  [q r]
    ==

###Examples

##Semantics

`%cnls` is a twig

###Definition

    ++  twig  
      $%  [%cnls p=twig q=twig r=twig]
      ==

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnls *]
        [%cnhp p.gen q.gen r.gen ~]
      ==

##Notes
