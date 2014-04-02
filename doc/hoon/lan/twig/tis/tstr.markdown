---
layout: subpage
category: tis
title: tistar
---

`=*`, `tistar`, `[%tstr p=term q=wing r=twig]` is a natural hoon
that creates a `%bull`, or alias, type.

###Definition###

    ++  twig  
      $%  [%tstr p=term q=wing r=twig]
      ==

###Regular form (tall)###

    =*  p  q
    r

###Regular form (wide)###

    =*(p q r)

###Compilation###
    
    ++  mint
      ?-  gen
        [%tstr *]  $(gen r.gen, sut (busk p.gen q.gen))
      ==
    ::
    ++  busk
      ~/  %busk
      |=  [cog=term hyp=wing]
      ^-  type
      (bull [cog hyp (seep %both hyp)] sut)
    ::
    ++  bull
      |=  [bid=twin der=type]
      ^-  type
      ?:(|(=(%void der) =(%void s.bid)) %void [%bull bid der])

###Notes###

The `%bull` stem will be discussed more in chapter 11.  But
essentially, it wraps the subject with an alias in which `p`
means `q`.
