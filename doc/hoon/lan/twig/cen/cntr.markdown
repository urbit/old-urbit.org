---
layout: subpage
category: cen
title: centar
---

`%*`, `centar`, `[%cntr p=twig q=twig]` is a synthetic hoon that
produces the tray `p` with its sample set to `q`.

###Definition###

    ++  twig  
      $%  [%cntr p=twig]
      ==

###Regular form (tall)###

    %*  p
    q

###Regular form (wide)###

    %*(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cntr *]
        :+  %tsls
          q.gen
        :+  %cnts
          (weld p.gen `wing`[[~ 2] ~])
        (turn r.gen |=([p=wing q=twig] [p [%tsgr [~ 3] q]]))
      ==

###Notes###

What is the difference between 

    %*  p
    q

and

    %=  p 
      +6  q
    ==

?  In the latter, we replace the sample not of the value computed
by `p`, but of the context in which `p` is computed.  If `p` is a
leg - which it usually isn't in this case - then the two are
equivalent.  If `p` is an arm, rather than replacing the sample
of the tray that the arm produces, we are replacing the sample on
the arm's subject.  In general, this will do the wrong thing.
