---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 110
title: zapwut
---



`!?`, `zapwut`, `[%zpwt p=twig]` is a synthetic hoon that
enforces a Hoon version restriction.

###Definition###

    ++  twig  
      $%  [%zpwt p=$|(p=@ [p=@ q=@]) q=twig]
      ==

###Regular form (tall)###

To declare code that runs only in Hoon 164K or newer:

    !?  164
    q

To declare code that runs only in 164K through 161K:

    !?  [164 161] 
    q

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%zpwt *]
        ?:  ?:  ?=(@ p.gen)
              (lte stub p.gen)
            &((lte stub p.p.gen) (gte stub q.p.gen))
          q.gen 
        ~|([%stub-fail stub p.gen] !!)
      ==
