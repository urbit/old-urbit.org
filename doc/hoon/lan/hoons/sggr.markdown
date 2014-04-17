---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 66
title: siggar
---



#[siggar, `~>`, %sggr](#sggr)

##Syntax

`~>`, `siggar`, `[%sggr p=$|(term [p=term q=twig]) q=twig]` is a
natural hoon that applies arbitrary hint `p` to `q`.
`q`.

###Form

####Tall

`p=%foo`:
  
    ~>  %foo
        q

    `p=[p=%foo q=bar]`:

        ~>  %foo.bar
        q

####Wide

    ~>(%foo q)
    ~>(%foo.bar q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
        [%sggr p=$|(term [p=term q=twig]) q=twig]   ::
      $%  [%sggr p=twig]
      ==

###Expansion

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

##Notes

Rather obviously, all other hinting `~` runes reduce to `~>`.