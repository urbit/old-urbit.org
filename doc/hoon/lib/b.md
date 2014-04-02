
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::  ::
::::              chapter 2b, basic containers          ::::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                Section 2bA, units                    ::
::

::  ++  unit  |*  a=_,*                                     ::  maybe
::            $|(~ [~ u=a])                                 ::

::  Takes a noun and is either a null or the cell [~ noun]


++  bind                                                    ::  argue
  |*  [a=(unit) b=_,*]
  ?~  a
    ~
  [~ u=(b u.a)]

::  Takes a unit and any gate, produces a unit [~ u=(the noun the unit 
::  noun)] apply the gate b to the u in unit a
::  ~talsur-todres/try=> (bind ((unit ,@) [~ 97]) ,@t)
::  [~ 'a']


++  clap                                                ::  combine
  |*  [a=(unit) b=(unit) c=_|=(^ +<-)]
  ?~  a
    b
  ?~  b
    a
  [~ u=(c u.a u.b)]

::  If a is ~ produce b, if b is ~ produce a
::  ~talsur-todres/try=> =a ((unit ,@u) [~ 1])
::  ~talsur-todres/try=> =b ((unit ,@u) [~ 2])
::  ~talsur-todres/try=> =c |=([a=@ b=@] (add a b))
::  ~talsur-todres/try=> (clap a b c)
::  [~ 3]


++  drop                                                ::  enlist
  |*  a=(unit)
  ?~  a
    ~
  [i=u.a t=~]

::  Takes a unit a. Produces a list [u.a ~] or ~ if a is null.


++  fall                                                ::  default
  |*  [a=(unit) b=*]
  ?~(a b u.a)

::  If not a return b else u.a
::  ~talsur-todres/try=> (fall ~ 'a')
::  'a'
::  ~talsur-todres/try=> (fall [~ u=0] 'a')
::  0


++  mate                                                ::  choose
  |*  [a=(unit) b=(unit)]
  ?~  b
    a
  ?~  a
    b
  ?.(=(u.a u.b) ~|('mate' !!) a)

::  Takes two units a and b. If not b then produce a, if not a then produce b,
::  else produce a if u.a and u.b are equal. Crash if they're not equal.


++  need                                                ::  demand
  |*  a=(unit)
  ?@  a
    !!
  u.a

::  Takes a unit a. If a is an atom produce a crash, else produce u.a. 


++  some                                                ::  lift
  |*  a=*
  [~ u=a]

::  Takes any noun a and produces [~ u=a]. 


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                Section 2bB, lists                    ::


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

::  Reverse the order of a list. 
::  ~dovryp-toblug/try=> (flop (limo [1 2 3 ~]))
::  ~[3 2 1]

++  homo                                                ::  homogenize
  |*  a=(list)
  ^+  =<  $
    |%  +-  $  ?:(_? ~ [i=(snag 0 a) t=$])
    --
  a

::  ??  This recursively snags the item at position 0 in a. Sort of like 
::  flatten?


++  limo                                                ::  listify
  |*  a=*
  ^+  =<  $
    |%  +-  $  ?@(a ~ ?:(_? [i=-.a t=$] $(a +.a)))
    --
  a

::  Turns any null-terminated cell in to a list. 
::  ~dovryp-toblug/try=> (limo ['a' 'b' ~])
::  [i='a' t=[i='b' t=~]]
::  ~dovryp-toblug/try=> (limo [2 1 ~])
::  [i=2 t=[i=1 t=~]]
::  ?? a=* but passing in 'a' type-fails. 


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

