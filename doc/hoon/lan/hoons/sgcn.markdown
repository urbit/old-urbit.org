---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 63
title: sigcen
---



`~%`, `sigcen`, `[%sgcn p=term q=twig r=tyre s=twig]`, a  
synthetic hoon, identifies a core for specific optimization.

###Definition###

    ++  twig  
      $%  [%sgcn p=term q=twig r=tyre s=twig]
      ==

###Regular form (tall)###

    ~%    p
        q
      ==
        p.i.r    q.i.r
        p.i.t.r  q.i.t.r
      ==
    s

    ~%    p
        q
      ~
    s

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%sgcn *]
        :+  %sggl
          :-  %fast
          :-  %clls
          :+  [%dtzz %$ p.gen]
            [%zpts q.gen]
          :-  %clsg
          =+  nob=`(list twig)`~
          |-  ^-  (list twig)
          ?@  r.gen
            nob
          [[[%dtzz %$ p.i.r.gen] [%zpts q.i.r.gen]] $(r.gen t.r.gen)]
        s.gen
          [%sgcn *]
      ==

###Notes###

See the discussion of jet propulsion in Chapter 11.

The Chapter 11 way is the way it should work.  In Chapter 11, `p`
is the algorithm version (an arbitrary `@tas`).  In the current
`master`, `p` is the core's name relative to the parent (which
should be derived from `r` in the parent), and `q`, which should
be a wing, is actually a twig.
