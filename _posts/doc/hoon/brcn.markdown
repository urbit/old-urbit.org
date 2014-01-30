---
layout: post
category: doc
title: `$@`, `barcen`, `%brcn`
---

###Synopsis###

`$@`, `barcen`, `[%brcn p=(map term foot)]` is a natural hoon
that produces a core.

###Definition###

    ++  twig  
      $%  [%brcn p=(map term foot)]
      ==
    ++  foot  
      $%  [%ash p=twig]
          [%elm p=twig]
      ==

###Regular form (tall)###

Kingside:

    |%  ++  dry-arm
          "hello, world"
        +-  wet-arm
          "goodbye, world"
    --

Queenside:

    |%  
    ++  dry-arm
      "hello, world"
    +-  wet-arm
      "goodbye, world"
    --

###Compilation###

    ++  mint
      ?-    gen
          [%bcpt *]  
        (grow %gold [~ 1] p.gen)
    ==
 
    ++  grow
      |=  [mel=?(%gold %iron %lead %zinc) ruf=twig dab=(map term foot)]
      ^-  [p=type q=nock]
      =+  dan=^$(gen ruf, gol %noun)
      =+  toc=(core p.dan [%gold p.dan [~ dab]])
      =+  dez=(harp(sut toc) dab)
      :-  (nice (core p.dan mel p.dan [dez dab]))
      (cons [%1 dez] q.dan)

    ++  harp
      |=  dab=(map term foot)
      ^-  ?(~ ^)
      ?:  ?=(~ dab)
        ~
      =+  ^=  vad
          ?+  -.q.n.dab  !!
            %ash  q:(mint %noun p.q.n.dab)
            %elm  q:(mint(vet |) %noun p.q.n.dab)
          ==
      ?-    dab
          [* ~ ~]   vad
          [* ~ *]   [vad $(dab r.dab)]
          [* * ~]   [vad $(dab l.dab)]
          [* * *]   [vad $(dab l.dab) $(dab r.dab)]
      ==

###Notes###

See the explanation of cores in Chapter 8.

