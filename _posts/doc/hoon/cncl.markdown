---
layout: post
category: doc
title: `%:`, `cencol`, `%cncl`
---

###Synopsis###

`%:`, `cencol`, `[%cncl p=twig q=twig]` is a synthetic hoon that
that pulls `%$` from the tray `p` with its sample set to `q`.

###Definition###

    ++  twig  
      $%  [%cncl p=twig q=twig]
      ==

###Regular form (tall)###

    %:  p
    q

###Regular form (wide)###

    %:(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%cncl *]  [%cnsg [%$ ~] p.gen q.gen]
      ==
