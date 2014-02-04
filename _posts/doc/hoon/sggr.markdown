---
layout: post
category: doc
title: `~>`, `siggar`, `%sggr`
---

###Synopsis###

`~>`, `siggar`, `[%sggr p=$|(term [p=term q=twig]) q=twig]`
is a natural hoon that applies twig `q` within hint `p`.

###Definition###

    ++  twig  
      $%  [%sggr p=$|(term [p=term q=twig]) q=twig]
      ==

###Regular form (tall)###

    ~>  %hint
    q

    ~>  %hint.(add 2 2)
    q

###Regular form (wide)###

    ~>(%hint q)
    ~>(%hint.(add 2 2) q)

###Compilation###
    
    ++  mint
      ?-    gen
          [%sggr *]
        =+  hum=$(gen q.gen)
        :-  p.hum
        :+  %10
          ?-    p.gen
              @   p.gen
              ^   [p.p.gen q:$(gen q.p.gen, gol %noun)]
          ==
        q.hum
      ==

###Notes###

Numerous other hinting `~` runes resolve to `~>`.

