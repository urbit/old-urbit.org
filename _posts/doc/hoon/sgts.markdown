---
layout: post
category: doc
title: `~=`, `sigtis`, `%sgts`
---

###Synopsis###

`~=`, `sigtis`, `[%sgts p=twig q=twig]` is a synthetic hoon that
hints to the interpreter that `q` may produce a noun equal to the
already existing `p`, avoiding duplication.

###Definition###

    ++  twig  
      $%  [%sgts p=twig]
      ==

###Regular form (tall)###

    ~=  p
    q

###Regular form (wide)###

    ~=(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%sgts *]  [%sggr [%germ p.gen] q.gen]
      ==

###Notes###

Where to use `%sgts`?  In any traversal that selectively
reconstructs a noun.  If a traversal can change the head and/or
tail of a cell, if it leaves both head and tail unchanged, by
default it will recreate a new copy of the old cell.  Using
`%sgts` to force a comparison with the old cell lets the
interpreter discard the copy right away.
