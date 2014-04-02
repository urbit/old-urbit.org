---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 18
title: barket
---



`|^`, `barket`, `[%brkt p=twig q=(map term foot)]` is a synthetic hoon
that produces a `%gold` book with arms `q`, plus `p` as `%$`, and 
kicks it.

###Definition###

    ++  twig  
      $%  [%brkt p=twig q=(map term foot)]
      ==

###Regular form (tall)###

Kingside:

    |^  
      p
    ++  p.n.q
      q.n.q
    --

Queenside:
  
    |^  p
      ++  p.n.q
        q.n.q
    --

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brkt *]
        [%tsgr [%brcn (~(put by q.gen) %$ [%ash p.gen])] [%cnzy %$]]
      ==

###Notes###

See the bestiary of cores in Chapter 11.

`|^` is kind of pointless and may be deprecated in future releases.
