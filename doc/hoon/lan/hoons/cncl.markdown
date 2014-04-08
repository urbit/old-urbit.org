---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 33
title: cencol
---


#[cencol, `%:`, %cncl](#cncl)

##Syntax

`%:`, `cencol`, `[%cncl p=twig q=twig]` is a synthetic rune that
that pulls `%$` from the tray `p` with its sample set to `q`.

###Form

`p` is a twig
`q` is a twig

####Tall

    %:  p
    p

####Wide

    %:('twig' 'twig')

####Irregular

None

###Reduction

    %:  p
    q

reduces to

    %~  $
    p  q

reduces to

    %*  $  p
      +<  q
    ==
      
###Examples

##Semantics

%cncl is a twig.

###Definition

    ++  twig  
      $%  [%cncl p=twig q=twig]
      ==

###Expansion
    
    ++  open
      ^-  twig
      ?-  gen
        [%cncl *]  [%cnsg [%$ ~] p.gen q.gen]
      ==

###Notes
