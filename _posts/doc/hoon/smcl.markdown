---
layout: post
category: doc
title: `;:`, `semcol`, `%smcl`
---

###Synopsis###

`;:`, `semcol`, `[%smcl p=twig q=tusk]` is a synthetic hoon that
applies `p`, a binary gate, to the n-ary tuple `q`.

###Definition###

    ++  twig  
      $%  [%smcl p=twig q=tusk]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

    ;:  p
      i.q
      i.t.q
      i.t.t.q
    ==

###Regular form (wide)###

    ;:(p i.q i.t.q i.t.t.q)

###Irregular form###

    :(p i.q i.t.q i.t.t.q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%smcl *]
        ?-    q.gen
            ~       [%zpzp ~]
            [* ~]   i.q.gen
            ^
          :+  %tsls
            p.gen
          =+  yex=`(list twig)`q.gen
          |-  ^-  twig
          ?-  yex
            [* ~]  [%tsgr [~ 3] i.yex]
            [* ^]  [%cnhp [~ 2] [%tsgr [~ 3] i.yex] $(yex t.yex) ~]
            ~      !!
          ==
        ==
      ==

###Notes###

It's certainly nice to be able to say `:(add 2 3 4)` and get `9`.
