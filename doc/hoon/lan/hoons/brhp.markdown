---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 17
title: barhep
---


#[barhep, `|-`, %brhp](#brhp)

##Syntax

`|-`, `barhep`, `[%brhp p=twig]` is a synthetic rune that produces
a dry `%gold` trap and kicks it (cores, link). `|-` takes a twig. 

###Form

`p` is a twig

####Tall

    |-
    p

####Wide

    |-(p)

####Irregular
None

###Reduction

    |-  p

reduces to

    =<  $
    |.  p

which further reduces [|. link] to

    =<  $
    |%  ++  $
        p
    --

###Examples

++  dec                                                 ::  decrement
  ~/  %dec
  |=  a=@
  ~|  %decrement-underflow
  ?<  =(0 a)
  =+  b=0
  |-  ^-  @
  ?:  =(a +(b))
    b
  $(b +(b))

In ++dec, `|-` creates a trap that contains the test and looping semantics. For looping, the `$` arm of the trap is called using `$(b +(b))`. (See `%=`)

++  mul                                                 ::  multiply
  ~/  %mul
  |=  [a=@ b=@]
  ^-  @
  =+  c=0
  |-
  ?:  =(0 a)
    c
  $(a (dec a), c (add b c))

In ++mul, we create a counter `c` (with =+, link) that we test against and
update each loop. That is, we loop we want to preserve the value of `c` from
the last loop.  If we push `c=0` onto our subject within the loop, we will set
the value of `c` as 0 every loop. We use `|-` to create an inner core, so that
when we loop (`%=`, link) we only loop over the expressions within the `|-`.

##Semantics

`%brhp` is a twig.

###Definition###

    ++  twig  
      $%  [%brhp p=twig]
      ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brhp *]  [%tsgl [%cnzy %$] [%brdt p.gen]]
      ==

##Notes
