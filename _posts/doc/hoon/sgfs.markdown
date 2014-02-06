---
layout: post
category: doc
title: `~/`, `sigfas`, `%sgfs`
---

###Synopsis###

`~/`, `sigfas`, `[%sgfs p=term q=twig]` is a synthetic hoon that
implements one common case - a gate arm in a book, ie, a library
function - of the `%sgcn` jet hint.  `%sgfs` assumes the parent
axis is `7` and there are no children.

###Definition###

    ++  twig  
      $%  [%sgfs p=term q=twig]
      ==

###Regular form (tall)###

  ~/  p
  q

###Regular form (wide)###

  ~/(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%sgfs *]  [%sgcn [~ 7] p.gen ~ q.gen]
      ==

###Notes###

See the discussion of jet propulsion in Chapter 11.  See also 
`%sgcn`.

The Chapter 11 way is the way it should work.  In Chapter 11, `p`
is the algorithm version (an arbitrary `@tas`).  In the current
`master`, `p` is the jet name within its parent.
