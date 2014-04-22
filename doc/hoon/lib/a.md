---
layout: subpage
title: 2a Unsigned Math
arms: [++dec, ++add, ++sub, ++mul, ++div, ++mod, ++lth, ++lte, ++gth, ++gte, ++max, ++min, ++cap, ++mas, ++peg]
axis: doc-hoon
categories: lib
sort: 2
---

This chapter covers basic mathematical operations on natural numbers (atoms), such as decremement, addition, subtraction etc. Simple comparison functions such as less-than, and a few useful functions for calculating axes within Nock nouns.

<h2 id="++dec">++&nbsp;&nbsp;dec</h2>

####Decrement  
`++dec` takes an atom `a` and produces `a - 1`.

###Examples
    ~barred-tidset/try=> (dec 22.351)
    22.350
    ~barred-tidset/try=> (dec 1)
    0
    ~barred-tidset/try=> (dec 0)
    ! decrement-underflow
    ! exit

###Summary
    ++  dec                                                 ::::::  decrement
      ~/  %dec                                              ::  jet
      |=  a=@                                               ::  gate, sample atom
      ~|  %decrement-underflow                              ::  crash message
      ?<  =(0 a)                                            ::  assert a is not 0
      =+  b=0                                               ::  push b is 0
      |-  ^-  @                                             ::  trap, cast as atom
      ?:  =(a +(b))                                         ::  if a equals b + 1
        b                                                   ::  then produce b
      $(b +(b))                                             ::  else loop trap

`++dec` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).
`++dec` creates a dry `%gold` gate using [|=](/doc/hoon/lan/rune/#bartis), which accepts an atomic sample `a` of [axil @](/doc/hoon/lan/tile/#axil), with [=, the irregular form of ^=](/doc/hoon/lan/rune/#kettis).  
If `a` is 0, `++dec` crashes [(?<)](/doc/hoon/lan/rune/#wutgal) and a crash message of `%decrement-underflow` is inserted into the stack trace [(~|)](/doc/hoon/lan/rune/#sigbar).  
`b` is pushed on to the subject with [=+](/doc/hoon/lan/rune/#tislus) and set to `0` using [^=](/doc/hoon/lan/rune/#kettis).  
A dry %gold trap is created using [|-](/doc/hoon/lan/rune/barhep), and its product is cast to an atom with [^-](/doc/hoon/lan/rune/#kethep).  
If ([?:](/doc/hoon/lan/rune/#wutcol)) the value of `b` incremented ([+, irregular form of .+](/doc/hoon/lan/rune/#dotlus)) is equal ([.=](/doc/hoon/lan/rune/#dottis)) to `a`, then `b` is produced.  
Else, the `$` arm of the trap is activated ([%=](/doc/hoon/lan/rune/#centis)), with the value of `b` set to `+(b)`.  


<h2 id="++add">++&nbsp;&nbsp;add</h2>

####Addition  
Given two atoms `a` and `b`, `++add` counts `a` down to `0` and `b` up to `b` + `a`.

###Examples
     ~ronrem-lonsem/try=> (add 4 7)  
     11  
     ~ronrem-lonsem/try=> (add 543 959)  
     1.502  
     ~ronrem-lonsem/try=> (add 0 0)  
     0  

###Summary
    ++add
      ~/  %add                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, sam @ pair
      ^-  @                                                 ::  cast rslt to atom
      ?:  =(0 a)                                            ::  if a is 0
        b                                                   ::  then, produce b
      $(a (dec a), b +(b))                                  ::  loop, a - 1, b + 1

`++add` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++add` creates a dry %gold gate [|=](/doc/hoon/lan/rune/#bartis), which accepts a sample of a cell of atoms, labeled `a` and `b` with [^=](/doc/hoon/lan/rune/#kettis).  
The product of the gate is cast to an atom with [^-](/doc/hoon/lan/rune/#kethep).  
If `a` is equal to 0, then `b` is produced.  
Otherwise, the `$` arm of the gate is activated [(%=)](/doc/hoon/lan/rune/#centis), with the value of `a` set to (dec a)(/doc/hoon/lib/#++dec) [%-](/doc/hoon/lan/rune/#cenhep), and `b` set to +(b) [(.+)](/doc/hoon/lan/rune/#dotlus).  


<h2 id="++sub">++&nbsp;&nbsp;sub</h2>

####Subtraction  
`++sub` accepts two atoms, `a` and `b` and produces `a` - `b`.

###Examples
    ~ronrem-lonsem/try=> (sub 10 5)
    5
    ~ronrem-lonsem/try=> (sub 243 44)
    199
    ~ronrem-lonsem/try=> (sub 5 0)
    5
    ~ronrem-lonsem/try=> (sub 0 5)
    ! subtract-underflow
    ! exit

###Summary
    ++  sub                                                 ::  subtract  
      ~/  %sub                                              ::  jet  
      |=  [a=@ b=@]                                         ::  gate, 2 @ sample  
      ~|  %subtract-underflow                               ::  error report  
      ^-  @                                                 ::  cast res to atom  
      ?:  =(0 b)                                            ::  if b is 0  
        a                                                   ::  then, produce a  
      $(a (dec a), b (dec b))                               ::  loop, a - 1, b - 1  

`++sub` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).
`++sub` creates a dry %gold gate with [|=](/doc/hoon/lan/rune/#bartis), which accepts a sample of a cell of atoms, labeled `a` and `b` using [^=](/doc/hoon/lan/rune/#kettis).  
`++sub` will crash if given values for `a` and `b` such that `a`, the minuend, is less than `b`, the subtrahend, as atoms are restricted to the non-negative integers; if this happens, %subtract underflow is inserted into the stack trace [~|](/doc/hoon/lan/rune/#sigbar).  
The product of ++sub is cast as an atom with [^-](/doc/hoon/lan/rune/#kethep).  
If [(?:)](/doc/hoon/lan/rune/#wutcol) `b` is [=, the irregular form of ^=](/doc/hoon/lan/rune/#kettis) 0, then `++sub` produces `a`. Else, the `$` arm of the gate is activated [%=](/doc/hoon/lan/rune/#centis), with the value of `a` set to [(dec a)](/doc/hoon/lib/#++dec), and the value of `b` set to [(dec b)](/doc/hoon/lib/#++dec).


<h2 id="++mul">++&nbsp;&nbsp;mul</h2>

####Multiply  
++mul accepts two atoms a and b and produces the product `a` * `b` by adding `b` to a variable `c` `a` number of times

###Examples
    ~ronrem-lonsem/try=> (mul 5 3)
    15
    ~ronrem-lonsem/try=> (mul 1 0)
    0

###Summary
      ++  mul                                                 ::  multiply
        ~/  %mul                                              ::  jet
        |=  [a=@ b=@]                                         ::  gate, 2 atom sam
        ^-  @                                                 ::  cast as atom
        =+  c=0                                               ::  push c is 0
        |-                                                    ::  trap 
        ?:  =(0 a)                                            ::  if a is 0
          c                                                   ::  then, produce c
        $(a (dec a), c (add b c))                             ::  loop, a - 1, c+b

`++mul` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++mul` creates a dry %gold gate (link) [|=](/doc/hoon/lan/rune/#bartis), accepting a sample cell of atoms, labeled `a` and `b` with [^=](/doc/hoon/lan/rune/#kettis)).  
The result of `++mul` is cast as an atom [^-](/doc/hoon/lan/rune/#kethep).  
The variable `c` is pushed onto the sample and set equal to 0 with [=+](/doc/hoon/lan/rune/#tislus).  
If [?:](/doc/hoon/lan/rune/#wutcol) `a` is equal to 0, `++mul` produces `c`.  
Otherwise, the `$` arm of the [trap (|-)](/doc/hoon/lan/rune/#barhep) is activated [%=](/doc/hoon/lan/rune/#centis)), with the value of `a`set to [(dec a)](/doc/hoon/lib/#++dec), and the value of `c` set to [(add b c)](/doc/hoon/lib/#++add).


<h2 id="++div">++&nbsp;&nbsp;div</h2>

####Division  
`++div` accepts two atoms a and b and produces a / b as an atom.

###Examples
    ~ronrem-lonsem/try=> (div 20 4)
    5
    ~ronrem-lonsem/try=> (div 21 4)
    5
    ~ronrem-lonsem/try=> (div 20 0)
    ! exit


###Summary    
    ++  div                                                 ::  divide
      ~/  %div                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sam
      ^-  @                                                 ::  cast as atom
      ~|  'div'                                             ::  error report
      ?<  =(0 b)                                            ::  assert b is not 0
      =+  c=0                                               ::  push c is 0
      |-                                                    ::  trap
      ?:  (lth a b)                                         ::  if a less than b
        c                                                   ::  then, produce c
      $(a (sub a b), c +(c))                                ::  loop, a - b, c + 1
 
`++div` is a is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++div` creates a dry %gold gate [|=](/doc/hoon/lan/rune/#bartis), accepting a sample pair of atoms, labeled `a` and `b` using [^=](/doc/hoon/lan/rune/#kettis).  
 The product is cast to an atom with [^-](/doc/hoon/lan/rune/#kethep).  
 If [?:](/doc/hoon/lan/rune/#wutcol) `b` is equal to 0, `++div` crashes [(?<)](/doc/hoon/lan/rune/#wutgal), and a crash message of `%div' is inserted into the stack trace [(~|)](/doc/hoon/lan/rune/#sigbar).  
 The variable `c` is pushed onto the sample and set equal to 0.  
 A dry %gold trap is created with [|-](/doc/hoon/lan/rune/barhep), giving its unnamed arm, `$`, the ability to loop if necessary.  
 If [?:](/doc/hoon/lan/rune/#wutcol) `a` is less than `b`, then `++div` returns `c`.  
 Otherwise the arm `$` is reactivated [%=](/doc/hoon/lan/rune/#centis) with the value of `a` set to [(sub a b)](/doc/hoon/lib/#++sub), and the value of `c` set to `+(c)` [.+](/doc/hoon/lib/#dotlus). 


<h2 id="++mod">++&nbsp;&nbsp;mod</h2>

####Modulus  
`++mod` accepts two atoms `a` and `b` and produces a%b as an atom.

###Examples
    ~ronrem-lonsem/try=> (mod 20 5)
    0
    ~ronrem-lonsem/try=> (mod 20 6)
    2
    ~ronrem-lonsem/try=> (mod 6 20)
    6
    ~ronrem-lonsem/try=> (mod 20 0)
    ! exit

###Summary
    ++  mod                                                 ::  remainder
      ~/  %mod                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, @ pair sam
      ^-  @                                                 ::  cast as atom
      ?<  =(0 b)                                            ::  assert b is not 0
      (sub a (mul b (div a b)))                             ::  a - (a / b) * b

`++mod` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).
`++mod` creates a %dry golden gate using [|=](/doc/hoon/lan/rune/#bartis), which accepts two atoms, labeled `a` and `b` with [^=](/doc/hoon/lan/rune/#kettis).  
The product is cast as an atom with [^=](/doc/hoon/lan/rune/#kettis).  
`++mod` uses [?<](/doc/hoon/lan/rune/#wutgal) to assert that `b` is not zero.  
`++mod` produces the difference between `a` and the product of `b` ([++mul](/doc/hoon/lib/#++mul)) and the quotient of `a` divided by ([++div](/doc/hoon/lib/#++div)) `b`.  


<h2 id="++lth">++&nbsp;&nbsp;lth</h2>

####Less than  
++lth takes two atoms `a` and `b` and produces a loobean `a`=`b`.

###Examples
    ~ronrem-lonsem/try=> (lth 4 5)
    %.y
    ~ronrem-lonsem/try=> (lth 5 4)
    %.n
    ~ronrem-lonsem/try=> (lth 5 5)
    %.n
    ~ronrem-lonsem/try=> (lth 5 0)
    %.n

###Summary
    ++  lth                                                 ::  less-than
      ~/  %lth                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sample
      ^-  ?                                                 ::  cast to loobean
      &  !=(a b)                                            ::  logical &, a != b 
      |-                                                    ::  trap
        |  =(0 a)                                           ::  logical or, a != b
      &  !=(0 b)                                            ::  logical &, 0 != b
        $(a (dec a), b (dec b))                             ::  loop, a - 1, b -1

`++lth` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++lth` creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), accepting a sample pair of atoms, labeled `a` and `b` with [^=](/doc/hoon/lan/rune/#kettis).  
The product of `++lth` is cast to a loobean with [^-](/doc/hoon/lan/rune/#kethep). 
The last five lines are encompassed by a logical and statement:  
 If `a` is equal to `b`, `++lth` immediately returns false. 
 If they are not equal, a trap is declared with [|-](/doc/hoon/lan/rune/barhep), containing a logical or [|](the irregular form of ?|)](/doc/hoon/lan/rune/#wutbar) statement.  
 If `a` is 0, then true is returned.  
 If not, the next part of the or statement is examined, which is a logical and statement whose first condition is `b` not equal to 0.  
 If this is false, `++lth` returns false.  
 If this is true, the `$` arm of the trap is reactivated, with the values of both `a` and `b` both decremented ([++dec](/doc/hoon/lib/#++dec)). 


<h2 id="++lte">++&nbsp;&nbsp;lte</h2>

####Less than or equal to.  
++lte takes two atoms `a` and `b` and produces a loobean `a`<=`b`.

###Examples
    ~ronrem-lonsem/try=> (lte 4 5)
    %.y
    ~ronrem-lonsem/try=> (lte 5 4)
    %.n
    ~ronrem-lonsem/try=> (lte 5 5)
    %.y
    ~ronrem-lonsem/try=> (lte 0 0)
    %.y

###Summary
    ++  lte                                                 ::  less-equal
      ~/  %lte                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sam
      |  =(a b)                                             ::  logical or, a == b
        (lth a b)                                           ::  a less than b 

`++lte` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++lte` creates a dry %gold gate with [|=](/doc/hoon/lan/rune/#bartis), accepting a sample pair of atoms, labeled `a` and `b` with [^=](/doc/hoon/lan/rune/#kettis).  
A logical `or`[|](the irregular form of ?|)](/doc/hoon/lan/rune/#wutbar) operator is then used:  
The first condition is whether `a` is equal to `b` or not[.=](/doc/hoon/lan/rune/#dottis).  
The second is whether `a` is less than `b`, which is determined by a call to [++lth](/doc/hoon/lib/#lth).  
If either statement is `true`, `++lte` produces `true`.  
Otherwise, `++lte` produces `false`.  


<h2 id="++gth">++&nbsp;&nbsp;gth</h2>

####Greater than.  
`++gth` takes two atoms, `a` and `b`, and produces a loobean `a`<`b`.

###Examples
    ~ronrem-lonsem/try=> (gth 4 5)
    %.n
    ~ronrem-lonsem/try=> (gth 5 4)
    %.y
    ~ronrem-lonsem/try=> (gth 5 5)
    %.n
    ~ronrem-lonsem/try=> (gth 0 0)
    %.n

###Summary
    ++  gth                                                 ::  greater-than
      ~/  %gth                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sam
      ^-  ?                                                 ::  cast result loobean
      !(lte a b)                                            ::  a not <= b

`++gth` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++gth` creates a dry %gold gate with [|=](/doc/hoon/lan/rune/#bartis), accepting a sample pair of atoms, labeled `a` and `b` with [=, the irregular form of ^=](/doc/hoon/lan/rune/#kettis).  
The product is cast to a loobean with [^-](/doc/hoon/lan/rune/#kethep). 
++gth calls [++lth](/doc/hoon/lib/#++lth) to test whether `a` is not less than or equal to `b`.    
If the statement returns `true`, so does `++gth`.
Otherwise, `++gth` returns false.   


<h2 id="#++gte">++&nbsp;&nbsp;gte</h2>

####Greater than or equal to.  
`++gte` takes two atoms, `a` and `b`, and produces the loobean for `a`>=`b`.

###Examples
    ~ronrem-lonsem/try=> (gte 4 5)
    %.n
    ~ronrem-lonsem/try=> (gte 5 4)
    %.y
    ~ronrem-lonsem/try=> (gte 5 5)
    %.y
    ~ronrem-lonsem/try=> (gte 0 0)
    %.y

###Summary    
    ++  gte                                                 ::  greater-equal
      ~/  %gte                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sam
      ^-  ?                                                 ::  cast to loobean
      !(lth a b)                                            ::  if a ! <= b 


`++gte` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas). 
`++gte` creates a dry %gold gate with [|=](/doc/hoon/lan/rune/#bartis), accepting a pair of atoms into its sample, labeled `a` and `b` with [([=, the irregular form of ^=](doc/hoon/lan/rune/#kettis).  
The product is cast to a loobean [^-](/doc/hoon/lan/rune/#kethep).  
Using the [++lth](/doc/hoon/lib/#++lth) function, `++gte` tests whether `a` is not [!, the irregular form of wutzap](/doc/hoon/lan/rune/#wutzap) less than `b`.  
If the statement returns `true`, so does `++gte`. Else, `++gte` returns `false`. 


<h2 id="++max">++&nbsp;&nbsp;max</h2>

####Maximum
`++max` takes two atoms `a` and `b` and produces the larger of the two.

###Examples
    ~ronrem-lonsem/try=> (max 5 4)
    5
    ~ronrem-lonsem/try=> (max 5 6)
    6
    ~ronrem-lonsem/try=> (max 5 5)
    5

###Summary
        ++  max                                                 ::  maximum
        ~/  %max                                              ::  jet
        |=  [a=@ b=@]                                         ::  gate, sample @ pair
        ^-  @                                                 ::  cast result to atom
        ?:  (gth a b)                                         ::  if a > b
          a                                                   ::  then, return a
        b                                                     ::  else, return b

`++max` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas)  
`++max` creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis)), which accepts a sample pair of atoms, labeled `a` and `b` using [^=](/doc/hoon/lan/rune/#kettis).  
The result is cast to an atom with [^-](/doc/hoon/lan/rune/#kethep).If [?:](/doc/hoon/lan/rune/#wutcol) `a` is greater than `b`, `a` is returned.  
Otherwise `b` is returned.  


<h2 id="++min">++&nbsp;&nbsp;min</h2>

####Minimum.  
++min takes two atoms `a` and `b` and produces the smaller of the two. If they are equal, that value is produced.

###Examples
~ronrem-lonsem/try=> (min 5 4)  
4  
~ronrem-lonsem/try=> (min 5 6)  
5  
~ronrem-lonsem/try=> (min 5 5)  
5  

###Summary
    ++  min                                                 ::  minimum
      ~/  %min                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, sample @ pair
      ^-  @                                                 ::  cast result to atom
      ?:  (lth a b)                                         ::  if a less than b
        a                                                   ::  then, return a
      b                                                     ::  else, return b


`++min` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++min` creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), which accepts a sample pair of atoms, labeled `a` and `b`.  
The result is cast to an atom with [^-](/doc/hoon/lan/rune/#kethep).  
If [?:](/doc/hoon/lan/rune/#wutcol) `a` is less than `b` ([`++lth`)](/doc/hoon/lib/#++lth)) `a` is returned.  
Else `b` is returned.


::::::  Nock tree calculations

<h2 id="++cap">++&nbsp;&nbsp;cap</h2>

####++Tree Head.  
++cap takes an atom `a` and produces %2 or %3 indicating if `a` is an address in the head (%2) or the tail (%3).

###Examples
~ronrem-lonsem/try=> (cap 2)
%2
~ronrem-lonsem/try=> (cap 3)
%3
~ronrem-lonsem/try=> (cap 6)
%3
~ronrem-lonsem/try=> (cap 4)
%2
~ronrem-lonsem/try=> (cap 35)
%2
~ronrem-lonsem/try=> (cap 0)
exit
~ronrem-lonsem/try=> (cap 1)
! exit

###Summary
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

`++cap` is a [jetted arm (~/)](/doc/hoon/lan/tile/#sigfas).  
`++cap` creates a dry %gold gate [|=](/doc/hoon/lan/rune/#bartis), accepting an atomic sample labeled `a`.   The result is cast to either the [fern](/doc/hoon/lan/tile/#%fern) `%2`, or the [fern](/doc/hoon/lan/tile/#%fern) %3.  
If `a` is `%2` or `%3`, return either `%2` or `%3` respectively.  
If `a` is either the [fern](/doc/hoon/lan/tile/#%fern) `%0` or `%1`, `++cap` crashes. If `a` is any other noun, the `$` arm ([%=])(/doc/hoon/lan/rune/#centis) is reactivated, this time with the value of `a` set to `a/2`. 
This recursive process repeats until `a` hits one of the aforementioned switches. 


<h2 id="++mas">++&nbsp;&nbsp;mas</h2>

####Axis in Head/Tail.  
`++mas` takes an atom `a` and produces the axis of `a` within the head or the tail.

###Examples
1
~ronrem-lonsem/try=> (mas 3)  
1  
~ronrem-lonsem/try=> (mas 4)  
2  
~ronrem-lonsem/try=> (mas 5)  
3  
~ronrem-lonsem/try=> (mas 6)  
2  
~ronrem-lonsem/try=> (mas 7)  
3  
~ronrem-lonsem/try=> (mas 8)  
4  
~ronrem-lonsem/try=> (mas 0)  
! exit  
~ronrem-lonsem/try=> (mas 1)  
! exit  

###Summary
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

`++mas` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).
 `++mas` creates a dry %gold gate [|=](/doc/hoon/lan/rune/#bartis), accepting a sample labeled `a`.  
 Its result is cast to an atom using [^-](/doc/hoon/lan/rune/#kethep).   
`++mas` uses a switch [?-](/doc/hoon/lan/rune/#wuthep):  
If `a` is 1, `++mas` crashes. 
If `a` is 2 or 3, `++mas` produces 1.  
If `a` is any other noun [*](/doc/hoon/lan/tile/#axil) , `++mas` produces the sum of `a` % 2 and the product of `++mas` (a/2) and 2. 
   

<h2 id="++peg">++&nbsp;&nbsp;peg</h2>

###Axis in axis
++peg takes two atoms `a` and `b` and produces the axis of `b` within the axis of `a`.

###Examples
~ronrem-lonsem/try=> (peg 1 4)
4
~ronrem-lonsem/try=> (peg 1 39)
39
~ronrem-lonsem/try=> (peg 2 4)
8
~ronrem-lonsem/try=> (peg 2 3)
5

###Summary

    ++  peg                                                 ::  tree connect
      ~/  %peg                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sam  
      ^-  @                                                 ::  cast result to atom
      ?-  b                                                 ::  switch: if b is...
        1   a                                               ::  1, then return a
        2   (mul a 2)                                       ::  2, then return a*2  
        3   +((mul a 2))                                    ::  3, then ret +(a*2)
        *   (add (mod b 2) (mul $(b (div b 2)) 2))          ::  *, b%2+recurse((b/2) * 2) 
      ==

`++peg` is a [jetted arm](~/).
`++peg` creates a %dry golden gate using [|=](/doc/hoon/lan/rune/#bartis), which accepts two atoms into its sample, labeled `a` and `b`.  
The result is cast to an atom using [^=](/doc/hoon/lan/rune/#kettis). 
`++peg` uses a switch:  
If `b` is 1, `a` is produced.  
If `b` is 2, a * 2 is produced.  
If `b` is 3, (a * 2) + 1 is produced.  
If `b` is any other noun, b % 2 is added to the product of 2 * `++peg` with `b` set to `b/2`.
