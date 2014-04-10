---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 42
title: cenzaz
---

#[cenzaz, %cnzz](#cnzz)

##Syntax

`cenzaz`, `[%cnzz p=wing]` is a synthetic hoon that pulls
wing `p` from the subject.

###Form
None, cenzaz is only used internally

####Tall

####Wide

####Irregular

###Reduction

###Examples

##Semantics

%cnzz is a twig

###Definition

    ++  twig  
      $%  [%cnzz p=wing]
      ==

###Expansion
 
    ++  open
      ^-  twig
      ?-  gen
        [%cnzz *]  [%cnts p.gen ~]
      ==

##Notes

