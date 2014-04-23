---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 94
title: wutkaz
---



#[wutkaz, %wtkz](#wtkz)

##Syntax

`wutkaz`, `[%wtkz p=tiki q=twig r=twig]` is a synthetic hoon that
evaluates `r` if `p` is equal to the bunt for its tile, otherwise
`q` is evaluated.

###Form

####Tall

    ?^  p
      q
    r

####Wide

    ?^(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtkz p=tiki q=twig r=twig]
      ==
    ++  tiki
      $%  [& p=(unit term) q=wing]
          [| p=(unit term) q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wtkz *]
        =+  vaw=~(. ah p.gen)
        %-  gray:vaw
        [%wtkt puce:vaw (blue:vaw q.gen) (blue:vaw r.gen)]
      ==
    ++  ah
      |_  tig=tiki
      ++  blue
        |=  gen=twig 
        ^-  twig
        ?.  &(?=(| -.tig) ?=(~ p.tig))  gen
        [%tsgr [~ 3] gen]
      ::
      ++  gray
        |=  gen=twig
        ^-  twig
        ?-  -.tig
          &  ?~(p.tig gen [%tstr u.p.tig q.tig gen])
          |  [%tsls ?~(p.tig q.tig [%ktts u.p.tig q.tig]) gen]
        ==
      ::
      ++  puce
        ^-  wing
        ?-  -.tig
          &  ?~(p.tig q.tig [u.p.tig ~])
          |  [[%& 2] ~]
        ==
      --

##Notes

See the discussion of tikis in chapter 11.
