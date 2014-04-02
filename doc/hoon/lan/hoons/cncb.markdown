---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 32
title: cencab
---



`%_`, `cencab`, `[%cncb p=wing q=tram]` is a synthetic hoon that
evaluates `p` with the changes specified in `q`, then casts the
product back to `p`.

###Definition###

    ++  twig  
      $%  [%cncb p=wing q=tram]
      ==
    ++  tram  (list ,[p=wing q=twig]) 

###Regular form (tall)###

Kingside:

    %_  p
      p.i.q    q.i.q
      p.i.t.q  q.i.t.q
    ==

Queenside:

    %_    p
        p.i.q    
      q.i.q
        p.i.t.q  
      q.i.t.q
    ==

###Regular form (wide)###

    %_(p p.i.q q.i.q, p.i.t.q q.i.t.q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cncb *]
        [%ktls [%cnzz p.gen] %cnts p.gen q.gen]
      ==

###Notes###

`%cnts` is not of course constrained to produce a `p` whose type
is unchanged.  Usually this is fine - sometimes we want the
discipline.
