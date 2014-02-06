---
layout: post
category: doc
title: `^=`, `kettis`, `%ktts`
---

###Synopsis###

`^=`, `kettis`, `[%ktts p=togo q=twig]` is a natural hoon that
wraps `q` in the toga `p`.

###Definition###

    ++  twig  
      $%  [%ktts p=toga q=twig]
      ==
    ++  toga
              $|  p=term
              $%  [0 ~]
                  [1 p=term q=toga]
                  [2 p=toga q=toga]
              == 

###Regular form (tall)###

    ^=  p
    q

###Regular form (wide)###

    ^=(p q)

###Irregular form###

    p=q

###Compilation###
    
    ++  mint
      ?-  gen
        [%ktts *]  =+(vat=$(gen q.gen) [(conk(sut p.vat) p.gen) q.vat])
      ==
    ++  conk
      |=  got=toga
      ^-  type
      ?@  got  [%face got sut]
      ?-  -.got
        0  sut
        1  [%face p.got $(got q.got)]
        2  ?>  |(!vet (nest(sut [%cell %noun %noun]) & sut))
           :+  %cell
             $(got p.got, sut (peek %both 2)) 
           $(got q.got, sut (peek %both 3))
      ==

###Notes###

The mighty `toga` is a powerful naming device that can assign an
entire name tree to a properly typed result.  For instance, if
`foo` produces an unlabeled tuple `[x y z]`, `[a b=[c d]]=foo`
produces `[a=x b=[c=y d=z]]`.
