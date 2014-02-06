---
layout: post
category: doc
title: `=^`, `tisket`, `%tskt`
---

###Synopsis###

`=^`, `tisket`, `[%tskt p=twig q=twig r=twig s=twig]` is a synthetic 
hoon that handles a product which is a cell of a new result, and
a mutation to the subject.

###Definition###

    ++  twig  
      $%  [%tskt p=twig q=twig r=twig s=twig]
      ==

###Regular form (tall)###

Kingside:

    =^    p 
        q
      r
    s

Queenside:

    =^  p  q
      r
    s

###Regular form (wide)###

    =^(p q r s)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tskt *]
        =+  cog=rusk(gen p.gen)                           ::
        =+  wuy=(weld rake(gen q.gen) `wing`[%v ~])       ::
        :+  %tsgr  [%ktts %v ~ 1]                         ::  =>  v=.
        :+  %tsls  [%ktts %a %tsgr [%cnzy %v] r.gen]      ::  =+  a==>(v \r.gen)
        :^  %tsdt  wuy  [%tsgl [~ 3] [%cnzy %a]]          ::  =.  \wuy  +.a
        :+  %tsgr  :-  :+  %ktts  cog                     ::  =>  :-  ^=  \cog
                       [%tsgl [~ 2] [%cnzy %a]]           ::          -.a
                   [%cnzy %v]                             ::      v
        s.gen                                             ::  s.gen
      ==

###Notes###

Language change alert: `p` should be a term, `q` should be a wing.

We use `=^` for the common pattern of a state machine which
exposes a gate that produces a cell `[result new-state]`.  When
the state machine is part of the subject - at wing `q` - we often
want to push the result under a name, as in `=+  p=result`, and
continue to twig `s` with the change `=.  q  new-state`.
