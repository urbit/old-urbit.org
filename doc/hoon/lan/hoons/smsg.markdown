---
layout: subpage
axis: doc-hoon
categories: sem rune
sort: 74
title: semsig
---



#[semsig, `;~`, %smsg](#smsg)

##Syntax

`semsig`, `[%smsg p=(list beer)]` is a synthetic hoon used to
make strings, interpreted or not.
###Form

####Tall

    ;~  p
      i.q
      i.t.q
      i.t.t.q
    ==

####Wide

    ;~(p i.q i.t.q i.t.t.q)


####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%smsg p=twig q=tusk]
      ==
    ++  tusk  (list twig)

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%smsg *]                                   ::
        |-  ^-  twig                                  ::
        ?-  q.gen                                     ::
            ~       ~|(%open-smsg !!)                 ::
            ^                                         ::
          :+  %tsgr  [%ktts %v ~ 1]                   ::  =>  v=.
          |-  ^-  twig                                ::
          ?:  ?=(~ t.q.gen)                           ::
            [%tsgr [%cnzy %v] i.q.gen]                ::  =>(v {i.q.gen})
          :+  %tsls  [%ktts %a $(q.gen t.q.gen)]      ::  =+  ^=  a
          :+  %tsls                                   ::    {$(q.gen t.q.gen)}
            [%ktts %b [%tsgr [%cnzy %v] i.q.gen]]     ::  =+  ^=  b
          :+  %tsls                                   ::    =>(v {i.q.gen})
            [%ktts %c [%tsgl [~ 6] [%cnzy %b]]]       ::  =+  c=+6.b
          :-  %brdt                                   ::  |.
          :^    %cnls                                 ::  %+
              [%tsgr [%cnzy %v] p.gen]                ::      =>(v {p.gen})
            [%cnhp [%cnzy %b] [%cnzy %c] ~]           ::    (b c)
          [%cnts [%a ~] [[[[%& 6] ~] [%cnzy %c]] ~]]  ::  a(+6 c)
        ==
      ==

##Notes

See the discussion of gonads in chapter 11.
