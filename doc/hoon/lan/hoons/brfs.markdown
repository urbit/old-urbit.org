---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 16
title: barfas
---

#[barfas, `|/`, %brfs](#brfs)

`|/`, `barfas`, `[%brfs p=tile q=(map term foot)]` is a synthetic hoon
that produces a vulcanized `%gold` tray with arms `q`, sample `[%bctr p]`.

###Form

`p` is a tile
`q` is a map
`p.n.q` is a term
`q.n.q` is a twig

####Tall

    |/  p
      +-  p.n.q
        q.n.q
      --

####Wide
None

####Irregular
None

###Reduction

    |/  p
      +-  p.n.q
        q.n.q
      --

reduces to

    =+  lyg=~(cloq al p)
    |_  q.lyg
    %-  ~(run by q)
    |=  a=foot
    ^-  foot
    ?.  ?=(elm -.a)
      a
    :-  -.a
    :+  =<  p.a
    %=  .
    +<  p.lyg=+<


###Examples

    ++  by                                                  ::  map engine
      ~/  %by
      |/  a=(map)

      +-  all
      ~/  %all
      |*  b=$+(* ?)
      |-  ^-  ?
      ?@  a
        &
      ?&((b q.n.a) $(a l.a) $(a r.a))


In ++by, |/ creates a tray that takes a map that is passed to its arms, designated with `+-`, since the arms of `|/` are wet.

##Semantics

`%brfs` is a twig.

###Definition###

    ++  twig  
      $%  [%brfs p=tile q=(map term foot]
      ==
 
    ++  term  ,@tas

    ++  foot  
      $%  [%ash p=twig]
          [%elm p=twig]
      ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%brfs *]  =+  lyg=~(cloq al p.gen)
                   :+  %brcb  q.lyg
                   %-  ~(run by q.gen)
                   |=  a=foot  ^-  foot
                   ?.  ?=(%elm -.a)  a
                   :-  -.a
                   :+  %tsgl  p.a
                   :+  %cnts  ~
                   :~  [[[%& 6] ~] [%ktts p.lyg [~ 6]]]
                   ==
      ==

    ++  al
      |_  sec=tile
      ++  cloq
        |-  ^-  [p=toga q=tile]
        ?:  ?=(^ -.sec)
          =+  [one=$(sec p.sec) two=$(sec q.sec)]
          [[%2 p.one p.two] [q.one q.two]]
        ?.  ?=(%bark -.sec)  [[%0 ~] sec]
        =+  got=$(sec q.sec)
        :_  q.got
        ?:(?=([%0 ~] p.got) p.sec [%1 p.sec p.got])
      --

##Notes

See the bestiary of core patterns in chapter 11.  See also the
discussion of vulcanization - the vulcanizing code is above.
