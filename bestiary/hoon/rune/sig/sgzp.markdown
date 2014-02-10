---
layout: subpage
category: sig
title: sigzap
---

`~!`, `sigzap`, `[%sgzp p=twig q=twig]` is a natural hoon for 
debugging uses only, semantically equivalent to its own twig `q`.
But if compilation fails within `q`, `~!` will show the type of
`p` on the stacktrace.

###Definition###

    ++  twig  
      $%  [%sgzp p=twig]
      ==

###Regular form (tall)###

  ~!  p
  q

###Regular form (wide)###

  ~!(p q)

###Compilation###
    
    ++  mint
      ?-  gen
        [%sgzp *]  ~_(duck(sut (play p.gen)) $(gen q.gen))
      ==

###Notes###

`~!` seems strange but is surprisingly useful.
