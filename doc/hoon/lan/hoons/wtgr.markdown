---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 90
title: wutgar
---



#[wutgar, `?>`, %wtgr](#wtgr)

##Syntax

`?>`, `wutgar`, `[%wtgr p=twig q=twig]` is a synthetic hoon that
produces `q`, asserting that `p` is yes (`&`, 0).

###Form

####Tall

    ?>  p
        q


####Wide

    ?>(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtgr p=twig]
      ==


###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%wtgr *]   [%wtcl p.gen q.gen [%zpzp ~]]
      ==

##Notes

None
