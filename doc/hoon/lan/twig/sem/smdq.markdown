---
layout: subpage
category: sem
title: semdoq
---

`semdoq`, `[%smdq p=(list beer)]` is a synthetic hoon used to
make strings, interpreted or not.

###Definition###

    ++  twig  
      $%  [%smdq p=twig]
      ==
    ++  beer  $|(@ [~ p=twig])

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%smdq *]                                   ::
        :+  %tsgr  [%ktts %v ~ 1]                     ::  =>  v=.
        :-  %brhp                                     ::  |-
        :+  %ktls                                     ::  ^+
          :-  %brhp                                   ::  |-
          :^    %wtcl                                 ::  ?:
              [%bczp %bean]                           ::  ?
            [%bczp %null]                             ::  ~
          :-  [%ktts %i [%dtzy 'tD' _@]]              ::  :-  i=~~
          [%ktts %t [%cnzy %$]]                       ::  t=$
        |-  ^-  twig                                  ::
        ?~  p.gen                                     ::
          [%bczp %null]                               ::  ~
        =+  res=$(p.gen t.p.gen)                      ::
        ^-  twig                                      ::
        ?@  i.p.gen                                   ::
          [[%dtzy 'tD' i.p.gen] res]                  ::  [~~{i.p.gen} {res}]
        :+  %tsls                                     ::
          :-  :+  %ktts                               ::  ^=
                %a                                    ::  a
              :+  %ktls                               ::  ^+
                [%cnzy %$]                            ::  $
              [%tsgr [%cnzy %v] p.i.p.gen]            ::  =>(v {p.i.p.gen})
          [%ktts %b res]                              ::  b={res}
        ^-  twig                                      ::
        :-  %brhp                                     ::  |-
        :^    %wtpt                                   ::  ?@
            [%a ~]                                    ::  a
          [%cnzy %b]                                  ::  b
        :-  [%tsgl [~ 2] [%cnzy %a]]                  ::  :-  -.a
        :+  %cnts                                     ::  %=
          [%$ ~]                                      ::  $
        [[[%a ~] [%tsgl [~ 3] [%cnzy %a]]] ~]         ::  a  +.a
      ==

###Notes###

It's not necessary to understand this horrible thing.  All it
does is to assemble a string, which is a list of either
Unicode bytes or interpolation twigs which produce a list of
Unicode bytes, without depending on any functionality in the 
target subject.
