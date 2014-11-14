---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 88
title: wutdot
---



#[wutdot, `?.`, %wtdt](#wtdt)

##Syntax

`?.`, `wutdot`, `[%wtdt p=twig q=twig r=twig]` is a synthetic hoon
that produces `r` if `p` is yes (`&`, `0`), or `q` if `p` is no
(`|`, 1).

###Form

####Tall

    ?.  p
      q
    r

####Wide

    ?.(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtdt p=twig q=twig r=twig]
      ==


###Expansion

    ++  open
    ^-  twig
    ?-  gen
      [%wtdt *]   [%wtcl p.gen r.gen q.gen]
    ==

##Notes

It's not unheard of to say `?.` as "unless."
