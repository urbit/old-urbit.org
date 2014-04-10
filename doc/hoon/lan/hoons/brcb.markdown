---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 13
title: barcab
---

#[barcab, `|_`, %brcb](#brcb)

##Syntax

`|_`, `barcab`, `[%brcb p=tile q=(map term foot)]` is a synthetic hoon that
produces a `%gold` tray with sample `p`, arms `q`. `|_` takes an associative
array of names (++term) and expressions (++foot), each pair of which is called
an arm. A dry, or %ash, arm is denoted with `++`. `|_` can take an arbitrary
number of arms, but the arm array must be terminated with a `--`

###Form

`p` is a ++tile

`q` is a {term foot} ++map.

`p.n.q` is ++term

`q.n.q` is a ++twig

####Tall

    |_  p
    ++  p.n.q
      q.n.q
    --

####Wide
None

####Irregular
None

###Reduction

     |_  p
    ++  p.n.q
      q.n.q
    --

reduces to

    =+  $*(p)
    |% 
    ++  p.n.q
      q.n.q
    --

###Examples

    ++  fe                                                  ::  modulo bloq
      |_  a=bloq
      ++  dif  |=([b=@ c=@] (sit (sub (add out (sit b)) (sit c))))
      ++  inv  |=(b=@ (sub (dec out) (sit b)))
      ++  net  |=  b=@  ^-  @
               =>  .(b (sit b))
               ?:  (lte a 3)
                 b
               =+  c=(dec a)
               %+  con
                 (lsh c 1 $(a c, b (cut c [0 1] b)))
               $(a c, b (cut c [1 1] b))
      ++  out  (bex (bex a))
      ++  rol  |=  [b=bloq c=@ d=@]  ^-  @
               =+  e=(sit d)
               =+  f=(bex (sub a b))
               =+  g=(mod c f)
               (sit (con (lsh b g e) (rsh b (sub f g) e)))
      ++  ror  |=  [b=bloq c=@ d=@]  ^-  @
               =+  e=(sit d)
               =+  f=(bex (sub a b))
               =+  g=(mod c f)
               (sit (con (rsh b g e) (lsh b (sub f g) e)))
      ++  sum  |=([b=@ c=@] (sit (add b c)))
      ++  sit  |=(b=@ (end a 1 b))
      --

In ++fe, `|_` creates a tray whose arms contain gates used to calculate modular
arithmetic on bitstrings. The sample of `|_` is the tile `a=bloq` which is a
block size argument that gets passed to each of the arms.

###Semantics

`%brcb` is a twig.

###Definition

    ++  twig  
      $%  [%brcb p=tile q=(map term foot)]
      ==

    ++  map  |*  [a=_,* b=_,*]                              ::  associative array
             $|(~ [n=[p=a q=b] l=(map a b) r=(map a b)])    ::
 
    ++  term  ,@tas                                         ::

    ++  foot  $%  [%ash p=twig]                             ::
                  [%elm p=twig]                             ::
              ==                                            ::

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%brcb *]
        [%tsls [%bctr p.gen] [%brcn q.gen]]
      ==

##Notes
