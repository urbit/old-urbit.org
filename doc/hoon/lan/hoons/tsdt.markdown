---
layout: subpage
axis: doc-hoon
categories: tis rune
sort: 78
title: tisdot
---



#[tisdot, `=.`, %tsdt](#tsdt)

##Syntax

`=.`, `tisdot`, `[%tsdt p=wing q=twig r=twig]` is a synthetic hoon that produces `r` with `p` in the subject set to `q`.

###Form

####Tall

    =.  p 
      q
    r

Queenside:

    =.  p  q
    r

####Wide

    =.(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%tsdt p=wing q=twig r=twig
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%tsdt *]
        [%tsgr [%cncb [[~ 1] ~] p.gen] q.gen]
      ==

##Notes

`%tsdt` uses `%cncb`, so it cannot change the subject type.
