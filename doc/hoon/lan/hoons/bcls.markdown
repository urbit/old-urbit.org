---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 6
title: buclus
---

#buclus `$+` %bcls

##Syntax

`$+`, `buclus`, a tile for a gate which accepts `p` and produces `q`. The spectre of function signatures once again rears its ugly head - but `$+(p q)` is no different from `$_(|+(p _q))`.

###Form
`p` is a tile 
`q` is a tile


####Tall

    $+  p  q

####Wide

    $+(p q)

####Irregular
None

###Reduction

    $+  p  q

reduces to

    $_  |+  p  _q

###Examples

    ++  sort                                                ::  quicksort
      ~/  %sort
      !:
      |*  [a=(list) b=$+([* *] ?)]
      =>  .(a ^.(homo a))
      |-  ^+  a
      ?~  a  ~
      %+  weld
        $(a (skim t.a |=(c=_i.a (b c i.a))))
      ^+  t.a
      [i.a $(a (skim t.a |=(c=_i.a !(b c i.a))))]

In ++sort, `$+` is a tile for a comparator gate, which takes two nouns and produces a loobean.

##Semantics

`$+` is a tile.

###Definition

     ++  noil
      |=  tol=?
      =<  ;~  pfix  buc
            %-  stew  
            ^.  stet  ^.  limo
              :-  '+'
                %+  cook
                  |=([a=tile b=tile] [%weed [%brls a [%bccb b]]])
                ;~(pfix lus (toad exqb))
                ==
            ==
          ==

###Expansion
None

###Notes

See the discussion of tiles in chapter 9.
