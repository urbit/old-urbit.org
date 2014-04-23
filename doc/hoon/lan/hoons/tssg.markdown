---
layout: subpage
axis: doc-hoon
categories: tis rune
sort: 84
title: tissig
---



#[tissig, `=~`, %tssg](#tssg)

##Syntax

`=~`, `tissig`, `[%tssg p=tusk]` is a synthetic hoon that
composes a list of twigs.

###Form

####Tall

    =~    i.p
        i.t.p
        i.t.t.p
    ==
 
Queenside:

    =~  i.p
        i.t.p
        i.t.t.p
    ==

####Wide

    None

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%tssg p=tusk]
      ==
    ++  tusk  (list twig)

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%tssg *]
      ==

##Notes

`=~` is usually used for formatting high-level reefs without
losing base indentation.
