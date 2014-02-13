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

    ?:(p q r)

###Expansion###

<div class="codeblock">
  ++  open
    ^-  twig
    ?-  gen
      [%wtdt *]   [<a href="/bestiary/hoon/rune/wut/wtcl/">%wtcl</a> p.gen r.gen q.gen]
    ==
</div>

###Notes###

It's not unheard of to say `?.` as "unless."
