---
layout: subpage
axis: doc-hoon
categories: tis rune
sort: 85
title: tistar
---



#[tistar, %tstr](#tstr)

##Syntax

`=*`, `tistar`, `[%tstr p=term q=wing r=twig]` is a natural hoon
that creates a `%bull`, or alias, type.

###Form

####Tall

    =*  p  q
        r

####Wide

    =*(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%tstr p=term q=wing r=twig]
      ==

###Expansion

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

##Notes

The `%bull` stem will be discussed more in chapter 11.  But
essentially, it wraps the subject with an alias in which `p`
means `q`.
