---
layout: subpage
category: tis
title: tiscol
---

`=:`, `tiscol`, `[%tscl p=tram q=twig]` is a synthetic hoon that
produces `q` with the subject modified by `p`.

###Definition###

    ++  twig  
      $%  [%tscl p=tram q=twig] 
      ==
    ++  tram  (list ,[p=wing q=twig])

###Regular form (tall)###

    =:  p.i.p      q.i.p
        p.i.t.p    q.i.t.p
        p.i.t.t.p  q.i.t.t.p
      ==
    q

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tscl *]
        [%tsgr [%cncb [[~ 1] ~] p.gen] q.gen]
      ==

###Notes###

`%tscl` uses `%cncb`, so it cannot change the subject type.
