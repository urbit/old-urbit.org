---
layout: subpage
axis: doc-hoon
categories: cen twig
sort: 41
title: cenzey
---


#[cenzey, %cnzy](#cnzy)

##Syntax

`cenzey`, `[%cnzy p=term]` is a synthetic internal twig that pulls limb
`p` from the subject.

###Form
None, cenzey is only used internally

####Tall

####Wide

####Irregular

###Reduction

###Examples

##Semantics

%cnzy is a twig

###Definition

    ++  twig  
      $%  [%cnzy p=term]
      ==

###Expansion

  ++  open
      ^-  twig
      ?-  gen
        [%cnzy *]  [%cnts [p.gen ~] ~]
      ==

##Notes
    

