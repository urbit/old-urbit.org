---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 62
title: sigcab
---



#[sigcab, `~_`, %sgcb](#sgcb)

##Syntax

`~_`, `sigcab`, `[%sgcb p=twig q=twig]` is a synthetic hoon
that inserts `p`, a trap producing `tank`, in the trace of `q`.

###Form

####Tall

    ~_  p
        q

####Wide

    ^_(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%sgcb p=twig q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%sgcb *]  [%sggr [%mean [%brdt p.gen]] q.gen]
      ==

##Notes

`~_` is useful if you want to define and present your own
debugging representation of an ongoing computation, which will
appear in the trace of any crash within that computation.