---
layout: subpage
axis: doc-hoon
categories: sem rune
sort: 72
title: semcol
---



#[semcol, `;:`, %smcl](#smcl)

##Syntax

`;:`, `semcol`, `[%smcl p=twig q=tusk]` is a synthetic hoon that
applies `p`, a binary gate, to the n-ary tuple `q`.

###Form

####Tall

    ;:  p
      i.q
      i.t.q
      i.t.t.q
    ==

####Wide

    ;:(p i.q i.t.q i.t.t.q)


####Irregular

    :(p i.q i.t.q i.t.t.q)

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%smcl p=twig q=tusk]
      ==
    ++  tusk  (list twig)

###Expansion

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

##Notes

It's certainly nice to be able to say `:(add 2 3 4)` and get `9`.
`~!` seems strange but is surprisingly useful.