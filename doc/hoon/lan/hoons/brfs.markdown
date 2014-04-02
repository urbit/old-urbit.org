---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 16
title: barfas
---



`|/`, `barfas`, `[%brfs p=tile q=(map term foot)]` is a synthetic hoon
that produces a vulcanized `%gold` tray with arms `q`, sample `[%bctr p]`.

###Definition###

    ++  twig  
      $%  [%brfs p=tile q=(map term foot]
      ==

###Regular form (tall)###

Kingside:

    |_  p
    +-  p.n.q
      q.n.q
    --

Queenside:
  
    |_  p  
      +-  p.n.q
        q.n.q
    --

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

###Notes###

See the bestiary of core patterns in chapter 11.  See also the
discussion of vulcanization - the vulcanizing code is above.
