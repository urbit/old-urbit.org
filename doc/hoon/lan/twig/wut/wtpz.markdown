---
layout: subpage
category: wut
title: wutpaz
---

`wutpaz`, `[%wtpz p=tiki q=twig r=twig]` is a synthetic hoon 
that produces `q` if `p` is an atom, `r` otherwise.

###Definition###

    ++  twig  
      $%  [%wtpz p=tiki q=twig r=twig]
      ==
    ++  tiki
      $%  [& p=(unit term) q=wing]
          [| p=(unit term) q=twig]
      ==

###Regular form (tall)###

    ?@  p
      q
    r

###Regular form (wide)###

    ?@(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtsz *]
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

###Notes###

See the discussion of tikis in chapter 11.
