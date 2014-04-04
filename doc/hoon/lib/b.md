---
layout: subpage
title: 2b Basic Containers
axis: doc-hoon
categories: lib
sort: 2
---

This section convers the basic container functions. Basic containers are units and lists.

#Units

##++bind

    ++  bind                                                    ::  argue
      |*  [a=(unit) b=_,*]
      ?~  a
        ~
      [~ u=(b u.a)]

++bind takes a unit and a gate and produces a new unit with b applied to u.a or no if a is no.

###Summary
++bind creates a [wet vulcanized gate |*]() which accepts a [++unit]() `a` and any [gate]() `b`. 
If `a` is null ([?~]()) ++bind produces null.
Otherwise ++bind produces a new [++unit]() with the `u` set to the product of the gate `b` with sample `a`.

###Examples
    ~talsur-todres/try=> (bind ((unit ,@) [~ 97]) ,@t)
    [~ 'a']


##++clap
    ++  clap                                                ::  combine
      |*  [a=(unit) b=(unit) c=_|=(^ +<-)]
      ?~  a
        b
      ?~  b
        a
      [~ u=(c u.a u.b)]

++clap takes two units `a` and `b` and a gate c. If `a` is ~ produce `b`, if `b` is ~ produce `a`, else produce the product of (c u.a u.b). 

###Summary
++clap creates a [wet vulcanized gate |*]() which accepts two [++unit]() `a` and `b` and a [gate]() `c`.
If `a` is null ([?~]()) ++clap produces null.
If `b` is null ([?~]()) ++clap produces null.
Otherwise ++clapp produces a new unit with the `u` set to the product of the gate `c` with the sample of [u.a u.b].

###Examples
    ~talsur-todres/try=> =a ((unit ,@u) [~ 1])
    ~talsur-todres/try=> =b ((unit ,@u) [~ 2])
    ~talsur-todres/try=> =c |=([a=@ b=@] (add a b))
    ~talsur-todres/try=> (clap a b c)
    [~ 3]


##++drop
    ++  drop                                                ::  enlist
      |*  a=(unit)
      ?~  a
        ~
      [i=u.a t=~]

++drop takes a unit `a` and produces a list [u.a ~] or ~ if a is ~.

###Summary
++drop creates a [wet vulcanized gate |*]() which accepts a [++unit]() `a`.
If `a` is null ([?~]()) ++drop produces null.
Otherwise ++drop produces a [++list]() [u.a ~].

###Examples
    ~divreg-misdef/try=> =a ((unit ,@) [~ 97])
    ~divreg-misdef/try=> (drop a)
    [i=97 t=~]
    ~divreg-misdef/try=> =a ((unit ,@) [~])
    ~divreg-misdef/try=> (drop a)
    ~


##++fall
    ++  fall                                                ::  default
      |*  [a=(unit) b=*]
      ?~(a b u.a)

++fall takes a unit `a` and any noun `b`. If `a` is null produce `b` else `u.a`.

###Summary
++fall creates a [wet vulcanized gate |*]() which accepts a [++unit]() `a`.
If `a` is null ([?~]()) ++drop produces `b`.
Otherwise ++drop produces `u.a`.

###Examples
    ~talsur-todres/try=> (fall ~ 'a')
    'a'
    ~talsur-todres/try=> (fall [~ u=0] 'a')
    0


##++mate
++  mate                                                ::  choose
  |*  [a=(unit) b=(unit)]
  ?~  b
    a
  ?~  a
    b
  ?.(=(u.a u.b) ~|('mate' !!) a)

++mate takes two units `a` and `b`. If not `b` then produce `a`, if not `a` then produce `b`, otherwise produce `a` if `u.a` and `u.b` are equal. Crash if they're not equal.

###Summary
++mate creates a [wet vulcanized gate |*]() which accepts two [++unit]() `a` and `b`.
If `b` is null ([?~]()) ++drop produces `a`.
If `a` is null ([?~]()) ++drop produces `b`.
Otherwise ++mate uses [?.]() to test the equality of `u.a` and `u.b` using [=](). 
If they are equal ++mate produces `a`, otherwise a 'mate' crash is produced.

###Examples
    ~divreg-misdef/try=> =a ((unit ,@) [~ 97])
    ~divreg-misdef/try=> =b ((unit ,@) [~ 97])
    ~divreg-misdef/try=> (mate a b)
    [~ 97]
    ~divreg-misdef/try=> =a ((unit ,@) [~ 97])
    ~divreg-misdef/try=> =b ((unit ,@) [~ 98])
    ~divreg-misdef/try=> (mate a b)
    ! 'mate'
    ! exit


##++need
    ++  need                                                ::  demand
      |*  a=(unit)
      ?@  a
        !!
      u.a

++need takes a unit `a`. If `a` is an atom produce a crash, else produce u.a. 

###Summary
++need creates a [wet vulcanized gate |*]() which accepts a [unit]() `a`.
If `a` is an atom ([?@]()) ++need produces a crash.
Otherwise ++need produces `u.a`.

###Examples
    ~divreg-misdef/try=> =a ((unit ,[@t @t]) [~ ['a' ' b']])
    ~divreg-misdef/try=> (need a)
    ['a' ' b']
    ~divreg-misdef/try=> =a ((unit ,@) [~])
    ~divreg-misdef/try=> (need a)
    ! exit


##++some
    ++  some                                                ::  lift
      |*  a=*
      [~ u=a]

++some takes any noun `a` and produces `[~ u=a]`.

###Summary
++some creates a [wet vulcanized gate |*]() which accepts any [noun]() `a`.
++some produces a unit `[~ u=a]`.

###Examples
    ~divreg-misdef/try=> (some ['a' 'b'])
    [~ u=['a' 'b']]
    ~divreg-misdef/try=> (some &)
    [~ u=%.y]


#Lists


##++flop
    ++  flop                                                ::  reverse
      ~/  %flop
      |*  a=(list)
      =>  .(a (homo a))
      ^+  a
      =+  b=`_a`~
      |-
      ?@  a
        b
      $(a t.a, b [i.a b])

++flop takes a list `a` and produces that list with the elements reversed.

###Summary
++flop is a [jetted arm (~/)]().
++flop creates a [wet vulcanized gate |*]() which accepts a [list]() `a`.
`a` is replaced with the product of `([homo]() a)` using [=>]().
The product of ++flop is cast to the type of `a` (a [list]()) with [^+]().
`b` is pushed on to the subject with [=+]() as a [list]() in the same form as `a`.
A dry %gold gate is created and kicked with [|-]().
If `a` is an atom, the gate produces b. 
Otherwise, produce a call to [$]() with `a` set to `t.a` and b set to `[i.a b]`.
Note: Refer to the [list]() documentation for clarification of t.a and i.a. 

###Examples
    ~dovryp-toblug/try=> (flop (limo [1 2 3 ~]))
    ~[3 2 1]
    ~dovryp-toblug/try=> (flop (flop (limo [1 2 3 ~])))
    ~[1 2 3]


##++homo
++  homo                                                ::  homogenize
      |*  a=(list)
      ^+  =<  $
        |%  +-  $  ?:(_? ~ [i=(snag 0 a) t=$])
        --
      a

??  This recursively snags the item at position 0 in a. Sort of like flatten? I can't contrive an example that works, so this is a tough one.


##++limo
++  limo                                                ::  listify
  |*  a=*
  ^+  =<  $
    |%  +-  $  ?@(a ~ ?:(_? [i=-.a t=$] $(a +.a)))
    --
  a

++limo accepts any null-terminated cell `a` and produces a list.

###Summary
++limo creates a [wet vulcanized gate |*]() which accepts any noun `a`.
The product of ++limo is cast, using [^+](), to the type of the product of [$]() using [=<]().
A [%gold core |%] is created.
??

###Examples
    ~dovryp-toblug/try=> (limo ['a' 'b' ~])
    [i='a' t=[i='b' t=~]]
    ~dovryp-toblug/try=> (limo [2 1 ~])
    [i=2 t=[i=1 t=~]]


++  lent                                                ::  length
  ~/  %lent
  |=  a=(list)
  ^-  @
  =+  b=0
  |-
  ?@(a b $(a t.a, b +(b)))

::  Produces an atom equal to the length of a list.
::  ~dovryp-toblug/try=> (lent (limo [1 2 3 4 5 6 ~]))
::  6

++  levy
  ~/  %levy                                             ::  all of
  |*  [a=(list) b=_|=(p=* .?(p))]
  |-  ^-  ?
  ?@  a
    &
  ?:  (b i.a)
    $(a t.a)
  |

::  Comparator. Send each value of a to a gate b that produces a loobean. 
::  Produce a loobean %.y if all the results pass, else %.n.
::  ~dovryp-toblug/try=> =a |=(a=@ (gte a 1))
::  ~dovryp-toblug/try=> (levy (limo [0 1 2 1 ~]) a)
::  %.n


++  lien                                                ::  some of
  ~/  %lien
  |*  [a=(list) b=$+(* ?)]
  |-  ^-  ?
  ?~  a  |
  ?:  (b i.a)  &
  $(a t.a)

::  Comparator. Send each value of a to a gate b that produces a loobean. 
::  Produce a loobean %.y if any of the results pass, else %.n.
::  ~dovryp-toblug/try=> =a |=(a=@ (gte a 1))
::  ~dovryp-toblug/try=> (lien (limo [0 1 2 1 ~]) a)
::  %.y


++  reel                                                ::  right fold
  ~/  %reel
  |*  [a=(list) b=_=|([p=* q=*] |.(q))]
  |-  ^+  q.b
  ?@  a
    q.b
  (b i.a $(a t.a))

::  a is a list and b is a function that takes two arguments. Recursively call
::  b with the right side of a. 
::  ~dovryp-toblug/try=> =a =|([p=@ q=@] |.((add p q)))
::  ~dovryp-toblug/try=> (reel (limo [1 3 6 ~]) a)
::  10


++  roll                                                ::  left fold
  ~/  %roll
  |*  [a=(list) b=_=|([p=* q=*] |.(q))]
  |-
  ^+  q.b
  ?@  a
    q.b
  $(a t.a, b b(q (b i.a q.b)))

::  a is a list and b is a gate that takes two arguments. Recursively call
::  b with the right side of a. 
::  ~dovryp-toblug/try=> =a =|([p=@ q=@] |.((sub p q)))
::  ~dovryp-toblug/try=> (roll (limo [1 3 6 ~]) a)
::  4


++  skid                                                ::  separate
  |*  [a=(list) b=$+(* ?)]
  |-  ^+  [p=a q=a]
  ?~  a  [~ ~]
  =+  c=$(a t.a)
  ?:((b i.a) [[i.a p.c] q.c] [p.c [i.a q.c]])

::  a is a list and b is a gate that produces a loobean. Recursively call 
::  b separating a in to two lists p results that produced %.y and q that
::  produced %.n
::  ~dovryp-toblug/try=> =a |=(a=@ (gth a 1))
::  ~dovryp-toblug/try=> (skid (limo [0 1 2 3 ~]) a)
::  [p=[i=2 t=[i=3 t=~]] q=[i=0 t=[i=1 t=~]]]

++  skim                                                ::  only
  ~/  %skim
  |*  [a=(list) b=_|=(p=* .?(p))]
  |-
  ^+  a
  ?@  a
    ~
  ?:((b i.a) [i.a $(a t.a)] $(a t.a))

::  a is a list and b is a gate that produces a loobean. Recursively call
::  b to produce a list containing the values in a that return %.y from b.
::  Inverse of skip.
::  ~dovryp-toblug/try=> =a |=(a=@ (gth a 1))
::  ~dovryp-toblug/try=> (skim (limo [0 1 2 3 ~]) a)
::  [i=2 t=[i=3 t=~]]


++  skip                                                ::  except
  ~/  %skip
  |*  [a=(list) b=_|=(p=* .?(p))]
  |-
  ^+  a
  ?@  a
    ~
  ?:((b i.a) $(a t.a) [i.a $(a t.a)])

::  a is a list and b is a gate that produces a loobean. Recursively call
::  b to produce a list containing the values in a that return %.n from b.
::  Inverse of skim.
::  ~dovryp-toblug/try=> =a |=(a=@ (gth a 1))
::  ~dovryp-toblug/try=> (skip (limo [0 1 2 3 ~]) a)
::  [i=0 t=[i=1 t=~]]

++  scag                                                ::  prefix
  |*  [a=@ b=(list)]
  |-  ^+  b
  ?:  |(?=(~ b) =(0 a))
    ~
  [i.b $(b t.b, a (dec a))]

::  a is an atom and b is a list. Produce the first a values of b. 
::  Inverse of slag.
::  ~dovryp-toblug/try=> (scag 2 (limo [0 1 2 3 ~]))
::  [i=0 t=[i=1 t=~]]


++  slag                                                ::  suffix
  |*  [a=@ b=(list)]
  |-  ^+  b
  ?:  =(0 a)
    b
  ?@  b
    ~
  $(b t.b, a (dec a))

::  a is an atom and b is a list. Produce the last a values of b. 
::  Inverse of scag.
::  ~dovryp-toblug/try=> (slag 2 (limo [0 1 2 3 ~]))
::  [i=2 t=[i=3 t=~]]


++  snag                                                ::  index
  ~/  %snag
  |*  [a=@ b=(list)]
  |-
  ?~  b
    ~|('snag-fail' !!)
  ?:  =(0 a)
    i.b
  $(b t.b, a (dec a))

::  a is an atom and b is a list. Produce the value at position a in b.
::  ~dovryp-toblug/try=> (snag 2 (limo [3 2 1 0 ~]))
::  1


++  sort                                                ::  quicksort
  ~/  %sort
  !:
  |*  [a=(list) b=$+([* *] ?)]
  =>  .(a ^.(homo a))
  |-  ^+  a
  ?~  a  ~
  %+  weld
    $(a (skim t.a |=(c=_i.a (b c i.a))))
  ^+  t.a
  [i.a $(a (skim t.a |=(c=_i.a !(b c i.a))))]

::  a is a list and b is a gate that takes two nouns and produces a loobean. 
::  Recursively call b to produce a new list with the members of a.
::  ~dovryp-toblug/try=> =a =|([p=@ q=@] |.((gth p q)))
::  ~dovryp-toblug/try=> (sort (limo [0 1 2 3 ~]) a)
::  ~[3 2 1 0]


++  swag                                                ::  infix
  |*  [[a=@ b=@] c=(list)]
  (scag b (slag a c))

:: [a b] is a cell and c is a list. Produces the values from a to b in c.
::  ~dovryp-toblug/try=> (swag [1 2] (limo [1 2 3 ~]))
::  [i=2 t=[i=3 t=~]] 


++  turn                                                ::  transform
  ~/  %turn
  |*  [a=(list) b=_,*]
  |-
  ?@  a
    ~
  [i=(b i.a) t=$(a t.a)]

::  a is a list and b is the clam of a noun. Recursively call b with the 
::  members of a to produce a new list. 
::  ~dovryp-toblug/try=> (turn (limo [104 111 111 110 ~]) ,@t)
::  <|h o o n|>


++  weld                                                ::  concatenate
  ~/  %weld
  |*  [a=(list) b=(list)]
  =>  .(a ^.(homo a), b ^.(homo b))
  |-  ^+  b
  ?~  a  b
  [i.a $(a t.a)]

::  a is a list and b is a list. Produces a list with a and b concatenated.
::  ~dovryp-toblug/try=> (weld (limo [1 2 3 ~]) (limo [4 5 6 ~]))
::  ~[1 2 3 4 5 6]


++  wild                                                ::  concatenate
  |*  [a=(list) b=(list)]
  =>  .(a ^.(homo a), b ^.(homo b))
  |-
  ?~  a  b
  [i=i.a $(a t.a)]

::  Exactly the same as weld, except wild doesn't cast back to a list:
::  
::  ~tomsyt-balsen/try=> (homo (weld "foo" "bar"))
::  ~[~~f ~~o ~~o ~~b ~~a ~~r]
::  ~tomsyt-balsen/try=> (homo (wild "foo" "bar"))
::  ! -find-limb.t
::  ! find-fork
::  ! exit



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2bC, gears                    ::
::

::  Gears are no longer used in this version of hoon. Should be removed and 
::  reintroduced later.
++  from                                                ::  range
  |=  [a=@ b=@]
  ^-  (gear ,@)
  =+  c=0
  |?
  ?:  =(c b)
    ~
  [i=a t=^?(..$(a +(a), c +(c)))]
::
++  long                                                ::
  |*  a=(gear)
  =+  b=0
  |-  ^-  @
  =+  c=(a)
  ?~  c
    b
  $(b +(b), a t.c)
::
++  lone  |*(a=* |?([i=a t=none]))                      ::
++  mill
  |*  [a=_,* b=(gear)]
  |?
  =+  c=(b)
  ?~  c
    ~
  [i=(a i.c) t=^?(..$(b t.c))]
::
++  none  |?(~)                                         ::
++  over                                                ::
  |=  [a=@ b=@]
  ^-  (gear ,@)
  |?
  ?:  =(a b)
    [i=a t=none]
  [i=a t=^?(..$(a +(a)))]
::
++  pull                                                ::
  |*  a=(gear)
  |=  b=_^+(|-(=+(b=(a) ?~(b ~ [i=i.b t=$(a t.b)]))) ~)
  ^+  b
  =+  c=(a)
  ?~  c
    b
  $(b [i.c b], a t.c)
::
++  push                                                ::
  |*  a=(gear)
  |=  b=_^+(|-(=+(b=(a) ?~(b ~ [i=i.b t=$(a t.b)]))) ~)
  ^+  b
  =+  c=((pull a) ~)
  ((pull (spin c)) b)
::
++  spin                                                ::
  |*  a=(list)
  =>  .(a `_(homo a)`a)
  |?
  ?~  a
    ~
  [i=i.a t=^?(..$(a t.a))]

>>>>>>> 4ef2770269ac90a6bca1bc784b3a66e5bc62dc44
