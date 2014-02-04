---
layout: post
category: doc
title: `!,`, `zapcom`, `%zpcm`
---

###Synopsis###

`!,`, `zapcom`, `[%zpcm p=twig q=twig]` is a natural hoon that
inserts twig `q` as a constant, typed with the type of twig `p`.

###Definition###

    ++  twig  
      $%  [%zpcm p=twig q=twig]
      ==

###Compilation###
    
    ++  mint
      ?-  gen
        [%zpcm *]  [(nice (play p.gen)) [%1 q.gen]]
      ==

###Regular form (tall)###

    !,  p
    q

###Regular form (wide)###

    !,(p q)

###Notes###

The compiler should verify that `p` is actually the type of the
twigs it uses, but doesn't at present.
