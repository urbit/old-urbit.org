---
layout: subpage
category: bar
title: bardot
---

`|.`, `bardot`, `[%brdt p=twig]` is a synthetic hoon that produces
a dry `%gold` trap.

###Definition###

    ++  twig  
      $%  [%brdt p=twig]
      ==

###Regular form (tall)###

Kingside:

    |.
    p
 
Queenside:

    |.  p

###Regular form (wide)###

    |.(p)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brdt *]  
        [%brcn (~(put by *(map term foot)) %$ [%ash p.gen])]
      ==

###Notes###

See the bestiary of core patterns in chapter 11.
