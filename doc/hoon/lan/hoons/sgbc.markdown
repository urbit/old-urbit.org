---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 60
title: sigbuc
---



#[sigbuc, `~$`, %sgbc](#sgbc)

##Syntax

`~$`, `sigbuc`, `[%sgbc p=term q=twig]` is a synthetic hoon that
labels computation `q` as `p` for profiling.

###Form

####Tall

    ~?  p
        q

####Wide

    ^?(q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%sgbc p=term q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%sgbc *]  [%sggr [%live [%dtzz %$ p.gen]] q.gen]
      ==

##Notes

The profiler is not currently enabled.