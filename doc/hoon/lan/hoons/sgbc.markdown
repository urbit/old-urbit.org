---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 60
title: sigbuc
---



`~$`, `sigbuc`, `[%sgbc p=term q=twig]` is a synthetic hoon that
labels computation `q` as `p` for profiling.

###Definition###

    ++  twig  
      $%  [%sgbc p=term q=twig]
      ==

###Regular form (tall)###

    ~$  p
    q

###Regular form (wide)###

    ~$(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%sgbc *]  [%sggr [%live [%dtzz %$ p.gen]] q.gen]
      ==

###Notes###

The profiler is not currently enabled.
