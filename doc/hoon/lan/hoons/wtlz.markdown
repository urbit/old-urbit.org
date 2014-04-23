---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 96
title: wutlaz
---



#[wutlaz, %wtlz](#wtlz)

##Syntax

`wutlaz`, `[%wtlz p=wing q=twig r=tine]` is a synthetic
hoon that selects a case in `q` for the actual type of `p`.

###Form

####Tall

Kingside:

    ?+  p
      q
      p.i.r      q.i.r
      p.i.t.r    q.i.t.r
      p.i.t.t.r  q.i.t.t.r
    ==

Queenside:

    ?+    p
      q
        p.i.r      
      q.i.r
        p.i.t.r    
      q.i.t.r
        p.i.t.t.r  
      q.i.t.t.r
    ==

####Wide

    ?+(p p.i.r q.i.r, p.i.t.r q.i.t.r, p.i.t.t.r q.i.t.t.r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtlz p=tiki q=twig r=tine]
      ==
    ++  tine  (list ,[p=tile q=twig])
    ++  tiki
      $%  [& p=(unit term) q=wing]
          [| p=(unit term) q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?+    gen
          [%wtlz *]
        =+  vaw=~(. ah p.gen)
        %-  gray:vaw
        ^-  twig
        :+  %wtls  puce:vaw 
        [(blue:vaw q.gen) (turn r.gen |=([a=tile b=twig] [a (blue:vaw b)]))]
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
