---
layout: subpage
category: zap
title: zapfas
---

`!/`, `zapfas`, `[%zpfs p=twig q=twig]` is a natural hoon that should
never be compiled.  When compiled with error checking turned on,
it reports its subject as an error.

###Definition###

    ++  twig  
      $%  [%zpfs p=twig]
      ==

###Compilation###
    
    ++  mint
      ?-    gen
          [%zpfs *]  
        ?:  vet
          ~_  (dunk(sut (play p.gen)) 'lost')
          ~|(%mint-lost !!)
        [%void [%0 0]]
      ==

###Notes###

We use `%zpfs` in `?-` to make sure all cases are handled.
