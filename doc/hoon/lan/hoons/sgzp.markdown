---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 71
title: sigzap
---



#[sigzap, `~!`, %sgzp](#sgzp)

##Syntax

`~!`, `sigzap`, `[%sgzp p=twig q=twig]` is a natural hoon for 
debugging uses only, semantically equivalent to its own twig `q`.
But if compilation fails within `q`, `~!` will show the type of
`p` on the stacktrace.

###Form

####Tall

    ~!  p
        q

####Wide

    ~!(p q)


####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%sgzp p=twig]
      ==

###Expansion

    ++  mint
      ?-  gen
        [%sgzp *]  ~_(duck(sut (play p.gen)) $(gen q.gen))
      ==

##Notes

`~!` seems strange but is surprisingly useful.