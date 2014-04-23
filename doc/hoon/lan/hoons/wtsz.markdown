---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 101
title: wutsaz
---



#[wutsaz, %wtsz](#wtsz)

##Syntax

`wutsaz`, `[%wtsz p=tiki q=twig r=twig]` is a synthetic hoon 
that produces `q` if `p` is `~`, `r` otherwise.

###Form

####Tall

    ?~  p
          q
        r

####Wide

    ?~(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtsg p=wing q=twig r=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wtsz *]
        =+  vaw=~(. ah p.gen)
        %-  gray:vaw
        [%wtsg puce:vaw (blue:vaw q.gen) (blue:vaw r.gen)]
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
