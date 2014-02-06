---
layout: post
category: doc
title: `=.`, `tisdot`, `%tsdt`
---

###Synopsis###

`=.`, `tisdot`, `[%tsdt p=wing q=twig r=twig]` is a synthetic 
hoon that produces `r` with `p` in the subject set to `q`.

###Definition###

    ++  twig  
      $%  [%tsdt p=wing q=twig r=twig
      ==

###Regular form (tall)###

Kingside:

    =.  p 
      q
    r

Queenside:

    =.  p  q
    r

###Regular form (wide)###

    =.(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tsdt *]
        [%tsgr [%cncb [[~ 1] ~] p.gen] q.gen]
      ==

###Notes###

`%tsdt` uses `%cncb`, so it cannot change the subject type.
