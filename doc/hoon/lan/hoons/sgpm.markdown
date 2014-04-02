---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 68
title: sigpam
---



`~&`, `sigpam`, `[%sgpm p=@ud q=twig r=twig]` is a synthetic hoon 
that prints `q` on the console before computing `r`.  `p` is the
log priority, 0-3 defaulting to 0.

###Definition###

    ++  twig  
      $%  [%sgpm p=twig]
      ==

###Regular form (tall)###

Priority 0 (debug):

    ~&  q
    r

Priority 1 (notice):

    ~&  >  q
    r

Priority 2 (warning):

    ~&  >>  q
    r

Priority 3 (alarm):

    ~&  >>>  q
    r

###Regular form (wide)###

    ~&(>> q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%sgpm *]
        :+  %sggr
          [%slog [%dtzy %$ p.gen] [%cnhp [%cnzy %cain] [%zpgr q.gen] ~]]
        r.gen
      ==

###Notes###

`%sgpm` uses the biblical name `%cain` for printing, so it won't
work without some equivalent of

    ++  cain  |=(vax=vase (sell vax))

in the subject.
