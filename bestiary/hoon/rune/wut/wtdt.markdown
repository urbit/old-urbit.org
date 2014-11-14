---
layout: subpage
category: wut
title: wutdot
---

`?.`, `wutdot`, `[%wtdt p=twig q=twig r=twig]` is a synthetic hoon
that produces `r` if `p` is yes (`&`, `0`), or `q` if `p` is no
(`|`, 1).

###Definition###

    ++  twig  
      $%  [%wtdt p=twig q=twig r=twig]
      ==

###Regular form (tall)###

    ?.  p
      q
    r

###Regular form (wide)###

    ?.(p q r)

###Expansion###

  ++  open
    ^-  twig
    ?-  gen
      [%wtdt *]   [%wtcl p.gen r.gen q.gen]
    ==

###Notes###

It's not unheard of to say `?.` as "unless."
