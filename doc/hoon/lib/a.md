---
layout: subpage
title: 2c Unsigned Math
axis: doc-hoon
categories: lib
sort: 1
---

This chapter covers....

##++bex

    ++  bex                                                 ::::::  binary exponent
      ~/  %bex                                              ::  jet
      |=  a=@                                               ::  gate, atom sample 
      ^-  @                                                 ::  cast result as atom
      ?:  =(0 a)                                            ::  if a is 0
        1                                                   ::  then, produce 1
      (mul 2 $(a (dec a)))                                  ::  mul 2*2 n times 


++bex takes an atom a and returns 2^a

###Summary
++bex is a [jetted arm]() which creates a dry %gold gate using [|=](), which accepts an atomic sample, [axil @]() labeled 'a' with [=, the irregular form of ^=](). The result of ++bex is then cast to an atom [^-](). If 'a' is equal to 0, then ++bex returns 1. Otheriwse, ++bex returns the product of 2 and ++bex with the value of a replaced by [dec a](). 

###Examples
~ronrem-lonsem/try=> (bex 3)
8
~ronrem-lonsem/try=> (bex 1)
2
~ronrem-lonsem/try=> (bex 42)
4.398.046.511.104
~ronrem-lonsem/try=> (bex 0)
1


##++can

    ++  can                                                 ::  assemble
      ~/  %can                                              ::  jet
      |=  [a=bloq b=(list ,[p=@ q=@])]                      ::  gate, sample: bloq, list 
      ^-  @                                                 ::  cast result to atom
      ?~  b                                                 ::  if p is ~
        0                                                   ::  then, return 0
      (mix (end a p.i.b q.i.b) (lsh a p.i.b $(b t.b)))      ::  else, 
    ::
++  cat                                                 ::  concatenate
  ~/  %cat
  |=  [a=bloq b=@ c=@]
  (add (lsh a (met a b) c) b)
::
++  cut                                                 ::  slice
  ~/  %cut
  |=  [a=bloq [b=@ c=@] d=@]
  (end a c (rsh a b d))
::
++  end                                                 ::  tail
  ~/  %end                                              ::  jet
  |=  [a=bloq b=@ c=@]                                  ::
  (mod c (bex (mul (bex a) b)))
::
++  lsh                                                 ::  left-shift
  ~/  %lsh
  |=  [a=bloq b=@ c=@]
  (mul (bex (mul (bex a) b)) c)
::
++  met                                                 ::  measure
  ~/  %met
  |=  [a=bloq b=@]
  ^-  @
  =+  c=0
  |-
  ?:  =(0 b)
    c
  $(b (rsh a 1 b), c +(c))
::
++  rap                                                 ::  assemble nonzero
  ~/  %rap
  |=  [a=bloq b=(list ,@)]
  ^-  @
  ?@  b
    0
  (cat a i.b $(b t.b))
::
++  rep                                                 ::  assemble single
  ~/  %rep
  |=  [a=bloq b=(list ,@)]
  ^-  @
  =+  c=0
  |-
  ?@  b
    0
  (con (lsh a c (end a 1 i.b)) $(c +(c), b t.b))
::
++  rip                                                 ::  disassemble
  ~/  %rip
  |=  [a=bloq b=@]
  ^-  (list ,@)
  ?:  =(0 b)
    ~
  [(end a 1 b) $(b (rsh a 1 b))]
::


##++rsh

    ++  rsh                                                 ::  right-shift
      ~/  %rsh                                              ::  jet 
      |=  [a=bloq b=@ c=@]                                  ::  gate, bloq, 2 @ sample
      (div c (bex (mul (bex a) b)))                         ::  c / 2^(2^a * b)

++rsh takes an atom 'c', and shifts its binary code over by 'b' number of bloqs of size 'a'

###Summary

###Examples
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cB, bit logic                ::
::
++  con                                                 ::  binary or
  ~/  %con
  |=  [a=@ b=@]
  =+  [c=0 d=0]
  |-  ^-  @
  ?:  ?&(=(0 a) =(0 b))
    d
  %=  $
    a   (rsh 0 1 a)
    b   (rsh 0 1 b)
    c   +(c)
    d   (add d (lsh 0 c ?&(=(0 (end 0 1 a)) =(0 (end 0 1 b)))))
  ==
::
++  dis                                                 ::  binary and
  ~/  %dis
  |=  [a=@ b=@]
  =|  [c=@ d=@]
  |-  ^-  @
  ?:  ?|(=(0 a) =(0 b))
    d
  %=  $
    a   (rsh 0 1 a)
    b   (rsh 0 1 b)
    c   +(c)
    d   (add d (lsh 0 c ?|(=(0 (end 0 1 a)) =(0 (end 0 1 b)))))
  ==
::
++  mix                                                 ::  binary xor
  ~/  %mix                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, 2 atom sample
  ^-  @                                                 ::  cast result to atom
  =+  [c=0 d=0]                                         ::  c=0, d=0 to sample
  |-                                                    ::  trap
  ?:  ?&(=(0 a) =(0 b))                                 ::  If 'a' & 'b' are 0
    d                                                   ::  Then, return 0, (d)
  %=  $                                                 ::  Recall ++ mix with:
    a   (rsh 0 1 a)                                     ::  
    b   (rsh 0 1 b)
    c   +(c)
    d   (add d (lsh 0 c =((end 0 1 a) (end 0 1 b))))
  ==

