---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 38
title: censig
---


#[censig, `%~`, %cnsg](#cnsg)

##Syntax

`%~`, `censig`, `[%cnsg p=wing q=twig r=twig]` is a synthetic
hoon that pulls `p` from the tray `q` with its sample set to `r`.

###Form
`p` is a wing
`q` is a twig
`r` is a twig

####Tall

    %~  p
      q
    r

####Wide

    %~(p q r)

####Irregular

    ~(p q r)

###Reduction

    %~  p
      q
    r

reduces to

    %*  p  q
    +<  r
    ==
  
###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%cnsg p=twig]
      ==

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnsg *]
        [%cntr p.gen q.gen [[[[%& 6] ~] r.gen] ~]]
      ==
##Notes
