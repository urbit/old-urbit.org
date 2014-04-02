---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 61
title: sigbar
---



`~|`, `sigbar`, `[%sgbr p=twig q=twig]` is a synthetic hoon that
presents the product of `p` in the stack trace if `q` crashes.
The computation is only performed if needed.

###Definition###

    ++  twig  
      $%  [%sgbr p=twig q=twig]
      ==

###Regular form (tall)###

    ~|  p
    q

###Regular form (wide)###

    ~|(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%sgbr *]
        :+  %sggr
          :-  %mean
          =+  fek=~(feck ap p.gen)
          ?^  fek  [%dtzz %tas u.fek]
          [%brdt [%cnhp [%cnzy %cain] [%zpgr p.gen] ~]]
        q.gen 
      ==
    ::
    ++  feck
      |-  ^-  (unit term)
      ?-  gen
        [%dtzy %tas *]  [~ q.gen]
        [%dtzz %tas @]  [~ q.gen]
        [%zpcb *]       $(gen q.gen)
        *               ~
      ==

###Notes###

Note that `~|` generates the Biblical name `%cain`, which
conventionally converts a vase to a printable tank.  But we use
`++feck` to make simple uses of `~|` work before `++cain` is
defined.
