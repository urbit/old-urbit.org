---
layout: subpage
title: 2c Noun Surgery
arms: [++bex, ++can, ++cat, ++cut, ++end, ++lsh, ++met, ++rap, ++rep, ++rsh, ++con, ++dis, ++mix, ++aor, ++dor, ++gor, ++hor, ++vor, ++fnv, ++mug, ++po, ++ind, ++ins, ++tod, ++tos, ++si, ++abs ++si, ++dif ++si, ++dul ++si, ++fra ++si, ++new ++si, ++old ++si, ++pro ++si, ++rem ++si, ++sum ++si, ++sun ++si, ++syn ++si, ++fe, ++dif ++fe, ++inv ++fi, ++net ++fi, ++out ++fi, ++rol ++fi, ++ror ++fi, ++sum ++fi, ++sit ++fi, ++rlyd, ++rlyh, ++rlyq, ++rlys, ++ryld, ++rylh, ++rylq, ++ryls, ++year, ++yore, ++yell, ++yule, ++yall, ++yawn, ++yelp, ++yo, ++hard, ++soft]
axis: doc-hoon
categories: lib
sort: 3
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

`++bex` is a [jetted arm (~/)]().  
`++bex` creates a dry `%gold` gate using [|=](), which accepts an atomic sample `a`, [axil @](), with [=, the irregular form of ^=]().  
The result of `++bex` is then cast to an atom with [^-]().  
If `a` is equal to 0, `++bex` produces 1.  
Otheriwse, `++bex` returns the product of 2 and `++bex` with the value of `a` replaced by [dec a]().  


<h2 id="++can">++&nbsp;&nbsp;can</h2>

####Assemble
`++can` accepts a bloq `a` and a list of cells `b`. `++can` assembles the tails of 'q'; the length of the tail is 'p' number of bloqs of size 'a'.

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

`++can` is a [jetted arm (~/)]().  
`++can` takes a [bloq]() `a` and [list]() `b` using [=, the irregular form of ^=]().  
The result is cast to an atom with [^-]().  
If 'b' is null ([?~]()) `++can` produces 0.    
Otherwise, `++can` calls `++mix` with two arguments:  
1.`++end`, which produces the tail of the first 'q' in the list; the length of the tail is 'p' number of [bloqs]() of size 'a'.     
2. `++lsh` with [bloq]() size 'a', the first 'p' of [list]() 'b', and the product of recursively calling ++can with the value of [list]() 'b' now set to its tail.


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

`++cat` is a [jetted arm(~/)]().  
`++cat` takes a [bloq]() 'a', and two atoms of [axil @]() labeled 'b' and 'c' with [=, the irregular form of ^=]().  
 ++cat uses [++met]() to measure the number of [bloqs]() of size 'a' that comprise 'b'.  
 'c' is then left-shifted by the same number of [bloqs]() of size 'a', and then added ([++add]()) to 'b'.  

<h2 id="++cut">++&nbsp;&nbsp;cut</h2>

####Slice
`++cut` accepts a bloq `a`, a cell of atoms `b` and `c` and an atom `d`.
`++cut` takes the [++tail]() of `d` right-shifted ([++rsh()) by a bloq of size `a`, `b` number of times.

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

`++cut` is a [jetted arm]().  
`++cut` creates a dry %gold gate using [|=](), whose sample takes a [bloq]() `a`, a cell of two atoms of[axil @](), labeled `b` and `c` respectively, and an atom of [axil @](), labeled `d`.  
All of these lables are produced by [=, the irregular form of ^=](). `++cut` then [right-shifts (++rsh)]() `d` by `b` number of bloqs of size `a`.  
`++cut` calls the arm [++end]() to return the tail of the result of [right-shifting]() `d`.  
The size of the tail is determined by the number of bloqs `c` of size `a`.

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

++end is a [jetted arm]() which creates a dry %gold gate using [|=](), whose sample takes a [bloq]() and two atoms of [axil @](), labeled 'b' and 'c' with [=, the irregular form of ^=](). ++end returns the remainder of dividing c by the result of [++bex]() of [++bex]() multiplied by b.


<h2 id="++lsh">++&nbsp;&nbsp;lsh</h2>

####Left shift
++lsh takes a bloq a and atoms b and c. ++lsh produces c shifted 'b' bloqs of size 'a' to the left.

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
++lsh is a [jetted arm]() which creates a dry %gold gate using [|=](), whose sample takes a [bloq]() and two atoms of [axil @](), labeled 'b' and 'c' with [=, the irregular form of ^=](). ++lsh multiplies 'c' by the result of [++bex]() of the product of [++bex]() of 'a' multiplied by 'b'.


<h2 id="++met">++&nbsp;&nbsp;met</h2>

####Measure
++met accepts a bloq a and an atom b. ++met produces a count of bloqs of size 'a' in atom 'b'.

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

++met is a [jetted arm]() which creates a dry %gold gate using [|=](), whose sample takes a [bloq]() and an atom of [axil @](), labeled 'b' with [=, the irregular form of ^=](). ++met uses [^-]() to cast its result to an atom of [axil @](), and uses [=+]() to push a variable 'c' onto the sample with a value of 0. Then ++met declares a [trap]() to enable recursion. If 'b' is equal to 0, then 'c' is returned. Otherwise, ++met recurses, this time with the value of 'b' set to the result of right-shifting ([++rsh]()) 'b' by one bloq of size 'a' to the right, with with the value of c set to +(c) [.+](). When the value of 'b' reaches 0, ++met returns the value of 'c', which will represent the number of bloqs of size 'a' b initially posessed.


<h2 id="++rap">++&nbsp;&nbsp;rap</h2>
    ++  rap                                                 ::  assemble nonzero
      ~/  %rap                                              ::  jet
      |=  [a=bloq b=(list ,@)]                              ::  gate, bloq, list in sample
      ^-  @                                                 ::  cast result to @
      ?@  b                                                 ::  if b is an @                                               
        0                                                   ::  then, return 0
      (cat a i.b $(b t.b))                                  ::  else ++cat


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

++rep is a [jetted arm]() that takes a [bloq]() and [list](), labeled 'a' and 'b' respectively using [=, the irregular form of ^=](). ++rep casts its result to an atom using [^-]() and then, using [=+](), it pushes a variable 'c' onto the sample and sets its value equal to 0. In order to loop, ++rep then declares a [trap]() using [|-](). The trap uses [?@]() to test whether 'b' is an atom or not. If yes, ++rep returns 0. Otherwise, ++rep returns ++con, which it passes two arguments: 1. ++lsh with [bloq]() size 'a', number of times 'c', and the [tail] of the head of 'b'; and, 2.  


<h2 id="++rip">++&nbsp;&nbsp;rip</h2>
    ++  rip                                                 ::  disassemble
      ~/  %rip
      |=  [a=bloq b=@]
      ^-  (list ,@)
      ?:  =(0 b)
        ~
      [(end a 1 b) $(b (rsh a 1 b))]


<h2 id="++rsh">++&nbsp;&nbsp;rsh</h2>

++rsh takes a bloq a and atoms b and c. ++rsh produces c shifted 'b' bloqs of size 'a' to the right.

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

++rsh [jetted arm]() which creates a dry %gold gate using [|=](), whose sample takes a [bloq]() and two atoms, [axil @](), labeled 'b' and 'c' with [=, the irregular form of ^=](). ++rsh divides 'c' by the result of [++bex]() of the product of [++bex]() of 'a' multiplied by 'b'. 


<h2 id="++con">++&nbsp;&nbsp;con</h2>

++con accepts two atoms a and b and performs an inclusive binary OR.

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

++con is a [jetted arm]() which creates a dry %gold gate using [|=](), whose sample takes two atoms, labeled 'a' and 'b' using [=, the irregular form of ^=](). ++con then pushes two atomic variables onto the subject, labeled 'a' and 'b' again by using [=](). With [^-](), ++con ensures its result is cast to an atom. Subsequently, ++con declares a [trap](), thus allowing it to loop. Using [?:]() and [?&](), ++con checks if both 'a' and 'b' are equal to 0. If yes, then ++con returns 'd'. Else, ++con uses the trap to loop, this time with the values of 'a' and 'b' both [right-shifted]() by one bit, and the value of 'c' now incremented using [+, the irregular form of .+](). The value of 'd'can also change: if either the last bit of 'a' (found using [++end]()) and the last bit of 'b' are equal ([.=]())to 0, then the value of 'd' becomes the sum of d and the result of left-shifting 1 by 'c' number of bits. Otherwise, d remains the same.     


<h2 id="++dis">++&nbsp;&nbsp;dis</h2>

++dis accepts two atoms a and b and performs a binary AND.

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

++dis is a [jetted arm]() which creates a dry %gold gate using [|=](), whose sample takes two atoms, labeled 'a' and 'b' using [=, the irregular form of ^=](). Then, using [=|](), two tiles, labeled 'c' and 'd', are [bunted]() onto the subject. In order to loop, ++dis then calls a trap with [|-](), whose result is cast to an atom with [^-](). The trap then uses an if statement by using [?:]():it uses [=, the irregular form of .= to check if either 'a' or 'b' is equal to 0 (the inclusive OR statement is called with [?|]()). If either statement returns true, then ++dis produces d. Otherwise, the trap loops, this time with the values of 'a' and 'b' both [right-shifted]() by one bit, and the value of 'c' now incremented with [+, the irregular form of .+](). The value of 'd'can also change: if neither the last bit of 'a' nor the last bit of 'b' are equal ([.=]())to 0, then the value of 'd' becomes the sum of d and the result ofleft-shifting 1 by 'c' number of bits. Otherwise, d remains the same.     


<h2 id="++mix">++&nbsp;&nbsp;mix</h2>

++mix accepts two atoms a and b and performs an exclusive binary OR.

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
      ?:  ?&(=(0 a) =(0 b))                                 ::  If 'a' & 'b' are 0
        d                                                   ::  Then, return 0, (d)
      %=  $                                                 ::  Recall ++ mix with:
        a   (rsh 0 1 a)                                     ::  a r-shifted 1 bit
        b   (rsh 0 1 b)                                     ::  b r-shifted 1 bit
        c   +(c)                                            ::  c incremented
        d   (add d (lsh 0 c =((end 0 1 a) (end 0 1 b))))    ::  Tall form?

++mix is a [jetted arm]() which creates a dry %gold gate using [|=](), whose sample takes two atoms, labeled 'a' and 'b' using [=, the irregular form of ^=](). ++mix then uses [^-]() to cast its result to an atom. ++mix then pushes two atomic variables onto the subject, labeled 'a' and 'b' again by using [^-](). Subsequently, ++mix declares a [trap](), thus allowing it to loop. Using [?:]() and [?&](), ++mix checks if both 'a' and 'b' are equal to 0. If yes, then ++mix returns 'd'. Else, ++mix uses the trap to loop, this time with the values of 'a' and 'b' both [right-shifted]() by one bit, and the value of 'c' now incremented using [+, the irregular form of .+](). The value of 'd' is also replaced with the sum of 'd' and the result of [=(), the irregular form of .=]() then [left-shifted]() by 1 bit 'c' number of times.


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

##++gor
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

##++hor
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

##++vor
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

##++fnv
###Examples

###Summary
    ++  fnv  |=(a=@ (end 5 1 (mul 16.777.619 a)))           ::  FNV scrambler

##++mug
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

##++po
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

##++si
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


++  fe                                                  ::  modulo bloq
  |_  a=bloq
  ++  dif  |=([b=@ c=@] (sit (sub (add out (sit b)) (sit c))))
  ++  inv  |=(b=@ (sub (dec out) (sit b)))
  ++  net  |=  b=@  ^-  @
           =>  .(b (sit b))
           ?:  (lte a 3)
             b
           =+  c=(dec a)
           %+  con
             (lsh c 1 $(a c, b (cut c [0 1] b)))
           $(a c, b (cut c [1 1] b))
  ++  out  (bex (bex a))
  ++  rol  |=  [b=bloq c=@ d=@]  ^-  @
           =+  e=(sit d)
           =+  f=(bex (sub a b))
           =+  g=(mod c f)
           (sit (con (lsh b g e) (rsh b (sub f g) e)))
  ++  ror  |=  [b=bloq c=@ d=@]  ^-  @
           =+  e=(sit d)
           =+  f=(bex (sub a b))
           =+  g=(mod c f)
           (sit (con (rsh b g e) (lsh b (sub f g) e)))
  ++  sum  |=([b=@ c=@] (sit (add b c)))
  ++  sit  |=(b=@ (end a 1 b))
  --
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cG, floating point           ::
::
++  rlyd  |=(red=@rd ~|(%real-nyet ^-([s=? h=@ f=@] !!)))
++  rlyh  |=(reh=@rh ~|(%real-nyet ^-([s=? h=@ f=@] !!)))
++  rlyq  |=(req=@rq ~|(%real-nyet ^-([s=? h=@ f=@] !!)))
++  rlys  |=(res=@rs ~|(%real-nyet ^-([s=? h=@ f=@] !!)))
++  ryld  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rd !!)))
++  rylh  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rh !!)))
++  rylq  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rq !!)))
++  ryls  |=([syn=? hol=@ fac=@] ~|(%real-nyet ^-(@rs !!)))
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cH, urbit time               ::
::
++  year                                                ::  date to @d
  |=  det=date
  ^-  @d
  =+  ^=  yer
      ?:  a.det
        (add 292.277.024.400 y.det)
      (sub 292.277.024.400 (dec y.det))
  =+  day=(yawn yer m.det d.t.det)
  (yule day h.t.det m.t.det s.t.det f.t.det)

::  ~dovryp-toblug/try=> =a [[a=%.y y=2.014] m=3 t=[d=20 h=5 m=42 s=53 f=~[0x7456]]]
::  ~dovryp-toblug/try=> (year a)
::  0x8000000d21c88d5d7456000000000000
::  ??  Why does this return hex?


++  yore                                                ::  @d to date
  |=  now=@d
  ^-  date
  =+  rip=(yell now)
  =+  ger=(yall d.rip)
  :-  ?:  (gth y.ger 292.277.024.400)
        [a=& y=(sub y.ger 292.277.024.400)]
      [a=| y=+((sub 292.277.024.400 y.ger))]
  [m.ger d.ger h.rip m.rip s.rip f.rip]

::  ~dovryp-toblug/try=> (yore a)
::  [[a=%.y y=2.014] m=3 t=[d=20 h=5 m=42 s=53 f=~[0x7456]]]


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

::  ~dovryp-toblug/try=> (yell ~2014.3.20..05.42.53..7456)
::  [d=106.751.991.820.094 h=5 m=42 s=53 f=~[0x7456]]


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

::  ~dovryp-toblug/try=> (yule (yell ~2014.3.20..05.42.53..7456))
::  0x8000000d21c88d5d7456000000000000


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

::  ~dovryp-toblug/try=> (yawn 2.014 3 1)
::  735.658
::  ~dovryp-toblug/try=> (yall (yawn 2.014 3 1))
::  [y=2.014 m=3 d=1]


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

::  ~dovryp-toblug/try=> (yawn 2.014 3 1)
::  735.658
::  ~dovryp-toblug/try=> (yall (yawn 2.014 3 1))
::  [y=2.014 m=3 d=1]


++  yelp                                                ::  leap year
  |=  yer=@ud  ^-  ?
  &(=(0 (mod yer 4)) |(!=(0 (mod yer 100)) =(0 (mod yer 400))))

::  ~dovryp-toblug/try=> (yelp 2.014)
::  %.n


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
::  A kelp of time constants.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cI, almost macros            ::
::
++  hard
  |*  han=$+(* *)
  |=  fud=*  ^-  han
  ~|  %hard
  =+  gol=(han fud)
  ?>(=(gol fud) gol)
::
++  soft
  |*  han=$+(* *)
  |=  fud=*  ^-  (unit han)
  =+  gol=(han fud)
  ?.(=(gol fud) ~ [~ gol])
