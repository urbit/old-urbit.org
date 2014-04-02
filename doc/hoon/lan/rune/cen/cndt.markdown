---
layout: subpage
category: cen
title: cendot
---

`%.`, `cendot`, `[%cndt p=twig q=twig]` is a synthetic hoon that
reverses the order of `%cnhp`.

###Definition###

    ++  twig  
      $%  [%cndt p=twig q=twig]
      ==

###Regular form (tall)###

    %.  p
    q

###Regular form (wide)###

    %.(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cndt *]
        [%cnhp q.gen [p.gen ~]]
      ==
