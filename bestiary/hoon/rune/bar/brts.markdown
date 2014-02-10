---
layout: subpage
category: bar
title: bartis
---

`|=`, `bartis`, `[%brts p=tile q=twig]` is a synthetic hoon that
produces a dry `%gold` gate with arm `q`, sample `[%bctr p]`.

###Definition###

    ++  twig  
      $%  [%brts p=tile q=twig]
      ==

###Regular form (tall)###

    |=  p
    q

###Regular form (wide)###

    |=(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brts *]
        [%brcb p.gen (~(put by *(map term foot)) %$ [%ash q.gen])]
      ==

###Notes###

See the bestiary of cores in Chapter 11.

In slang, street or gutter Hoon, `|=` is pronounced `bong`.  But
any serious or respectable engineer will only say `bartis`.
"Lambda" is not an appropriate usage in either circumstance.
