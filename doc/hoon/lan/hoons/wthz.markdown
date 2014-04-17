---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 92
title: wuthaz
---



#[wutgar %wtgr](#wtgr)

##Syntax

`wuthaz`, `[%wthz p=wing q=tine]` is a synthetic hoon that
selects a case in `q` for the actual type of `p`.

###Form

####Tall

    Kingside:

    ?-  p
      p.i.q      q.i.q
      p.i.t.q    q.i.t.q
      p.i.t.t.q  q.i.t.t.q
    ==

Queenside:

    ?-    p
        p.i.q      
      q.i.q
        p.i.t.q    
      q.i.t.q
        p.i.t.t.q  
      q.i.t.t.q
    ==

####Wide

    ?-(p p.i.q q.i.q, p.i.t.q q.i.t.q, p.i.t.t.q q.i.t.t.q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wthz p=tiki q=tine]
      ==
    ++  tine  (list ,[p=tile q=twig])
    ++  tiki
      $%  [& p=(unit term) q=wing]
          [| p=(unit term) q=twig]
      ==


###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wthz *]
        =+  vaw=~(. ah p.gen)
        %-  gray:vaw
        [%wthp puce:vaw (turn q.gen |=([a=tile b=twig] [a (blue:vaw b)]))]
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
