---
layout: subpage
axis: doc-hoon
categories: dot rune
sort: 49
title: dotzaz
---



#[dotzaz, %dtzz](#dtzz)

`dotzaz`, `[%dtzz p=term q=*]` is a natural hoon that produces an
cubed noun constant of value `q` and odor `p`, if `q` is an atom.

###Form

####Tall

None

####Wide

None

####Irregular
See chapter 6 for constant forms.





###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%dtts p=twig q=twig]
      ==

###Expansion

    ++  play
      ?-  gen
        [%dtzz *]
      [%cube q.gen ?:(.?(q.gen) %noun [%atom p.gen])]
      ==
    ++  mint
      ?-  gen
        [%dtzz *]
      [(nice (play gen)) [%1 q.gen]]
      ==

##Notes
