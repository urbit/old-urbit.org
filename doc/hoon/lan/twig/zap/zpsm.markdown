---
layout: subpage
category: zap
title: zapsem
---

`!;`, `zapsem`, `[%zpsm p=twig q=twig]` is a natural hoon that
produces the product of twig `q` as a `[type noun]` pair, with
twig `p` defining the type of the type.

###Definition###

    ++  twig  
      $%  [%zpsm p=twig q=twig]
      ==

###Regular form (tall)###

    !;  p
    q

###Regular form (wide)###

    !;(p q)

###Compilation###
    
    ++  mint
      ?-  gen
          [%zpsm *]  
        =+  vos=$(gol %noun, gen q.gen)
        [(nice (cell (play p.gen) p.vos)) (cons [%1 p.vos] q.vos)]
      ==

###Notes###

The compiler should verify that `p` is actually the type of the
types it uses, but doesn't at present.
