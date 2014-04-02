---
layout: subpage
category: sem
title: semsig
---

`;~`, `semsig`, `[%smsg p=twig q=tusk]` is a synthetic hoon that
uses `p` to 

###Definition###

    ++  twig  
      $%  [%smsg p=twig q=tusk]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

    ;~  p
      i.q
      i.t.q
      i.t.t.q
    ==

###Regular form (wide)###

    ;~(p i.q i.t.q i.t.t.q)

###Expansion###
    
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

###Notes###

See the discussion of gonads in chapter 11.
