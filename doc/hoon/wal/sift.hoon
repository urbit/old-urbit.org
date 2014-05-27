!:
::  /=try=/bin/sift/hoon
::
=>  %=    .
        +
      =>  +
      |%
      ++  iota
        |=  [a=@ acc=(list ,@)]
        ^-  (list ,@)
        ?:  =(a 1)
          acc
        $(a (dec a), acc [a acc])
::
      ++  sift
        |=  a=@
        =+  ls=((list ,@) (iota a ~))
        (sift-aux ls ~)


::  
      ++  sift-aux
        |=  [quarry=(list ,@) primes=(list ,@)]
        ^-  (list ,@)
          ?~  quarry  primes
::           =+  lquarry=quarry
::          =+  lquarry=((list ,@) quarry)
          =+  mask=-.quarry
          =+  ^=  new-q
            (skip `(list ,@)`quarry |=(a=@ &(=(0 (mod a mask)) !=(a mask))))
        $(quarry t.+.new-q, primes [i.-.new-q primes])
      --
    ==
|=  *
|=  [a=@ ~]
^-  bowl
:_  ~  :_  ~
:-  %$
!>
(sift a)
::(sift a) - ~[11 7 5 3 2]
::TEST CASES
