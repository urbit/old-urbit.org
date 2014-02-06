---
layout: post
category: doc
title: `~$`, `sigbuc`, `%sgbc`
---

###Synopsis###

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

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%sgbc *]  [%sggr [%live [%dtzz %$ p.gen]] q.gen]
      ==

###Notes###

The profiler is not currently enabled.
