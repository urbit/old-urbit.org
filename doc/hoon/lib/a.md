---
layout: subpage
title: 2a Unsigned Math
axis: doc-hoon
categories: lib
sort: 1
---
chapter 2a, basic unsigned math  

This chapter covers basic mathematical operations on natural numbers (atoms), such as decremement, addition, subtraction etc. Simple comparison functions such as less-than, and a few useful functions for calculating axes within Nock nouns.

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


Summary: given an atom 'a', ++dec counts the variable 'b' up from 0 to 'a - 1'.

Examples

++dec is a jetted arm (~/, jets, link) which creates a dry %gold gate (|=, link), accepting an atomic sample (axil @, link, labeled 'a' (^=, link). 
If 'a' is equal to 0, ++dec crashes (?<, link) and a crash message of %decrement-underflow is inserted into the stack trace (~|, link). 
A variable b is set to 0 (^=, link) and is pushed onto the subject (=+ link). A dry %gold trap is created (|-, link), and its product is cast to an atom (^-, link).
If (?:, link) the value of 'b' incremented (.+, link) is equal (.=, link) to 'a', then 'b' is produced. Else, the `$` arm ($, link) of the trap is activated (%=, link), with the value of 'b' set to +(b).



++  add                                                 ::::::  add
  ~/  %add                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast result as atom
  ?:  =(0 a)                                            ::  if a is 0
    b                                                   ::  then, produce b
  $(a (dec a), b +(b))                                  ::  loop, a - 1, b + 1


Summary: given two atoms 'a' and 'b', ++add counts 'a' down to '0' and 'b' up to 'b + a.'

++add is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting an sample of a pair of atoms, labeled 'a' and 'b' (^=, link). The product of the gate is cast to an atom (^-, %axil, link). If 'a' is equal to 0, the gate produces b. Else, the '$' arm of the gate is activated (%=, link), with the value of 'a' set to (dec a) (%-, dec, link), and 'b' set to +(b) (.+, link).  



++  sub                                                 ::::::::  subtract
  ~/  %sub                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ~|  %subtract-underflow                               ::  error report
  ^-  @                                                 ::  cast result as atom
  ?:  =(0 b)                                            ::  if b is 0
    a                                                   ::  then, produce a
  $(a (dec a), b (dec b))                               ::  loop, a - 1, b - 1

Summary: given two atoms 'a' and 'b', ++sub counts 'b' down to '0' and 'a' down to 'a - b'


++sub is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting an sample of a pair of atoms, labeled 'a' and 'b' (^=, link). If ++sub crashes a message of %subtract-underflow is inserted into the stack trace. ++sub will crash if given values for 'a' and 'b' such that a, the minuend, is less than b, the subtrahend, as atoms are restricted to the non-negative integers (dec, link). The product of ++sub is cast as an atom (^-, link). If (?:, link) 'b' is equal (.=, link) to 0, the gate produces 'a'. Else, the '$' arm of the gate is activated, (%=, link), with the value of a set to (dec a) (dec, link) and the value of 'b' set to (dec b) (dec, link).

 given two atoms 'a' and 'b', ++sub counts 'b' down to '0' and 'a' down to 'a - b'


++  mul                                                 ::  multiply
  ~/  %mul                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast as atom
  =+  c=0                                               ::  push c is 0
  |-                                                    ::  trap 
  ?:  =(0 a)                                            ::  if a is 0
    c                                                   ::  then, produce c
  $(a (dec a), c (add b c))                             ::  loop, a - 1, c + b

Summary: given two atoms 'a' and 'b', ++mul counts 'b' down to '0', adding b to c everytime this is done until 'a' hits zero.

++mul is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b' (^=, link). The result of ++mul is cast as an atom(^-, link). The variable 'c' is pushed onto the sample and set equal to 0 (+=, link). If (?:, link) 'a' is equal to zero, the gate returns 'c'. Else, the '$' arm of the gate is reactivated, (%=, link), with the value of 'a' set to (dec a) (dec, link), and the value of 'c' set to (add b c).

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

Summary: given two atoms 'a' and 'b', ++div subtracts 'b' from 'a' until 'a' is less than 'b', at which point 'c', the number of times b has gone into 'a', is returned.   

++div is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++div is cast to an atom (^-, link). If 'b' is equal to 0, ++div crashes (?<, link) and a crash message of %'div' is inserted into the stack trace (~|, link). The variable 'c' is pushed onto the sample and set equal to 0.  A dry %gold trap is created (|-, link), giving its unnamed arm, '$', the ability to loop if necessary. If (?:, link) 'a' is less than 'b', then ++div returns 'c'. Else the arm '$' (link) is reactivated (%=, link), with the value of 'a' set to (sub a b), and the value of 'c' set to '+(c)' (.+, link). 


++  mod                                                 ::  remainder
  ~/  %mod                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast as atom
  ?<  =(0 b)                                            ::  assert b is not 0
  (sub a (mul b (div a b)))                             ::  a - (a / b) * b

Summary: given two atoms 'a' and 'b', ++mod divides 'a' by 'b', multiplies the result by 'b', and then subtracts this from a to find the remainder. 


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

Summary: given two atoms 'a' and 'b', ++lth decrements both 'a' and 'b' until one of them hits 0. If 'a' reaches 0 first, ++lth returns true. If 'b' arrives first, it returns false.

++lth is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++lth is cast to a loobean (^-, link). The last five lines are encompassed by a logical and statement. If a is equal to be, ++lte immediately returns false. If they are not equal, a trap (|-,link) is declared, containing a logical or (|, link) statement. If 'a' is 0, then true is returned. If not, the next part of the or statement is examined, which is a logical and statement whose first condition is 'b' not equal to 0. If this is false, ++lth returns false. If this is true, the '$' arm of the trap is reactivated, with the values of both 'a' and 'b' both decremented. 

++  lte                                                 ::  less-equal
  ~/  %lte                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  |  =(a b)                                             ::  logical or, a == b
    (lth a b)                                           ::  a less than b 


Summary: given two atoms 'a' and 'b', ++lte uses a logical or statement to test whether a is equal to, or less than b. To test whether a is less than b, ++lte calls lth. If either statement is true, ++lte returns true. 

++lte is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. A logical 'or'(|, link) operator is then used. The first condition it accepts is whether 'a' is equal to 'b' (.=, link). The second is whether 'a' is less than 'b', which is determined by a call to ++lth (link). If either statement is true, true is returned.  


++  gth                                                 ::  greater-than
  ~/  %gth                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  ?                                                 ::  cast result loobean
  !(lte a b)                                            ::  a not <= b

Summary: given two atoms 'a' and 'b', ++gth tests if a is not less than or equal to b using the ++lte arm. If this statement returns true, ++gth returns true.

++gth is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++gth is cast to a loobean (^-, link). Using the ++lte (link) function gth tests whether 'a' is not less than or equal to 'b'. If the statement returns true, so does ++gth.   




++  gte                                                 ::  greater-equal
  ~/  %gte
  |=  [a=@ b=@]
  ^-  ?
  !(lth a b)

::  Produce a loobean of whether a >= b

Summary: given two atoms 'a' and 'b', ++gte tests if a is not less than to b using the ++lth arm. If this statement returns true, ++gth returns true.

++gth is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++gth is cast to a loobean (^-, link). Using the ++lth (link) function, gte tests whether 'a' is not less than 'b'. If the statement returns true, so does ++gte. 


++  max                                                 ::  maximum
  ~/  %max                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair 
  ^-  @                                                 ::  cast result to atom
  ?:  (gth a b)                                         ::  if a > b
    a                                                   ::  then, return a
  b                                                     ::  else, return b

Summary: returns the larger number of the set that includes a and b. If they are equal, b is returned.

++max is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++max is cast to an atom (^-, link).If (?:, link) 'a' is greater than 'b' (++gth b), 'a' is returned. Else 'b' is returned.  

++  min                                                 ::  minimum
  ~/  %min                                              ::  jet
  |=  [a=@ b=@]                                         ::  gate, sample @ pair
  ^-  @                                                 ::  cast result to atom
  ?:  (lth a b)                                         ::  if a less than b
    a                                                   ::  then, return a
  b                                                     ::  else, return b

++min is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|=, link), accepting a sample pair of atoms, labeled 'a' and 'b'. The result of ++min is cast to an atom (^-, link).If (?:, link) 'a' is less than 'b' (++gth, link), 'a' is returned. Else 'b' is returned.

Summary: returns the smaller number of the set that includes a and b. If they are equal, b is returned.


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

Summary: ++cap determines whether address is in the head or tail of a noun. This is done by dividing 'a' by 2 until 'a' is either %2 or %3, at which point %2 or %3 is returned. If %0 or %1, crash, as 0 is not a valid address and address 1 is not a head or a tail. 

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

Summary: ++mas determines the axis of a noun within the head or the tail of a tree. It does this by recursing until a is equal to 2 or 3. If a is ever one ++mas crashes.

++mas is a jetted arm (~/, jets, link), which creates a dry %gold gate (link) (|= link), accepting a sample labeled 'a'. Its result is cast to an atom (^-, link). ++mas uses a switch (?-, link) to produce a crash if 'a' is 1, 1 if 'a' is 2 or 3. If 'a' is 2 or 3, it returns 1. If 'a' is any other noun (*, link), ++mas produces the sum of a % 2 and the product of ++mas (a/2) and 2.    



::  calculates axis within the head or the tail
::  a is always the same as (peg (cap a) (mas a))


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
::  calculates the axis of axis b within axis a

Summary: ++peg determines the axis of of axis b within axis a. 

<<<<<<< HEAD
## hoon.hoon section 2a
=======
>>>>>>> 4ef2770269ac90a6bca1bc784b3a66e5bc62dc44
