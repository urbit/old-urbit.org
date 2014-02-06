---
layout: post
category: doc
title: `~<`, `siggal`, `%sggl`
---

###Synopsis###

`~<`, `siggal`, `[%sggl p=$|(term [p=term q=twig]) q=twig]` is a
synthetic hoon that applies arbitrary hint `p` to the product of 
`q`.

###Definition###

    ++  twig  
        [%sggl p=$|(term [p=term q=twig]) q=twig]   ::
      $%  [%sggl p=twig]
      ==

###Regular form (tall)###
    
`p=%foo`:
  
    ~<  %foo
    q

`p=[p=%foo q=bar]`:

    ~<  %foo.bar
    q

###Regular form (wide)###

    ~<(%foo q)
    ~<(%foo.bar q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%sggl *]
        [%tsgl [%sggr p.gen [~ 1]] q.gen]
      ==

###Notes###

For some hints we'd rather just wake the hint engine up when the
computation is done.

