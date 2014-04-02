---
layout: subpage
axis: doc-hoon
categories: ket rune
sort: 53
title: ketdot
---



`^.`, `ketdot`, `[%ktdt p=twig q=twig]` is a synthetic hoon that
casts `q` to the type of `(p q)`.

###Definition###

    ++  twig  
      $%  [%ktdt p=twig q=twig]
      ==

###Regular form (tall)###

    ^.  p
    q

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%ktdt *]
        [%ktls [%cnhp p.gen q.gen ~] q.gen]
      ==

###Notes###
