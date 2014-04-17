---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 98
title: wutpat
---



#[wutpat %wtpt](#wtpt)

##Syntax

`?@`, `wutpat`, `[%wtpt p=wing q=twig r=twig]` is a synthetic hoon 
that produces `q` if `p` is an atom, `r` otherwise.

###Form

####Tall

Kingside:

    ?@  p
      q
    r

####Wide

    ?@(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtpt p=wing q=twig r=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%wtpt *]  [%wtcl [%wtts [%axil %atom %$] p.gen] q.gen r.gen]
      ==

##Notes

None