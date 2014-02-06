---
layout: post
category: doc
title: `=|`, `tisbar`, `%tsbr`
---

###Synopsis###

`=|`, `tisbar`, `[%tsbr p=tile q=twig]` is a synthetic hoon that
pushes `~(bunt al p)` on the subject and sends it to `q`.

###Definition###

    ++  twig  
      $%  [%tsbr p=tile q=twig]
      ==

###Regular form (tall)###

    =|  p
    q

###Regular form (wide)###

    =|(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%tsbr *]  [%tsls ~(bunt al p.gen) q.gen]
      ==

###Notes###

`=|(p q)` is the same as `=+(_p q)`.
