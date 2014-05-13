---
layout: subpage
title: 2c Noun Surgery
title-short: Nouns
arms: [++bex, ++can, ++cat, ++cut, ++end, ++lsh, ++met, ++rap, ++rep, ++rsh, ++con, ++dis, ++mix, ++aor, ++dor, ++gor, ++hor, ++vor, ++fnv, ++mug, ++po, ++ind, ++ins, ++tod, ++tos, ++si, ++abs ++si, ++dif ++si, ++dul ++si, ++fra ++si, ++new ++si, ++old ++si, ++pro ++si, ++rem ++si, ++sum ++si, ++sun ++si, ++syn ++si, ++fe, ++dif ++fe, ++inv ++fi, ++net ++fi, ++out ++fi, ++rol ++fi, ++ror ++fi, ++sum ++fi, ++sit ++fi, ++rlyd, ++rlyh, ++rlyq, ++rlys, ++ryld, ++rylh, ++rylq, ++ryls, ++year, ++yore, ++yell, ++yule, ++yall, ++yawn, ++yelp, ++yo, ++hard, ++soft]
axis: doc-hoon
categories: lib
sort: 4
---

<h2 id="++bex">++&nbsp;&nbsp;bex</h2>

####Binary exponent.
`++bex` takes an atom `a` and produces `2^a`.

###Examples

    ~ronrem-lonsem/try=> (bex 3)
    8
    ~ronrem-lonsem/try=> (bex 1)
    2
    ~ronrem-lonsem/try=> (bex 42)
    4.398.046.511.104
    ~ronrem-lonsem/try=> (bex 0)
    1

###Summary

    ++  bex                                                 ::::::  binary exponent
      ~/  %bex                                              ::  jet
      |=  a=@                                               ::  gate, atom sample 
      ^-  @                                                 ::  cast result as atom
      ?:  =(0 a)                                            ::  if a is 0
        1                                                   ::  then, produce 1
      (mul 2 $(a (dec a)))                                  ::  mul 2*2 n times 

`++bex` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++bex` creates a dry `%gold` gate using [|=](/doc/hoon/lan/rune/#bartis), which accepts an atomic sample `a`, [axil @](/doc/hoon/lan/tile/#axil), with [^=](/doc/hoon/lan/rune/#kettis).  
The result of `++bex` is then cast to an atom with [^-](/doc/hoon/lan/rune/#kethep).  
If `a` is equal to 0, `++bex` produces 1.  
Otheriwse, `++bex` returns the product of 2 and `++bex` with the value of `a` replaced by [dec a](/doc/hoon/lib/#++dec).  


---
<h2 id="++can">++&nbsp;&nbsp;can</h2>

####Assemble
`++can` accepts a bloq `a` and a list of cells `b`. `++can` assembles the tails of `q`; the length of the tail is `p` number of bloqs of size `a`.

###Examples

    ~ronrem-lonsem/try=> `@ub`(can 3 ~[[1 1]])
    0b1
    ~ronrem-lonsem/try=> `@ub`(can 0 ~[[1 255]])
    0b1
    ~ronrem-lonsem/try=> `@ub`(can 1 ~[[1 2]])
    0b10
    ~ronrem-lonsem/try=> `@ub`(can 1 ~[[1 3]])
    0b11
    ~ronrem-lonsem/try=> `@ub`(can 1 ~[[1 4]])
    0b0
    ~ronrem-lonsem/try=> `@ub`(can 1 ~[[2 4]])
    0b100

###Summary

    ++  can                                                 ::  assemble
      ~/  %can                                              ::  jet
      |=  [a=bloq b=(list ,[p=@ q=@])]                      ::  gate, sample: bloq, list 
      ^-  @                                                 ::  cast result to atom
      ?~  b                                                 ::  if b is ~
        0                                                   ::  then, return 0
      (mix (end a p.i.b q.i.b) (lsh a p.i.b $(b t.b)))      ::  else,

`++can` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++can` takes a [bloq](/doc/hoon/lib/#++bloq) `a` and [list](/doc/hoon/lib/#++list) `b` using [^=](/doc/hoon/lan/rune/#kettis).  
The result is cast to an atom with [^-](/doc/hoon/lan/rune/#kethep).  
If `b` is null ([?~](/doc/hoon/lan/rune/#wutsig)) `++can` produces 0.    
Otherwise, `++can` calls `++mix` with two arguments:  
1.`++end`, which produces the tail of the first `q` in the list; the length of the tail is `p` number of [bloqs](/doc/hoon/lib/#++bloq) of size `a`.     
2. `++lsh` with [bloq](/doc/hoon/lib/#++bloq) size `a`, the first `p` of [list](/doc/hoon/lib/#++list) `b`, and the product of recursively calling `++can` with the value of [list](/doc/hoon/lib/#++list) `b` now set to its tail.


---
<h2 id="++cat">++&nbsp;&nbsp;cat</h2>

####Concatenate
`++cat` accepts a bloq `a` and two atoms `b` and `c`. `++cat` produces `b` and `c` concatenated obeying the bloq size `a`.

###Examples
    ~ronrem-lonsem/try=> `@ub`(cat 1 1 0)
    0b1
    ~ronrem-lonsem/try=> `@ub`(cat 2 1 0)
    0b1
    ~ronrem-lonsem/try=> `@ub`(cat 4 1 0)
    0b1
    ~ronrem-lonsem/try=> `@ub`(cat 0 1 1)
    0b11
    ~ronrem-lonsem/try=> `@ub`(cat 0 2 1)
    0b110
    ~ronrem-lonsem/try=> `@ub`(cat 2 1 1)
    0b1.0001
    ~ronrem-lonsem/try=> `@ub`256
    0b1.0000.0000
    ~ronrem-lonsem/try=> `@ub`255
    0b1111.1111
    ~ronrem-lonsem/try=> `@ub`(cat 3 256 255)
    0b1111.1111.0000.0001.0000.0000
    ~ronrem-lonsem/try=> `@ub`(cat 2 256 255)
    0b1111.1111.0001.0000.0000
    ~ronrem-lonsem/try=> (cat 3 256 255)
    16.711.936

###Summary

    ++  cat                                                     ::  concatenate
          ~/  %cat                                              ::  jet
          |=  [a=bloq b=@ c=@]                                  ::  gate, bloq, 2 @ sample
          (add (lsh a (met a b) c) b)                           ::  add b to c lshifted by # of bloqs in b

`++cat` is a [jetted arm(~/)](/doc/hoon/lan/rune/#sigfas).  
`++cat` takes a [bloq](/doc/hoon/lib/#++bloq) a', and two atoms of [axil @](/doc/hoon/lan/tile/#axil) labeled `b` and `c` with [^=](/doc/hoon/lan/rune/#kettis).  
`++cat` uses [++met](/doc/hoon/lib/#++met) to measure the number of [bloqs](/doc/hoon/lib/#++bloq) of size `a` that comprise `b`.  
`c` is then left-shifted ([++lsh](/doc/hoon/lib/#++lsh) by the same number of [bloqs](/doc/hoon/lib/#++bloq) of size `a`, and then added ([++add](/doc/hoon/lib/#++add)) to `b`.  

---
<h2 id="++cut">++&nbsp;&nbsp;cut</h2>

####Slice
`++cut` accepts a bloq `a`, a cell of atoms `b` and `c` and an atom `d`.
`++cut` takes the [tail](/doc/hoon/lib/#++tail) of `d` right-shifted ([++rsh](/doc/hoon/lib/#++rsh)) by a bloq of size `a`, `b` number of times.

###Examples
    ~ronrem-lonsem/try=> (cut 0 [1 1] 2)
    1
    ~ronrem-lonsem/try=> (cut 0 [2 1] 4)
    1
    ~ronrem-lonsem/try=> (cut 3 [1 1] 256)
    1
    ~ronrem-lonsem/try=> (cut 2 [1 1] 255)
    15
    ~ronrem-lonsem/try=> (cut 1 [1 1] 255)
    3
    ~ronrem-lonsem/try=> (cut 1 [1 2] 255)
    15

###Summary

    ++  cut                                                 ::  slice
      ~/  %cut                                              ::  jet
      |=  [a=bloq [b=@ c=@] d=@]                            ::  gate, sample: bloq, cell of @, @
      (end a c (rsh a b d))

`++cut` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++cut` creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes a [bloq](/doc/hoon/lib/#++bloq) `a`, a cell of two atoms of[axil @](/doc/hoon/lan/tile/#axil), labeled `b` and `c` respectively, and an atom of [axil @](/doc/hoon/lan/tile/#axil), labeled `d`.  
All of these lables are produced by [^=](/doc/hoon/lan/rune/#kettis). `++cut` then right-shifts [(++rsh)](/doc/hoon/lib/#++rsh) `d` by `b` number of bloqs of size `a`.  
`++cut` calls the arm [++end](/doc/hoon/lib/ #++end) to return the tail of the result of [right-shifting](/doc/hoon/lib/#++rsh) `d`.  
The size of the tail is determined by the number of bloqs `c` of size `a`.

---
<h2 id="++end">++&nbsp;&nbsp;end</h2>

####Tail
`++end` takes a bloq a, and atoms c and d. ++end returns the tail of c, whose length is determined by the number of bloqs b, of size a

###Examples

    ~ronrem-lonsem/try=> `@ub`12
    0b1100
    ~ronrem-lonsem/try=> `@ub`(end 0 3 12)
    0b100
    ~ronrem-lonsem/try=> (end 0 3 12)
    4
    ~ronrem-lonsem/try=> `@ub`(end 1 3 12)
    0b1100
    ~ronrem-lonsem/try=> (end 1 3 12)
    12
    ~ronrem-lonsem/try=> (end 3 1 256)
    0
    ~ronrem-lonsem/try=> (end 3 1 255)
    255

###Summary

    ++  end                                                 ::  tail
      ~/  %end                                              ::  jet 
      |=  [a=bloq b=@ c=@]                                  ::  gate, bloq, 2 @ sample
      (mod c (bex (mul (bex a) b)))                         ::  c % 2^(2^a * b)

`++end` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) which creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes a [bloq](/doc/hoon/lib/#++bloq) and two atoms of [axil @](/doc/hoon/lan/tile/#axil), labeled `b` and `c` with [^=](/doc/hoon/lan/rune/#kettis). `++end` returns the remainder of dividing c by the result of [++bex](/doc/hoon/lib/#++bex)  of [++bex](/doc/hoon/lib/#++bex)  multiplied by `b`.


---
<h2 id="++lsh">++&nbsp;&nbsp;lsh</h2>

####Left shift
`++lsh` takes a bloq `a` and atoms `b` and `c`. `++lsh` produces c shifted `b` bloqs of size `a` to the left.

###Examples
    ~ronrem-lonsem/try=> `@ub`1
    0b1
    ~ronrem-lonsem/try=> `@ub`(lsh 0 1 1)
    0b10
    ~ronrem-lonsem/try=> (lsh 0 1 1)
    2

    ~ronrem-lonsem/try=> `@ub`255
    0b1111.1111
    ~ronrem-lonsem/try=> `@ub`(lsh 3 1 255)
    0b1111.1111.0000.0000
    ~ronrem-lonsem/try=> (lsh 3 1 255)
    65.280

###Summary
    ++  lsh                                                 ::  left-shift
      ~/  %lsh                                              ::  jet
      |=  [a=bloq b=@ c=@]                                  ::  gate, bloq, 2 @ sample
      (mul (bex (mul (bex a) b)) c)                         ::  c * (2^(2^a * b))
`++lsh` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) which creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes a [bloq](/doc/hoon/lib/#++bloq) and two atoms of [axil @](/doc/hoon/lan/tile/#axil), labeled `b` and `c` with [^=](/doc/hoon/lan/rune/#kettis). `++lsh` multiplies `c` by the result of [++bex](/doc/hoon/lib/#++bex)  of the product of [++bex](/doc/hoon/lib/#++bex)  of `a` multiplied by `b`.


---
<h2 id="++met">++&nbsp;&nbsp;met</h2>

####Measure
`++met` accepts a bloq `a` and an atom `b`. `++met` produces a count of bloqs of size `a` in atom `b`.

###Examples
    ~ronrem-lonsem/try=> (met 0 1)
    1
    ~ronrem-lonsem/try=> (met 0 2)
    2
    ~ronrem-lonsem/try=> (met 3 255)
    1
    ~ronrem-lonsem/try=> (met 3 256)
    2

###Summary

    ++  met                                                 ::  measure
      ~/  %met                                              ::  jet
      |=  [a=bloq b=@]                                      ::  gate, bloq, @ sample
      ^-  @                                                 ::  cast res to @
      =+  c=0                                               ::  c=0 to sample
      |-                                                    ::  trap
      ?:  =(0 b)                                            ::  if b is 0
        c                                                   ::  then return c
      $(b (rsh a 1 b), c +(c))                              ::  sub values, recurse

`++met` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) which creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes a [bloq](/doc/hoon/lib/#++bloq) and an atom of [axil @](/doc/hoon/lan/tile/#axil), labeled `b` with [^=](/doc/hoon/lan/rune/#kettis). `++met` uses [^-](/doc/hoon/lan/rune/#kethep) to cast its result to an atom of [axil @](/doc/hoon/lan/tile/#axil), and uses [=+](/doc/hoon/lan/rune/#tislus) to push a variable `c` onto the sample with a value of 0. Then `++met` declares a trap with [|-](/doc/hoon/lan/rune/#barhep) to enable recursion. If `b` is equal to 0, then `c` is returned. Otherwise, `++met` recurses, this time with the value of `b` set to the result of right-shifting ([++rsh](/doc/hoon/lib/#++rsh)) `b` by one bloq of size `a` to the right, with with the value of c set to +(c) [.+](/doc/hoon/lib/#dotlus). When the value of `b` reaches 0, `++met` returns the value of `c`, which will represent the number of bloqs of size `a` b initially posessed.


---
<h2 id="++rap">++&nbsp;&nbsp;rap</h2>
    ++  rap                                                 ::  assemble nonzero
      ~/  %rap                                              ::  jet
      |=  [a=bloq b=(list ,@)]                              ::  gate, bloq, list in sample
      ^-  @                                                 ::  cast result to @
      ?@  b                                                 ::  if b is an @                                               
        0                                                   ::  then, return 0
      (cat a i.b $(b t.b))                                  ::  else ++cat


---
<h2 id="++rsh">++&nbsp;&nbsp;rep</h2>
    ++  rep                                                 ::  assemble single
      ~/  %rep
      |=  [a=bloq b=(list ,@)]
      ^-  @
      =+  c=0
      |-
      ?@  b
        0
      (con (lsh a c (end a 1 i.b)) $(c +(c), b t.b))

`++rep` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) that takes a [bloq](/doc/hoon/lib/#++bloq) and [list](/doc/hoon/lib/#++list), labeled `a` and `b` respectively using [^=](/doc/hoon/lan/rune/#kettis). `++rep` casts its result to an atom using [^-](/doc/hoon/lan/rune/#kethep) and then, using [=+](/doc/hoon/lan/rune/#tislus), it pushes a variable `c` onto the sample and sets its value equal to 0. In order to loop, `++rep` then declares a using [|-](/doc/hoon/lan/rune/barhep). The trap uses [?@](/doc/hoon/lan/rune/#wutpam) to test whether `b` is an atom or not. If yes, `++rep` returns 0. Otherwise, `++rep` returns [++con](/doc/hoon/lib/#++con), which it passes two arguments: 1. ++lsh with [bloq](/doc/hoon/lib/#++bloq) size `a`, number of times `c`, and the [tail](/doc/hoon/lib/#++end) of the head of `b`; and, 2.  


---
<h2 id="++rip">++&nbsp;&nbsp;rip</h2>
    ++  rip                                                 ::  disassemble
      ~/  %rip
      |=  [a=bloq b=@]
      ^-  (list ,@)
      ?:  =(0 b)
        ~
      [(end a 1 b) $(b (rsh a 1 b))]


---
<h2 id="++rsh">++&nbsp;&nbsp;rsh</h2>

`++rsh` takes a bloq `a` and atoms `b` and `c`. ++rsh produces `c` shifted `b` bloqs of size `a` to the right.

###Examples
    ~ronrem-lonsem/try=> `@ub`145
    0b1001.0001
    ~ronrem-lonsem/try=> `@ub`(rsh 1 1 145)
    0b10.0100
    ~ronrem-lonsem/try=> (rsh 1 1 145)
    36
    ~ronrem-lonsem/try=> `@ub`(rsh 2 1 145)
    0b1001
    ~ronrem-lonsem/try=> (rsh 2 1 145)
    9
    ~ronrem-lonsem/try=> `@ub`10
    0b1010
    ~ronrem-lonsem/try=> `@ub`(rsh 0 1 10)
    0b101
    ~ronrem-lonsem/try=> (rsh 0 1 10)
    5
    ~ronrem-lonsem/try=> `@ub`1
    0b1
    ~ronrem-lonsem/try=> (rsh 0 1 1)
    0
    ~ronrem-lonsem/try=> (rsh 0 1 1)
    0

###Summary

    ++  rsh                                                 ::  right-shift
      ~/  %rsh                                              ::  jet 
      |=  [a=bloq b=@ c=@]                                  ::  gate, bloq, 2 @ sample
      (div c (bex (mul (bex a) b)))                         ::  c / 2^(2^a * b)

`++rsh` [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) which creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes a [bloq](/doc/hoon/lib/#++bloq) and two atoms, [axil @](/doc/hoon/lan/tile/#axil), labeled `b` and `c` with [^=](/doc/hoon/lan/rune/#kettis). `++rsh` divides `c` by the result of [++bex](/doc/hoon/lib/#++bex)  of the product of [++bex](/doc/hoon/lib/#++bex)  of `a` multiplied by `b`. 


---
<h2 id="++con">++&nbsp;&nbsp;con</h2>

`++con` accepts two atoms a and b and performs an inclusive binary OR.

###Examples

###Summary
    ++  con                                                 ::  binary or
      ~/  %con                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sample
      =+  [c=0 d=0]                                         ::  c=0, d=0 on sample
      |-  ^-  @                                             ::  trap that returns @
      ?:  ?&(=(0 a) =(0 b))                                 ::  if both a, b are 0
        d                                                   ::  then, return d
      %=  $                                                 ::  else, loop with:
        a   (rsh 0 1 a)                                     ::  a r-shifted 1 bit 
        b   (rsh 0 1 b)                                     ::  b r-shifted 1 bit   
        c   +(c)                                            ::  c incremented
        d   (add d (lsh 0 c ?&(=(0 (end 0 1 a)) =(0 (end 0 1 b))))) Tall form?

`++con` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) which creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes two atoms, labeled `a` and `b` using [^=](/doc/hoon/lan/rune/#kettis). `++con` then pushes two atomic variables onto the subject, labeled `a` and `b` again by using [=, the irregular form of ^=](/doc/hoon/lan/rune/#kettis). With [^-](/doc/hoon/lan/rune/#kethep), `++con` ensures its result is cast to an atom. Subsequently, `++con` declares a trap with [|=](/doc/hoon/lan/rune/#bartis)), thus allowing it to loop. Using [?:](/doc/hoon/lan/rune/#wutcol) and [?&](/doc/hoon/lan/rune/#wutpam), `++con` checks if both `a` and `b` are equal to 0. If yes, then `++con` returns `d`. Else, `++con` uses the trap to loop, this time with the values of `a` and `b` both [right-shifted](/doc/hoon/lib/#++rsh) by one bit, and the value of `c` now incremented using [+, the irregular form of .+](/doc/hoon/lan/rune/#dotlus). The value of `d`can also change: if either the last bit of `a` (found using [++end](/doc/hoon/lib/#++end)) and the last bit of `b` are equal ([.=](/doc/hoon/lan/rune/#dottis))to 0, then the value of `d` becomes the sum of `d` and the result of left-shifting 1 by `c` number of bits. Otherwise, `d` remains the same.     


---
<h2 id="++dis">++&nbsp;&nbsp;dis</h2>

`++dis` accepts two atoms a and b and performs a binary AND.

###Examples

    ~ronrem-lonsem/try=> `@ub`9
    0b1001
    ~ronrem-lonsem/try=> `@ub`5
    0b101
    ~ronrem-lonsem/try=> `@ub`(dis 9 5)
    0b1
    ~ronrem-lonsem/try=> (dis 9 5)
    1
    ~ronrem-lonsem/try=> `@ub`534
    0b10.0001.0110
    ~ronrem-lonsem/try=> `@ub`987
    0b11.1101.1011
    ~ronrem-lonsem/try=> `@ub`(dis 534 987)
    0b10.0001.0010
    ~ronrem-lonsem/try=> (dis 534 987)
    530

###Summary

    ++  dis                                                 ::  binary and
      ~/  %dis                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 @ sample  
      =|  [c=@ d=@]                                         ::  bunt; c & d = 0
      |-  ^-  @                                             ::  trap; cast to @
      ?:  ?|(=(0 a) =(0 b))                                 ::  if a or b are 0
        d                                                   ::  then, return d
      %=  $                                                 ::  else, loop with:
        a   (rsh 0 1 a)                                     ::  a r-shifted 1 bit  
        b   (rsh 0 1 b)                                     ::  b r-shifted 1 bit
        c   +(c)                                            ::  c incremented
        d   (add d (lsh 0 c ?|(=(0 (end 0 1 a)) =(0 (end 0 1 b)))))  :: Tall form?

`++dis` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) which creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes two atoms, labeled `a` and `b` using [^=](/doc/hoon/lan/rune/#kettis). Then, using [=|](/doc/hoon/lan/rune/#tisbar), two tiles, labeled `c` and `d`, are [bunted](/doc/hoon/lan/tile/#bunt) onto the subject. In order to loop, `++dis` then calls a trap with [|-](/doc/hoon/lan/rune/barhep), whose result is cast to an atom with [^-](/doc/hoon/lan/rune/#kethep). The trap then uses an if statement by using [?:](/doc/hoon/lan/rune/#wutcol):it uses [=, the irregular form of .= to check if either `a` or `b` is equal to 0 (the inclusive OR statement is called with [?|](/doc/hoon/lan/rune/#wutbar). If either statement returns true, then `++dis` produces d. Otherwise, the trap loops, this time with the values of `a` and `b` both [right-shifted](/doc/hoon/lib/#++rsh) by one bit, and the value of `c` now incremented with [+, the irregular form of .+](/doc/hoon/lan/rune/#dotlus). The value of `d`can also change: if neither the last bit of `a` nor the last bit of `b` are equal ([.=](/doc/hoon/lan/rune/#dottis))to 0, then the value of `d` becomes the sum of d and the result ofleft-shifting 1 by `c` number of bits. Otherwise, d remains the same.     


---
<h2 id="++mix">++&nbsp;&nbsp;mix</h2>

`++mix` accepts two atoms a and b and performs an exclusive binary OR.

###Examples:
    ~ronrem-lonsem/try=> `@ub`2
    0b10
    ~ronrem-lonsem/try=> `@ub`3
    0b11
    ~ronrem-lonsem/try=> `@ub`(mix 2 3)
    0b1
    ~ronrem-lonsem/try=> (mix 2 3)
    1
    ~ronrem-lonsem/try=> `@ub`(mix 2 2)
    0b0
    ~ronrem-lonsem/try=> (mix 2 2)
    0


###Summary

    ++  mix                                                 ::  binary xor
      ~/  %mix                                              ::  jet
      |=  [a=@ b=@]                                         ::  gate, 2 atom sample
      ^-  @                                                 ::  cast result to atom
      =+  [c=0 d=0]                                         ::  c=0, d=0 to sample
      |-                                                    ::  trap
      ?:  ?&(=(0 a) =(0 b))                                 ::  If `a` & `b` are 0
        d                                                   ::  Then, return 0, (d)
      %=  $                                                 ::  Recall ++ mix with:
        a   (rsh 0 1 a)                                     ::  a r-shifted 1 bit
        b   (rsh 0 1 b)                                     ::  b r-shifted 1 bit
        c   +(c)                                            ::  c incremented
        d   (add d (lsh 0 c =((end 0 1 a) (end 0 1 b))))    ::  Tall form?

`++mix` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas) which creates a dry %gold gate using [|=](/doc/hoon/lan/rune/#bartis), whose sample takes two atoms, labeled `a` and `b` using [^=](/doc/hoon/lan/rune/#kettis). `++mix` then uses [^-](/doc/hoon/lan/rune/#kethep) to cast its result to an atom. `++mix` then pushes two atomic variables onto the subject, labeled `a` and `b` again by using [^-](/doc/hoon/lan/rune/#kethep). Subsequently, `++mix` declares a trap with [|-](/doc/hoon/lan/rune/#barhep), thus allowing it to loop. Using [?:](/doc/hoon/lan/rune/#wutcol) and [?&](/doc/hoon/lan/rune/#wutpam), `++mix` checks if both `a` and `b` are equal to 0. If yes, then `++mix` returns `d`. Else, `++mix` uses the trap to loop, this time with the values of `a` and `b` both [right-shifted](/doc/hoon/lib/#++rsh) by one bit, and the value of `c` now incremented using [+, the irregular form of .+](/doc/hoon/lan/rune/#dotlus). The value of `d` is also replaced with the sum of `d` and the result of [=(), the irregular form of .=](/doc/hoon/lan/rune/#dottis) then [left-shifted](/doc/hoon/lan/rune/#++lsh) by 1 bit `c` number of times.

#Noun orders

---
<h2 id="++aor">++&nbsp;&nbsp;aor</h2>

###Examples

###Summary
    ++  aor                                                 ::  a-order
      ~/  %aor
      |=  [a=* b=*]
      ^-  ?
      ?:  =(a b)
        &
      ?.  ?=(@ a)
        ?.  ?=(@ b)
          ?:  =(-.a -.b)
            $(a +.a, b +.b)
          $(a -.a, b -.b)
        |
      ?.  ?=(@ b)
        &
      |-
      =+  [c=(end 3 1 a) d=(end 3 1 b)]
      ?:  =(c d)
        $(a (rsh 3 1 a), b (rsh 3 1 b))
      (lth c d)

---
<h2 id="++dor">++&nbsp;&nbsp;dor</h2>

###Examples

###Summary
    ++  dor                                                 ::  d-order
      ~/  %dor
      |=  [a=* b=*]
      ^-  ?
      ?:  =(a b)
        &
      ?.  ?=(@ a)
        ?.  ?=(@ b)
          ?:  =(-.a -.b)
            $(a +.a, b +.b)
          $(a -.a, b -.a)
        |
      ?.  ?=(@ b)
        &
      (lth a b)

---
<h2 id="++gor">++&nbsp;&nbsp;gor</h2>
###Examples

###Summary
    ++  gor                                                 ::  g-order
      ~/  %gor
      |=  [a=* b=*]
      ^-  ?
      =+  [c=(mug a) d=(mug b)]
      ?:  =(c d)
        (dor a b)
      (lth c d)

---
<h2 id="++hor">++&nbsp;&nbsp;hor</h2>
###Examples

###Summary
    ++  hor                                                 ::  h-order
      ~/  %hor
      |=  [a=* b=*]
      ^-  ?
      ?:  ?=(@ a)
        ?:  ?=(@ b)
          (gor a b)
        &
      ?:  ?=(@ b)
        |
      ?:  =(-.a -.b)
        (gor +.a +.b)
      (gor -.a -.b)

---
<h2 id="++vor">++&nbsp;&nbsp;vor</h2>
###Examples

###Summary
    ++  vor                                                 ::  v-order
      ~/  %vor
      |=  [a=* b=*]
      ^-  ?
      =+  [c=(mug (mug a)) d=(mug (mug b))]
      ?:  =(c d)
        (dor a b)
      (lth c d)

---
<h2 id="++fnv">++&nbsp;&nbsp;fnv</h2>
###Examples

###Summary
    ++  fnv  |=(a=@ (end 5 1 (mul 16.777.619 a)))           ::  FNV scrambler

---
<h2 id="++mug">++&nbsp;&nbsp;mug</h2>
###Examples

###Summary
    ++  mug                                                 ::  31bit nonzero FNV1a
      ~/  %mug
      |=  a=*
      ?^  a
        =+  b=[p=$(a -.a) q=$(a +.a)]
        |-  ^-  @
        =+  c=(fnv (mix p.b (fnv q.b)))
        =+  d=(mix (rsh 0 31 c) (end 0 31 c))
        ?.  =(0 c)  c
        $(q.b +(q.b))
      =+  b=2.166.136.261
      |-  ^-  @
      =+  c=b
      =+  [d=0 e=(met 3 a)]
      |-  ^-  @
      ?:  =(d e)
        =+  f=(mix (rsh 0 31 c) (end 0 31 c))
        ?.  =(0 f)  f
        ^$(b +(b))
      $(c (fnv (mix c (cut 3 [d 1] a))), d +(d))

---
<h2 id="++po">++&nbsp;&nbsp;po</h2>
###Examples

###Summary
    ++  po
      ~/  %po
      =+  :-  ^=  sis
              'dozmarbinwansamlitsighidfidlissogdirwacsabwissib\
              /rigsoldopmodfoglidhopdardorlorhodfolrintogsilmir\
              /holpaslacrovlivdalsatlibtabhanticpidtorbolfosdot\
              /losdilforpilramtirwintadbicdifrocwidbisdasmidlop\
              /rilnardapmolsanlocnovsitnidtipsicropwitnatpanmin\
              /ritpodmottamtolsavposnapnopsomfinfonbanporworsip\
              /ronnorbotwicsocwatdolmagpicdavbidbaltimtasmallig\
              /sivtagpadsaldivdactansidfabtarmonranniswolmispal\
              /lasdismaprabtobrollatlonnodnavfignomnibpagsopral\
              /bilhaddocridmocpacravripfaltodtiltinhapmicfanpat\
              /taclabmogsimsonpinlomrictapfirhasbosbatpochactid\
              /havsaplindibhosdabbitbarracparloddosbortochilmac\
              /tomdigfilfasmithobharmighinradmashalraglagfadtop\
              /mophabnilnosmilfopfamdatnoldinhatnacrisfotribhoc\
              /nimlarfitwalrapsarnalmoslandondanladdovrivbacpol\
              /laptalpitnambonrostonfodponsovnocsorlavmatmipfap'
          ^=  dex
          'zodnecbudwessevpersutletfulpensytdurwepserwylsun\
          /rypsyxdyrnuphebpeglupdepdysputlughecryttyvsydnex\
          /lunmeplutseppesdelsulpedtemledtulmetwenbynhexfeb\
          /pyldulhetmevruttylwydtepbesdexsefwycburderneppur\
          /rysrebdennutsubpetrulsynregtydsupsemwynrecmegnet\
          /secmulnymtevwebsummutnyxrextebfushepbenmuswyxsym\
          /selrucdecwexsyrwetdylmynmesdetbetbeltuxtugmyrpel\
          /syptermebsetdutdegtexsurfeltudnuxruxrenwytnubmed\
          /lytdusnebrumtynseglyxpunresredfunrevrefmectedrus\
          /bexlebduxrynnumpyxrygryxfeptyrtustyclegnemfermer\
          /tenlusnussyltecmexpubrymtucfyllepdebbermughuttun\
          /bylsudpemdevlurdefbusbeprunmelpexdytbyttyplevmyl\
          /wedducfurfexnulluclennerlexrupnedlecrydlydfenwel\
          /nydhusrelrudneshesfetdesretdunlernyrsebhulryllud\
          /remlysfynwerrycsugnysnyllyndyndemluxfedsedbecmun\
          /lyrtesmudnytbyrsenwegfyrmurtelreptegpecnelnevfes'
      |%

##ind:po
###Examples

###Summary
      ++  ind  ~/  %ind
               |=  a=@
               =+  b=0
               |-  ^-  (unit ,@)
               ?:(=(256 b) ~ ?:(=(a (tod b)) [~ b] $(b +(b))))

##ins:po
###Examples

###Summary
      ++  ins  ~/  %ins
               |=  a=@
               =+  b=0
               |-  ^-  (unit ,@)
               ?:(=(256 b) ~ ?:(=(a (tos b)) [~ b] $(b +(b))))

##tod:po
###Examples

###Summary
    ++  tod  ~/(%tod |=(a=@ ?>((lth a 256) (cut 3 [(mul 3 a) 3] dex))))

##tos:po
###Examples

###Summary
    ++  tos  ~/(%tos |=(a=@ ?>((lth a 256) (cut 3 [(mul 3 a) 3] sis))))


#Signed integers

---
<h2 id="++si">++&nbsp;&nbsp;si</h2>
###Examples

###Summary
    ++  si                                                  ::  signed integer
      |%

##abs:si
###Examples

###Summary
    ++  abs  |=(a=@s (add (end 0 1 a) (rsh 0 1 a)))
    ::  absolute value of a
    ::

##dif:si
###Examples

###Summary
    ++  dif  |=([a=@s b=@s] (sum a (new !(syn b) (abs b))))
    ::  signed subtraction
    ::

##dul:si
###Examples

###Summary
    ++  dul  |=([a=@s b=@] =+(c=(old a) ?:(-.c (mod +.c b) (sub b +.c))))
    ::  signed mod ??
    ::

##fra:si
###Examples

###Summary
    ++  fra  |=  [a=@s b=@s]
             (new =(0 (mix (syn a) (syn b))) (div (abs a) (abs b)))
    ::  signed division
    ::

##new:si
###Examples

###Summary
    ++  new  |=([a=? b=@] `@s`?:(a (mul 2 b) ?:(=(0 b) 0 +((mul 2 (dec b))))))
    ::  convert [sign magnitude] pair to @s
    ::

##old:si
###Examples

###Summary
    ++  old  |=(a=@s [(syn a) (abs a)])
    ::  sign magnitude pair
    ::

##pro:si
###Examples

###Summary
    ++  pro  |=  [a=@s b=@s]
             (new =(0 (mix (syn a) (syn b))) (mul (abs a) (abs b)))
    ::  signed multiplication
    ::

##rem:si
###Examples

###Summary
    ++  rem  |=([a=@s b=@s] (dif a (pro b (fra a b))))
    ::  signed remainder
    ::

##sum:si
###Examples

###Summary
    ++  sum  |=  [a=@s b=@s]
             ~|  %si-sum
             =+  [c=(old a) d=(old b)]
             ?:  -.c
               ?:  -.d
                 (new & (add +.c +.d))
               ?:  (gte +.c +.d)
                 (new & (sub +.c +.d))
               (new | (sub +.d +.c))
             ?:  -.d
               ?:  (gte +.c +.d)
                 (new | (sub +.c +.d))
               (new & (sub +.d +.c))
             (new | (add +.c +.d))
    ::  signed addition
    ::

##sun:si
###Examples

###Summary
    ++  sun  |=(a=@u (mul 2 a))
    ::  convert @u to @s
    ::

##syn:si
###Examples

###Summary
    ++  syn  |=(a=@s =(0 (end 0 1 a)))
    ::  %.y if a is positive, %.n if a is negative


---
<h2 id="++fe">++&nbsp;&nbsp;fe</h2>
###Examples

###Summary
    ++  fe                                                  ::  modulo bloq
      |_  a=bloq

##dif:fe
###Examples

###Summary
      ++  dif  |=([b=@ c=@] (sit (sub (add out (sit b)) (sit c))))

##inv:fe
###Examples

###Summary
      ++  inv  |=(b=@ (sub (dec out) (sit b)))

##net:fe
###Examples

###Summary
      ++  net  |=  b=@  ^-  @
               =>  .(b (sit b))
               ?:  (lte a 3)
                 b
               =+  c=(dec a)
               %+  con
                 (lsh c 1 $(a c, b (cut c [0 1] b)))
               $(a c, b (cut c [1 1] b))

##out:fe
###Examples

###Summary
      ++  out  (bex (bex a))

##rol:fe
###Examples

###Summary
      ++  rol  |=  [b=bloq c=@ d=@]  ^-  @
               =+  e=(sit d)
               =+  f=(bex (sub a b))
               =+  g=(mod c f)
               (sit (con (lsh b g e) (rsh b (sub f g) e)))

##ror:fe
###Examples

###Summary
      ++  ror  |=  [b=bloq c=@ d=@]  ^-  @
               =+  e=(sit d)
               =+  f=(bex (sub a b))
               =+  g=(mod c f)
               (sit (con (rsh b g e) (lsh b (sub f g) e)))

##sum:fe
###Examples

###Summary
      ++  sum  |=([b=@ c=@] (sit (add b c)))

##sit:fe
###Examples

###Summary
      ++  sit  |=(b=@ (end a 1 b))

#Floating Point

---
<h2 id="++rlyd">++&nbsp;&nbsp;rlyd</h2>
###Examples

###Summary
    ++  rlyd  |=(red=@rd ~|(%real-nyet ^-([s=? h=@ f=@] !!)))

---
<h2 id="++rlyh">++&nbsp;&nbsp;rlyh</h2>
###Examples

###Summary
    ++  rlyh  |=(reh=@rh ~|(%real-nyet ^-([s=? h=@ f=@] !!)))

---
<h2 id="++rlyq">++&nbsp;&nbsp;rlyq</h2>
###Examples

###Summary
    ++  rlyq  |=(req=@rq ~|(%real-nyet ^-([s=? h=@ f=@] !!)))

---
<h2 id="++rlys">++&nbsp;&nbsp;rlys</h2>
###Examples

###Summary
    ++  rlys  |=(res=@rs ~|(%real-nyet ^-([s=? h=@ f=@] !!)))

---
<h2 id="++ryld">++&nbsp;&nbsp;ryld</h2>
###Examples

###Summary
    ++  ryld  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rd !!)))

---
<h2 id="++rylh">++&nbsp;&nbsp;rylh</h2>
###Examples

###Summary
    ++  rylh  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rh !!)))

---
<h2 id="++rylq">++&nbsp;&nbsp;rylq</h2>
###Examples

###Summary
    ++  rylq  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rq !!)))

---
<h2 id="++ryls">++&nbsp;&nbsp;ryls</h2>
###Examples

###Summary
    ++  ryls  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rs !!)))


#Urbit Time

---
<h2 id="++year">++&nbsp;&nbsp;year</h2>
###Examples
    ~dovryp-toblug/try=> =a [[a=%.y y=2.014] m=3 t=[d=20 h=5 m=42 s=53 f=~[0x7456]]]
    ~dovryp-toblug/try=> (year a)
    0x8000000d21c88d5d7456000000000000
    ??  Why does this return hex?

###Summary
    ++  year                                                ::  date to @d
      |=  det=date
      ^-  @d
      =+  ^=  yer
          ?:  a.det
            (add 292.277.024.400 y.det)
          (sub 292.277.024.400 (dec y.det))
      =+  day=(yawn yer m.det d.t.det)
      (yule day h.t.det m.t.det s.t.det f.t.det)


---
<h2 id="++yore">++&nbsp;&nbsp;yore</h2>

###Examples
    ~dovryp-toblug/try=> (yore a)
    [[a=%.y y=2.014] m=3 t=[d=20 h=5 m=42 s=53 f=~[0x7456]]]

###Summary
    ++  yore                                                ::  @d to date
      |=  now=@d
      ^-  date
      =+  rip=(yell now)
      =+  ger=(yall d.rip)
      :-  ?:  (gth y.ger 292.277.024.400)
            [a=& y=(sub y.ger 292.277.024.400)]
          [a=| y=+((sub 292.277.024.400 y.ger))]
      [m.ger d.ger h.rip m.rip s.rip f.rip]


---
<h2 id="++yell">++&nbsp;&nbsp;yell</h2>

###Examples
    ~dovryp-toblug/try=> (yell ~2014.3.20..05.42.53..7456)
    [d=106.751.991.820.094 h=5 m=42 s=53 f=~[0x7456]]

###Summary

    ++  yell                                                ::  tarp from @d
      |=  now=@d
      ^-  tarp
      =+  sec=(rsh 6 1 now)
      =+  ^=  fan
          =+  [muc=4 raw=(end 6 1 now)]
          |-  ^-  (list ,@ux)
          ?:  |(=(0 raw) =(0 muc))
            ~
          =>  .(muc (dec muc))
          [(cut 4 [muc 1] raw) $(raw (end 4 muc raw))]
      =+  day=(div sec day:yo)
      =>  .(sec (mod sec day:yo))
      =+  hor=(div sec hor:yo)
      =>  .(sec (mod sec hor:yo))
      =+  mit=(div sec mit:yo)
      =>  .(sec (mod sec mit:yo))
      [day hor mit sec fan]


---
<h2 id="++yule">++&nbsp;&nbsp;yule</h2>

###Examples
    ~dovryp-toblug/try=> (yule (yell ~2014.3.20..05.42.53..7456))
    0x8000000d21c88d5d7456000000000000

###Summary
    
    ++  yule                                                 ::  time atom?
      |=  rip=tarp
      ^-  @d
      =+  ^=  sec  ;:  add
                     (mul d.rip day:yo)
                     (mul h.rip hor:yo)
                     (mul m.rip mit:yo)
                     s.rip
                   ==
      =+  ^=  fac  =+  muc=4
                   |-  ^-  @
                   ?~  f.rip
                     0
                   =>  .(muc (dec muc))
                   (add (lsh 4 muc i.f.rip) $(f.rip t.f.rip))
      (con (lsh 6 1 sec) fac)


---
<h2 id="++yall">++&nbsp;&nbsp;yall</h2>

###Examples
    ~dovryp-toblug/try=> (yawn 2.014 3 1)
    735.658
    ~dovryp-toblug/try=> (yall (yawn 2.014 3 1))
    [y=2.014 m=3 d=1]

###Summary
    ++  yall                                               ::  day # to day of year
      |=  day=@ud
      ^-  [y=@ud m=@ud d=@ud]
      =+  [era=0 cet=0 lep=_?]
      =>  .(era (div day era:yo), day (mod day era:yo))
      =>  ^+  .
          ?:  (lth day +(cet:yo))
            .(lep &, cet 0)
          =>  .(lep |, cet 1, day (sub day +(cet:yo)))
          .(cet (add cet (div day cet:yo)), day (mod day cet:yo))
      =+  yer=(add (mul 400 era) (mul 100 cet))
      |-  ^-  [y=@ud m=@ud d=@ud]
      =+  dis=?:(lep 366 365)
      ?.  (lth day dis)
        =+  ner=+(yer)
        $(yer ner, day (sub day dis), lep =(0 (end 0 2 ner)))
      |-  ^-  [y=@ud m=@ud d=@ud]
      =+  [mot=0 cah=?:(lep moy:yo moh:yo)]
      |-  ^-  [y=@ud m=@ud d=@ud]
      =+  zis=(snag mot cah)
      ?:  (lth day zis)
        [yer +(mot) +(day)]
      $(mot +(mot), day (sub day zis))


---
<h2 id="++yawn">++&nbsp;&nbsp;yawn</h2>

###Examples
    ~dovryp-toblug/try=> (yawn 2.014 3 1)
    735.658
    ~dovryp-toblug/try=> (yall (yawn 2.014 3 1))
    [y=2.014 m=3 d=1]

###Summary
    ++  yawn                                                ::  day # from AD    
      |=  [yer=@ud mot=@ud day=@ud]
      ^-  @ud
      =>  .(mot (dec mot), day (dec day))
      =>  ^+  .
          %=    .
              day
            =+  cah=?:((yelp yer) moy:yo moh:yo)
            |-  ^-  @ud
            ?:  =(0 mot)
              day
            $(mot (dec mot), cah (slag 1 cah), day (add day (snag 0 cah)))
          ==
      |-  ^-  @ud
      ?.  =(0 (mod yer 4))
        =+  ney=(dec yer)
        $(yer ney, day (add day ?:((yelp ney) 366 365)))
      ?.  =(0 (mod yer 100))
        =+  nef=(sub yer 4)
        $(yer nef, day (add day ?:((yelp nef) 1.461 1.460)))
      ?.  =(0 (mod yer 400))
        =+  nec=(sub yer 100)
        $(yer nec, day (add day ?:((yelp nec) 36.525 36.524)))
      (add day (mul (div yer 400) (add 1 (mul 4 36.524))))

---
<h2 id="++yelp">++&nbsp;&nbsp;yelp</h2>
###Examples
    ~dovryp-toblug/try=> (yelp 2.014)
    %.n

###Summary
    ++  yelp                                                ::  leap year
      |=  yer=@ud  ^-  ?
      &(=(0 (mod yer 4)) |(!=(0 (mod yer 100)) =(0 (mod yer 400))))

---
<h2 id="++yo">++&nbsp;&nbsp;yo</h2>

####Time constants.
###Examples

###Summary
    ++  yo
      |%  ++  cet  36.524                 ::  (add 24 (mul 100 365))
          ++  day  86.400                 ::  (mul 24 hor)
          ++  era  146.097                ::  (add 1 (mul 4 cet))
          ++  hor  3.600                  ::  (mul 60 mit)
          ++  jes  106.751.991.084.417    ::  (mul 730.692.561 era)
          ++  mit  60
          ++  moh  `(list ,@ud)`[31 28 31 30 31 30 31 31 30 31 30 31 ~]
          ++  moy  `(list ,@ud)`[31 29 31 30 31 30 31 31 30 31 30 31 ~]
          ++  qad  126.144.001            ::  (add 1 (mul 4 yer))
          ++  yer  31.536.000             ::  (mul 365 day)
      --

#Almost Macros

---
<h2 id="++hard">++&nbsp;&nbsp;hard</h2>
###Examples

###Summary
    ++  hard
      |*  han=$+(* *)
      |=  fud=*  ^-  han
      ~|  %hard
      =+  gol=(han fud)
      ?>(=(gol fud) gol)

---
<h2 id="++soft">++&nbsp;&nbsp;soft</h2>
###Examples

###Summary
    ++  soft
      |*  han=$+(* *)
      |=  fud=*  ^-  (unit han)
      =+  gol=(han fud)
      ?.(=(gol fud) ~ [~ gol])
