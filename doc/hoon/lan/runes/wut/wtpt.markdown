---
layout: subpage
category: wut
title: wutpat
---

`?@`, `wutpat`, `[%wtpt p=wing q=twig r=twig]` is a synthetic hoon 
that produces `q` if `p` is an atom, `r` otherwise.

###Definition###

    ++  twig  
      $%  [%wtpt p=wing q=twig r=twig]
      ==

###Regular form (tall)###

    ?@  p
      q
    r

###Regular form (wide)###

    ?@(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%wtpt *]  [%wtcl [%wtts [%axil %atom %$] p.gen] q.gen r.gen]
      ==
