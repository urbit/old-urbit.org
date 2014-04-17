---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 100
title: wutsig
---



#[wutsig %wtsg](#wtsg)

##Syntax

`?~`, `wutsig`, `[%wtsg p=wing q=twig r=twig]` is a synthetic hoon 
that produces `q` if `p` is `~`, `r` otherwise.

###Form

####Tall

?~  p
      q
    r

####Wide

    ?~(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtsg p=wing q=twig r=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wtsg *]
        [%wtcl [%wtts [%axil %null] p.gen] q.gen r.gen]
      ==

##Notes

None