---
layout: subpage
category: buc
title: bucpat
---

`$@`, `bucpat`, `[%bcpt p=wing q=tile]` is a (just barely) natural 
hoon that whips tile `q` on wing `p`.

###Definition###

    ++  twig  
      $%  [%bcpt p=wing q=tile]
      ==
    ++  wing  (list limb)
    ++  limb  $|(term $%([%& p=axis] [%| p=@ud q=term]))

###Regular form (tall)###

    $@  p
    q

###Regular form (wide)###

    $@(p q)

###Irregular form###

    p@q

###Compilation###
 
    ++  mint
      ?-    gen
          [%bcpt *]  
        $(gen (~(whip al q.gen) p:(seep %read p.gen)))
    ==

###Notes###

See the description of `++whip` in Chapter 9.
