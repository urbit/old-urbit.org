---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 64
title: sigfas
---



#[sigfas, `~/`, %sgfs](#sgfs)

##Syntax

`~/`, `sigfas`, `[%sgfs p=term q=twig]` is a synthetic hoon that
implements one common case - a gate arm in a book, ie, a library
function - of the `%sgcn` jet hint.  `%sgfs` assumes the parent
axis is `7` and there are no children.

###Form

####Tall

    ~/  p
        q

####Wide

    ~/(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%sgfs p=term q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%sgfs *]  [%sgcn [~ 7] p.gen ~ q.gen]
      ==

##Notes

See the discussion of jet propulsion in Chapter 11.

The Chapter 11 way is the way it should work.  In Chapter 11, `p`
is the algorithm version (an arbitrary `@tas`).  In the current
`master`, `p` is the core's name relative to the parent (which
should be derived from `r` in the parent), and `q`, which should
be a wing, is actually a twig.