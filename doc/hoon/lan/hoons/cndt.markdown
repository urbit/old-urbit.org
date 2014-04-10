---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 34
title: cendot
---


#[cendot, `%.`, %cndt](#cndt)

##Syntax

`%.`, `cendot`, `[%cndt p=twig q=twig]` is a synthetic hoon that
reverses the order of `%cnhp`.

###Form
`p` is a twig
`q` is a twig

####Tall

    %.  p
    q

####Wide

    %.(p q)

####Irregular
None

###Reduction

    %.  p
    q

reduces to

    %-  q
    p

###Examples

~waclux-tomwyc/try=> %.(42 dec)
41

In the above example, `%.` slams ++dec with the sample 42. 

##Semantics

###Definition

    ++  twig  
      $%  [%cndt p=twig q=twig]
      ==


###Expansion
 
    ++  open
      ^-  twig
      ?-    gen
          [%cndt *]
        [%cnhp q.gen [p.gen ~]]
      ==

##Notes

   
