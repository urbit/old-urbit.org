---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 35
title: cenhep
---

#[cenhep, `%-`, %cnhp](#cnhp)

##Syntax

`%-`, `cenhep`, `[%cnhp p=twig q=tusk]` is a synthetic rune that
slams the gate `p` with `[%cltr q]`

###Form
`p` is a twig
`q` is a tusk, which is a list of twigs.

####Tall
  
    %-  p
    q


####Wide

    %-(p q)

####Irregular

    (p q)

###Reduction

     %-  p
     q

reduces to

    ?~  q
      =>  p  $
    %:  p
    q

reduces to

    ?~  q
      =>  p  $
    %*  $  p
      +<  q
    ==
    
###Examples

##Semantics

%cnhp is a twig

###Definition

    ++  twig  
      $%  [%cnhp p=twig q=tusk]
      ==
    
    ++  tusk  (list twig)
    
###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%cnhp *]
        ?~(q.gen [%tsgr p.gen [%cnzy %$]] [%cncl p.gen [%cltr q.gen]])
      ==
##Notes

