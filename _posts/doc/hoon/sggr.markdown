
---
layout: post
category: doc
title: `~>`, `siggal`, `%sggl`
---

###Synopsis###

`~>`, `siggal`, `[%sggl p=$|(term [p=term q=twig]) q=twig]` is a
natural hoon that applies arbitrary hint `p` to `q`.
`q`.

###Definition###

    ++  twig  
        [%sggl p=$|(term [p=term q=twig]) q=twig]   ::
      $%  [%sggl p=twig]
      ==

###Regular form (tall)###
    
`p=%foo`:
  
    ~>  %foo
    q

`p=[p=%foo q=bar]`:

    ~>  %foo.bar
    q

###Regular form (wide)###

    ~>(%foo q)
    ~>(%foo.bar q)

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

Rather obviously, all other hinting `~` runes reduce to `~>`.
