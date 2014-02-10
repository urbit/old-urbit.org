---
layout: subpage
category: zap
title: zapcab
---

`!_`,`zapcab`, `[%zpcb p=spot q=twig]` is a natural hoon that puts
debugging information in the stack trace.

###Definition###

    ++  twig  
      $%  twig
        [%zpcb p=spot q=twig] 
      ==
    ++  spot  ,[p=path q=pint]
    ++  path  (list span) 
    ++  span  ,@ta
    ++  pint  ,[p=[p=@ q=@] q=[p=@ q=@]]

###Compilation###
    
    ++  mint
      ?-    gen
          [%zpcb *]  
        ~_  (show %o p.gen)
        =+  hum=$(gen q.gen)
        [p.hum [%10 [%spot %1 p.gen] q.hum]]
      ==

###Notes###

The parser produces `%zpcb` only within a `!:`.  `%zpcb` will
also hose your tail call elimination, so beware.
