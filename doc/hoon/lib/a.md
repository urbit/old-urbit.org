---
layout: subpage
title: 2a Unsigned Math
axis: doc-hoon
categories: lib
sort: 1
---

This chapter covers basic mathematical operations on natural numbers (atoms), such as decremement, addition, subtraction etc. Simple comparison functions such as less-than, and a few useful functions for calculating axes within Nock nouns.

##++dec
    ++  dec                                                 ::::::  decrement
      ~/  %dec                                              ::  jet
      |=  a=@                                               ::  gate, sample atom a
      ~|  %decrement-underflow                              ::  crash message
      ?<  =(0 a)                                            ::  assert a is not 0
      =+  b=0                                               ::  push b is 0 
      |-  ^-  @                                             ::  trap, cast as atom  
      ?:  =(a +(b))                                         ::  if a equals b + 1
        b                                                   ::  then produce b
      $(b +(b))                                             ::  else loop trap

`++dec` takes an atom `a` and produces `a - 1`.

###Summary
`++dec` is a jetted arm (~/, jets, link).  
`++dec` creates a dry `%gold` gate using [|=](), which accepts an atomic sample `a`, [axil @](), with [=, the irregular form of ^=]().  
If `a` is 0, `++dec` crashes [?<]() and a crash message of `%decrement-underflow` is inserted into the stack trace [~|]().  
`b` is pushed on to the subject ([=+]()) and set to `0` using [^=]().  
A dry `%gold` trap is created ([|-]()), and its product is cast to an atom ([^-]()).  
If ([?:]()) the value of `b` incremented ([+, irregular form of .+]()) is equal ([.=]()) to `a`, then `b` is produced.  
Else, the `$` arm ([$]()) of the trap is activated ([%=]()), with the value of `b` set to `+(b)`.  

###Examples
    ~barred-tidset/try=> (dec 22.351)
    22.350
    ~barred-tidset/try=> (dec 1)
    0
    ~barred-tidset/try=> (dec 0)
    ! decrement-underflow
    ! exit


++  add                                                 ::::::  add
  ~/  %add                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast result as atom
  ?:  =(0 a)                                            ::  if a is 0
    b                                                   ::  then, produce b
  $(a (dec a), b +(b))                                  ::  loop, a - 1, b + 1


Summary: given two atoms 'a' and 'b', ++add counts 'a' down to '0' and 'b' up to 'b + a.'

++add is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample of a cell of atoms, labeled 'a' and 'b' (^=, link). The product of the gate is cast to an atom (^-, %axil, link). If 'a' is equal to 0, the gate produces b. Otherwise, the '$' arm of the gate is activated (%=, link), with the value of 'a' set to (dec a) (%-, dec, link), and 'b' set to +(b) (.+, link).  



++  sub                                                 ::::::::  subtract
  ~/  %sub                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ~|  %subtract-underflow                               ::  error report
  ^-  @                                                 ::  cast result as atom
  ?:  =(0 b)                                            ::  if b is 0
    a                                                   ::  then, produce a
  $(a (dec a), b (dec b))                               ::  loop, a - 1, b - 1

Summary: ++sub accepts two atoms a and b and produces a-b.

++sub is a jetted arm (~/, jets, link). ++sub creates a dry %gold gate (link) (|=, link), accepting a sample of a cell of atoms, labeled 'a' and 'b' (^=, link). If ++sub crashes a message of %subtract-underflow is inserted into the stack trace (~| link). ++sub will crash if given values for 'a' and 'b' such that a, the minuend, is less than b, the subtrahend, as atoms are restricted to the non-negative integers (dec, link). The product of ++sub is cast as an atom (^-, link). If (?:, link) 'b' is (.=, link) 0, the gate produces 'a'. Else, the '$' arm of the gate is activated, (%=, link), with the value of a set to (dec a) (dec, link) and the value of 'b' set to (dec b) (dec, link).



++  mul                                                 ::  multiply
  ~/  %mul                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast as atom
  =+  c=0                                               ::  push c is 0
  |-                                                    ::  trap 
  ?:  =(0 a)                                            ::  if a is 0
    c                                                   ::  then, produce c
  $(a (dec a), c (add b c))                             ::  loop, a - 1, c + b

Summary: ++mul accepts two atoms a and b and produces the product a*b.

++mul is a jetted arm (~/, jets, link). ++mul creates a dry %gold gate (link) (|=, link), accepting a sample cell of atoms, labeled 'a' and 'b' (^=, link). The result of ++mul is cast as an atom(^-, link). The variable 'c' is pushed onto the sample and set equal to 0 (+=, link). If (?:, link) 'a' is equal to zero, the gate returns 'c'. Else, the '$' arm of the gate is activated, (%=, link), with the value of 'a' set to (dec a) (dec, link), and the value of 'c' set to (add b c).

++  div                                                 ::  divide
  ~/  %div                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast result as atom
  ~|  'div'                                             ::  error report
  ?<  =(0 b)                                            ::  assert b is not 0
  =+  c=0                                               ::  push c is 0
  |-                                                    ::  trap
  ?:  (lth a b)                                         ::  if a less than b
    c                                                   ::  then, produce c
  $(a (sub a b), c +(c))                                ::  loop, a - b, c + 1

Summary: ++div accepts two atoms a and b and produces a/b as an atom.  

++div is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++div is cast to an atom (^-, link). If 'b' is equal to 0, ++div crashes (?<, link) and a crash message of %'div' is inserted into the stack trace (~|, link). The variable 'c' is pushed onto the sample and set equal to 0.  A dry %gold trap is created (|-, link), giving its unnamed arm, '$', the ability to loop if necessary. If (?:, link) 'a' is less than 'b', then ++div returns 'c'. Else the arm '$' (link) is reactivated (%=, link), with the value of 'a' set to (sub a b), and the value of 'c' set to '+(c)' (.+, link). 


++  mod                                                 ::  remainder
  ~/  %mod                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast as atom
  ?<  =(0 b)                                            ::  assert b is not 0
  (sub a (mul b (div a b)))                             ::  a - (a / b) * b

Summary: ++mod accepts two atoms a and b and produces a%b as an atom.

Given two atoms 'a' and 'b', ++mod divides 'a' by 'b', multiplies the result by 'b', and then subtracts this from a to find the remainder. 


::::::  Comparisons

::
++  lth                                                 ::  less-than
  ~/  %lth                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  ?                                                 ::  cast result loobean
  &  !=(a b)                                            ::  logical &, a != b 
  |-                                                    ::  trap
    |  =(0 a)                                           ::  logical or, a != b 
  &  !=(0 b)                                            ::  logical &, 0 != b
    $(a (dec a), b (dec b))                             ::  loop, a - 1, b -1

Summary: ++lth takes two atoms a and b and produces a loobean `a<b`.

++lth is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++lth is cast to a loobean (^-, link). The last five lines are encompassed by a logical and statement. If a is equal to be, ++lte immediately returns false. If they are not equal, a trap (|-,link) is declared, containing a logical or (|, link) statement. If 'a' is 0, then true is returned. If not, the next part of the or statement is examined, which is a logical and statement whose first condition is 'b' not equal to 0. If this is false, ++lth returns false. If this is true, the '$' arm of the trap is reactivated, with the values of both 'a' and 'b' both decremented. 

++  lte                                                 ::  less-equal
  ~/  %lte                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  |  =(a b)                                             ::  logical or, a == b
    (lth a b)                                           ::  a less than b 


Summary: ++lte takes two atoms a and b and produces a loobean `a<=b`.

++lte is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. A logical 'or'(|, link) operator is then used. The first condition it accepts is whether 'a' is equal to 'b' (.=, link). The second is whether 'a' is less than 'b', which is determined by a call to ++lth (link). If either statement is true, true is returned.  


++  gth                                                 ::  greater-than
  ~/  %gth                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  ?                                                 ::  cast result loobean
  !(lte a b)                                            ::  a not <= b

Summary: ++gth takes two atoms a and b and produces a loobean `a>b`.

++gth is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++gth is cast to a loobean (^-, link). Using the ++lte (link) function gth tests whether 'a' is not less than or equal to 'b'. If the statement returns true, so does ++gth.   




++  gte                                                 ::  greater-equal
  ~/  %gte
  |=  [a=@ b=@]
  ^-  ?
  !(lth a b)


Summary: ++gte takes two atoms a and b and produces a loobean `a>=b`.

++gth is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++gth is cast to a loobean (^-, link). Using the ++lth (link) function, gte tests whether 'a' is not less than 'b'. If the statement returns true, so does ++gte. 


++  max                                                 ::  maximum
  ~/  %max                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair 
  ^-  @                                                 ::  cast result to atom
  ?:  (gth a b)                                         ::  if a > b
    a                                                   ::  then, return a
  b                                                     ::  else, return b

Summary: ++max takes two atoms a and b and produces the larger of the two.

++max is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++max is cast to an atom (^-, link).If (?:, link) 'a' is greater than 'b' (++gth b), 'a' is returned. Else 'b' is returned.  

++  min                                                 ::  minimum
  ~/  %min                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast result to atom
  ?:  (lth a b)                                         ::  if a less than b
    a                                                   ::  then, return a
  b                                                     ::  else, return b

Summary: ++min takes two atoms a and b and produces the smaller of the two.

++min is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++min is cast to an atom (^-, link).If (?:, link) 'a' is less than 'b' (++gth, link), 'a' is returned. Else 'b' is returned.


::::::  Nock tree calculations

::
++  cap                                                 ::  tree head irregular form of $?, read the tile doc. 
  ~/  %cap                                              ::  jet
  |=  a=@                                               ::  gate, sample @
  ^-  ?(%2 %3)                                          ::  cast as %2 or %3
  ?-  a                                                 ::  switch: if a is...
    %2        %2                                        ::  %2, return %2
    %3        %3                                        ::  %3, return %3
    ?(%0 %1)  !!                                        ::  %0 or %1, crash
    *         $(a (div a 2))                            ::  *, loop a / 2
  ==

Summary: ++cap takes an atom `a` and produces %2 or %3 indicating if `a` is an address in the head (%2) or the tail (%3).

++cap is a jetted arm that (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample atom labeled 'a'. The result is cast to either the fern %2, or the fern %3. If a is %2 or %3, return either %2 or %3 respectively. If it is either the fern %0 or %1, ++cap crashes. If 'a' is any other noun, the '$' arm is reactivated, this time with the value of 'a' set to 'a/2'. This process repeats until 'a' hits one of the aforementioned switches. 



++  mas                                                 ::  tree body
  ~/  %mas                                              ::  jet
  |=  a=@                                               ::  gate, sample @
  ^-  @                                                 ::  cast result to atom.
  ?-  a                                                 ::  switch: if a is...
    1   !!                                              ::  1, then crash
    2   1                                               ::  2, then return 1
    3   1                                               ::  3, then return 1                                                                       
    *   (add (mod a 2) (mul $(a (div a 2)) 2))          ::  *, a%2 + recurse(a/2 *2=) 
  ==

Summary: ++mas takes an atom `a` and produces the axis of `a` within the head or the tail.

++mas is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|= link), accepting a sample labeled 'a'. Its result is cast to an atom (^-, link). ++mas uses a switch (?-, link) to produce a crash if 'a' is 1, 1 if 'a' is 2 or 3. If 'a' is 2 or 3, it returns 1. If 'a' is any other noun (*, link), ++mas produces the sum of a % 2 and the product of ++mas (a/2) and 2.    


++  peg                                                 ::  tree connect
  ~/  %peg                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair  
  ^-  @                                                 ::  cast result to atom
  ?-  b                                                 ::  switch: if b is...
    1   a                                               ::  1, then return a
    2   (mul a 2)                                       ::  2, then return a*2  
    3   +((mul a 2))                                    ::  3, then ret +(a*2)
    *   (add (mod b 2) (mul $(b (div b 2)) 2))          ::  *, b%2+recurse((b/2) * 2) 
  ==
  
Summary: ++peg takes two atoms a and b and produces the axis of b within the axis of a