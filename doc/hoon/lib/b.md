---
layout: subpage
title: 2b Basic Containers
section: 2b
arms: [++bind, ++clap, ++drop, ++fall, ++mate, ++need, ++some, ++flop, ++homo, ++limo, ++lent, ++levy, ++lien, ++reel, ++roll, ++skid, ++skim, ++skip, ++scag, ++slag, ++snag, ++sort, ++swag, ++turn, ++weld, ++wild]
axis: doc-hoon
categories: lib
sort: 2
---

This section convers the basic container functions. Basic containers are [++unit]() and [++list](). 

##++bind

####Apply `b`
`++bind` takes a [++unit]() and a [gate]() and produces a [++unit]() with `b` applied to `u.a` or null if a is null.

###Examples
    ~talsur-todres/try=> (bind ((unit ,@) [~ 97]) ,@t)
    [~ 'a']
    ~talsur-todres/try=> =a |=(a=@ (add a 1))
    ~talsur-todres/try=> (bind ((unit ,@) [~ 2]) a)
    [~ 3]

###Summary
    ++  bind                                                    ::  argue
      |*  [a=(unit) b=_,*]
      ?~  a
        ~
      [~ u=(b u.a)]

`++bind` creates a [wet vulcanized gate |*]() which accepts a [++unit]() `a` and any [gate]() `b`.  
If `a` is null ([?~]()) `++bind` produces null.  
Otherwise, `++bind` produces a new [++unit]() where the face `u` is set to the product of the gate `b` with sample `a`, `(b u.a)`.  


##++clap

####Combine
`++clap` passes the `u.a` and `u.b` in two [++unit]() `a` and `b` to the gate `c` and produces a new [++unit]() with the result. If `a` or `b` is null, `++clap` produces null.

###Examples
    ~talsur-todres/try=> =a ((unit ,@u) [~ 1])
    ~talsur-todres/try=> =b ((unit ,@u) [~ 2])
    ~talsur-todres/try=> =c |=([a=@ b=@] (add a b))
    ~talsur-todres/try=> (clap a b c)
    [~ 3]

###Summary
    ++  clap                                                ::  combine
      |*  [a=(unit) b=(unit) c=_|=(^ +<-)]
      ?~  a
        b
      ?~  b
        a
      [~ u=(c u.a u.b)]
`++clap` creates a [wet vulcanized gate |*]() which accepts two [++unit]() `a` and `b` and a [gate]() `c`.  
If `a` is null ([?~]()) `++clap` produces null.  
If `b` is null ([?~]()) `++clap` produces null.  
Otherwise `++clap` produces a new [++unit]() with the `u` set to the product of the gate `c` with the sample of `[u.a u.b]`, `[~ u=(c u.a u.b)]`.  


##++drop

####Listify
`++drop` takes a unit `a` and produces a list `[u.a ~]`, or null if `a` is null.

###Examples
    ~divreg-misdef/try=> =a ((unit ,@) [~ 97])
    ~divreg-misdef/try=> (drop a)
    [i=97 t=~]
    ~divreg-misdef/try=> =a ((unit ,@) [~])
    ~divreg-misdef/try=> (drop a)
    ~

###Summary
    ++  drop                                                ::  enlist
      |*  a=(unit)
      ?~  a
        ~
      [i=u.a t=~]
`++drop` creates a [wet vulcanized gate |*]() which accepts a [++unit]() `a`.  
If `a` is null ([?~]()) `++drop` produces null.  
Otherwise `++drop` produces a [++list]() [u.a ~].  


##++fall

####Default
`++fall` takes a [++unit]() `a` and any noun `b`. If `a` is null produce `b` else `u.a`.

###Examples
    ~talsur-todres/try=> (fall ~ 'a')
    'a'
    ~talsur-todres/try=> (fall [~ u=0] 'a')
    0

###Summary
    ++  fall                                                ::  default
      |*  [a=(unit) b=*]
      ?~(a b u.a)
`++fall` creates a [wet vulcanized gate |*]() which accepts a [++unit]() `a`.
If `a` is null ([?~]()) `++drop` produces `b`.
Otherwise `++drop` produces `u.a`.


##++mate

####Choose
`++mate` takes two [++unit]() `a` and `b` and produces either the [++unit]() `a` or `b` that is not null, `a` if they are equal or crashes with `'mate'` if they are not.

###Examples
    ~divreg-misdef/try=> =a ((unit ,@) [~ 97])
    ~divreg-misdef/try=> =b ((unit ,@) [~ 97])
    ~divreg-misdef/try=> (mate a b)
    [~ 97]
    ~divreg-misdef/try=> =a ((unit ,@) [~ 97])
    ~divreg-misdef/try=> =b ((unit ,@) [~])
    ~divreg-misdef/try=> (mate a b)
    [~ 97]
    ~divreg-misdef/try=> =a ((unit ,@) [~ 97])
    ~divreg-misdef/try=> =b ((unit ,@) [~ 98])
    ~divreg-misdef/try=> (mate a b)
    ! 'mate'
    ! exit

###Summary
    ++  mate                                                ::  choose
      |*  [a=(unit) b=(unit)]
      ?~  b
        a
      ?~  a
        b
      ?.(=(u.a u.b) ~|('mate' !!) a)
`++mate` creates a [wet vulcanized gate |*]() which accepts two [++unit]() `a` and `b`.
If `b` is null ([?~]()) `++drop` produces `a`.
If `a` is null ([?~]()) `++drop` produces `b`.
Otherwise `++mate` uses [?.]() to test the equality of `u.a` and `u.b` using [=](). 
If they are equal `++mate` produces `a`. 
Otherwise a crash is produced with the message `'mate'`, using [~|].


##++need

####Demand
`++need` takes a unit `a` and produces `u.a`. If `a` is null `++need` crashes.

###Examples
    ~divreg-misdef/try=> =a ((unit ,[@t @t]) [~ ['a' ' b']])
    ~divreg-misdef/try=> (need a)
    ['a' ' b']
    ~divreg-misdef/try=> =a ((unit ,@) [~])
    ~divreg-misdef/try=> (need a)
    ! exit

###Summary
    ++  need                                                ::  demand
      |*  a=(unit)
      ?@  a
        !!
      u.a
`++need` creates a [wet vulcanized gate |*]() which accepts a [unit]() `a`.
If `a` is an atom ([?@]()) `++need` produces a crash.
Otherwise `++need` produces `u.a`.


##++some

####Lift
`++some` takes any noun `a` and produces the [++unit]() `[~ u=a]`.

###Examples
    ~divreg-misdef/try=> (some ['a' 'b'])
    [~ u=['a' 'b']]
    ~divreg-misdef/try=> (some &)
    [~ u=%.y]

###Summary
    ++  some                                                ::  lift
      |*  a=*
      [~ u=a]
`++some` creates a [wet vulcanized gate |*]() which accepts any [noun]() `a`.
`++some` produces a unit `[~ u=a]`.


#Lists

##++flop

####Reverse
`++flop` takes a list `a` and produces `a` with the elements reversed.

###Examples
    ~dovryp-toblug/try=> (flop (limo [1 2 3 ~]))
    ~[3 2 1]
    ~dovryp-toblug/try=> (flop (flop (limo [1 2 3 ~])))
    ~[1 2 3]

###Summary
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
`++flop` is a [jetted arm (~/)]().  
`++flop` creates a [wet vulcanized gate |*]() which accepts a [list]() `a`.  
`a` is replaced with the product of `([homo]() a)` using [%=]() in its irregular form, `( )`.  
This new subject is used for the rest of the expression using [=>]().  
The product of `++flop` is cast to the type of `a` (a [list]()) with [^+]().  
`b` is pushed on to the subject with [=+]() as a [list]() in the same form as `a`.  
A dry `%gold` gate is created and kicked with [|-]().  
If `a` is an atom, the gate produces b.  
Otherwise, produce a call to [$]() with `a` set to `t.a` and b set to `[i.a b]`.  
Note: Refer to the [list]() documentation for clarification of `t.a` and `i.a`.  


##++homo

`++homo` takes a list `a` and produces a [++list]() with the type information homogenized.

###Examples
    ~barred-tidset/try=> =a (limo [1 2 3 ~])
    ~barred-tidset/try=> a
    [i=1 t=[i=2 t=[i=3 t=~]]]
    ~barred-tidset/try=> (homo a)
    ~[1 2 3]

###Summary
    ++  homo                                                ::  homogenize
      |*  a=(list)
      ^+  =<  $
        |%  
        +-  $  
          ?:(_? ~ [i=(snag 0 a) t=$])
        --
      a
`++homo` creates a [wet vulcanized gate |*]() which accepts a [list]() `a`.
The product of `++homo` is cast, using [^+]() to the type of the product of [=<]().
??  this seems like a pretty unconventional kind of recursion


##++limo

####Listify.

`++limo` accepts any null-terminated cell `a` and produces a [++list]().

###Examples
    ~dovryp-toblug/try=> (limo ['a' 'b' ~])
    [i='a' t=[i='b' t=~]]
    ~dovryp-toblug/try=> (limo [2 1 ~])
    [i=2 t=[i=1 t=~]]

###Summary
    ++  limo                                                
      |*  a=*
      ^+  =<  $
        |%  +-  $  ?@(a ~ ?:(_? [i=-.a t=$] $(a +.a)))
        --
      a
`++limo` creates a [wet vulcanized gate |*]() which accepts any noun `a` [1].  
The product of `++limo` is cast, using [^+](), to the type of the product of [$]() using [=<]() [2].  
A [%gold core |%]() is created.  
??  similarly strange recursion here


##++lent

####Length
`++lent` takes a list `a` and produces an atom equal to the length of `a`.

###Examples
    ~barred-tidset/try=> (lent `(list)`[1 2 3 4 5 6 7 ~])
    7
    ~barred-tidset/try=> (lent `(list)`[~])
    0

###Summary
    ++  lent                                                ::  length
      ~/  %lent
      |=  a=(list)
      ^-  @
      =+  b=0
      |-
      ?@(a b $(a t.a, b +(b)))
`++lent` is a [jetted arm (~/)]().
`++lent` creates a [dry %gold gate |=]() that takes a [list]() `a`.
The product of `++lent` is cast to an atom with [^-]().
`b=0` is pushed on to the subject with =+.
A [dry %gold trap |-]() is created and kicked.
If `a` is an atom ([?@]()) b is produced.
Otherwise, `a` is replaced by `t.a` (descending in to the list) and `b` is replaced by `+(b)` (incrementing `b`)


##++levy

####Test every
`++levy` takes a [++list]() `a` and a [gate]() `b` that produces a loobean. `++levy` sends each member of `a` to `b` and produces `%.y` if each result is `%.y` and `%.n` if not.

###Examples
    ~barred-tidset/try=> =b |=(a=@ (gte a 1))
    ~barred-tidset/try=> (levy (limo [0 1 2 1 ~]) b)
    %.n
    ~barred-tidset/try=> =b |=(a=@ (gte a 0))
    ~barred-tidset/try=> (levy (limo [0 1 2 1 ~]) b)
    %.y

###Summary
    ++  levy
      ~/  %levy                                             ::  all of
      |*  [a=(list) b=_|=(p=* .?(p))]
      |-  ^-  ?
      ?@  a
        &
      ?:  (b i.a)
        $(a t.a)
      |
`++levy` is a [jetted arm (~/)]().
`++levy` creates a [wet vulcanized gate |*]() which accepts a [++list]() `a` and a gate `b` which produces a loobean.
A [dry %gold trap |-]() is created and kicked.
The product of the trap is cast ([^-]()) to a loobean.
If `a` is an atom ([?@]()) produce `%.y` (??  since lists have faces, this only occurs with the terminator ~ ?)
If the product of `(b i.a)` is `%.y` ([?:]()) recurse replacing `a` with `t.a` using `$` and the irregular form of [%=](), `( )`.


##++lien

####Test any
`++levy` takes a [++list]() `a` and a [gate]() `b` that produces a loobean. `++levy` sends each member of `a` to `b` and produces `%.y` if any result is `%.y` and `%.n` if none are `%.y`.

###Examples
    ~barred-tidset/try=> =a |=(a=@ (gte a 1))
    ~barred-tidset/try=> (lien (limo [0 1 2 1 ~]) a)
    %.y
    ~barred-tidset/try=> =a |=(a=@ (gte a 3))
    ~barred-tidset/try=> (lien (limo [0 1 2 1 ~]) a)
    %.n

###Summary
    ++  lien                                                ::  some of
      ~/  %lien
      |*  [a=(list) b=$+(* ?)]
      |-  ^-  ?
      ?~  a  |
      ?:  (b i.a)  &
      $(a t.a)
`++lien` is a [jetted arm (~/)]().
`++lien` creates a [wet vulcanized gate |*]() which accepts a [++list]() `a` and a gate `b` which produces a loobean.
A [dry %gold trap |-]() is created and kicked.
The product of the trap is cast ([^-]()) to a loobean.
If `a` is null ([?~]())produce `%.n`.
If the product of `(b i.a)` is `%.y` ([?:]()) produce `%.y`.
Otherwise recurse, replacing `a` with `t.a` using `$` and the irregular form of [%=](), `( )`.


##++reel

####Right fold
`++reel` takes a [++list]() `a` and a [gate]() `b` that takes two nouns. `++reel` recursively calls `b` with the right side of `a`.

###Examples
    ~barred-tidset/try=> =a =|([p=@ q=@] |.((sub p q)))
    ~barred-tidset/try=> (reel (limo [6 3 1 ~]) a)
    4
    ~barred-tidset/try=> (reel (limo [3 6 1 ~]) a)
    ! subtract-underflow
    ! exit

###Summary
    ++  reel                                                ::  right fold
      ~/  %reel
      |*  [a=(list) b=_=|([p=* q=*] |.(q))]
      |-  ^+  q.b
      ?@  a
        q.b
      (b i.a $(a t.a))
`++reel` is a [jetted arm (~/)]().
`++roll` creates a [wet vulcanized gate |*]() which accepts a list `a` and a gate `b` which accepts two nouns `p` and `q`. 
A [dry %gold trap |-]() is created and kicked.
The product is cast ([^+]()) to the type of `q.b`.
If `a` is an atom ([?@]()), `q.b` is produced. 
Otherwise `b` is called with the left side of `a` (i.a), and the product of the trap with `a` replaced with `t.a` (the 'right side' of `a`). 


##++roll
    
####Left fold
`++roll` takes a [++list]() `a` and a [gate]() `b` that takes two nouns. `++reel` recursively calls `b` with the left side of `a`.

###Examples
    ~barred-tidset/try=> =a =|([p=@ q=@] |.((sub p q)))
    ~barred-tidset/try=> (roll (limo [1 2 3 ~]) a)
    2
    ~barred-tidset/try=> (roll (limo [3 6 3 ~]) a)
    0

###Summary
++  roll                                                ::  left fold
      ~/  %roll
      |*  [a=(list) b=_=|([p=* q=*] |.(q))]
      |-
      ^+  q.b
      ?@  a
        q.b
      $(a t.a, b b(q (b i.a q.b)))
`++roll` is a [jetted arm (~/)]().
`++roll` creates a [wet vulcanized gate |*]() which accepts a list `a` and a gate `b` which accepts two nouns `p` and `q`. 
A [dry %gold trap |-]() is created and kicked.
The product is cast ([^+]()) to the type of `q.b`.
If `a` is an atom ([?@]()), `q.b` is produced. 
Otherwise the trap is called with `a` replaced with `t.a` and `b` where `q.b` is replaced with the product of `(b i.a q.b)` .


##++skid

####Separate
`++skid` takes a [++list]() `a` and a [gate]() `b` that produces a loobean. `++skid` recursively calls `b` separating `a` into two lists: `p` that produced `%.y` and `q` that produced `%.n`.

###Examples
    ~dovryp-toblug/try=> =a |=(a=@ (gth a 1))
    ~dovryp-toblug/try=> (skid (limo [0 1 2 3 ~]) a)
    [p=[i=2 t=[i=3 t=~]] q=[i=0 t=[i=1 t=~]]]

###Summary
    ++  skid                                                ::  separate
      |*  [a=(list) b=$+(* ?)]
      |-  ^+  [p=a q=a]
      ?~  a  [~ ~]
      =+  c=$(a t.a)
      ?:((b i.a) [[i.a p.c] q.c] [p.c [i.a q.c]])
`++skid` creates a [wet vulcanized gate |*]() which accepts a list `a` and a gate `b` which produces a loobean.
A [dry %gold trap |-]() is created and kicked.
The product is cast ([^+]()) to a cell `[p=a q=a]`; a cell where both `p` and `q` are `++list`.
If a is null ([?~]()), produce the cell `[~ ~]`.
Add `c` to the subject ([=+]()) and assign it to the product of the trap with `a` set to `t.a`.
If the product of `(b i.a)` is `%.y`, produce `[[i.a p.c] q.c]`.
Otherwise produce `[p.c [i.a q.c]]`.


##++skim

####Filter %.y
`++skim` takes a [++list]() `a` and a [gate]() `b` that produces a loobean. `++skim` calls `b` with each member of `a` to produce a list containing the values in `a` that return `%.y` from `b`. Inverse of `++skip`.

###Examples
    ~dovryp-toblug/try=> =a |=(a=@ (gth a 1))
    ~dovryp-toblug/try=> (skim (limo [0 1 2 3 ~]) a)
    [i=2 t=[i=3 t=~]]

###Summary
    ++  skim                                                ::  only
      ~/  %skim
      |*  [a=(list) b=_|=(p=* .?(p))]
      |-
      ^+  a
      ?@  a
        ~
      ?:((b i.a) [i.a $(a t.a)] $(a t.a))
`++skim` is a [jetted arm (~/)]().
`++skim` creates a [wet vulcanized gate |*]() which accepts a list `a` and a gate `b` which produces a loobean.
A [dry %gold trap |-]() is created and kicked.
The product is cast ([^+]()) to a `++list`, since `a` is a `++list`.
If `a` is an atom ([?@]()) return null.
Otherwise if the product of `(b i.a)` is `%.y` produce `[i.a $(a t.a)]`, if not recurse (using the empty name `$` and the irregular form of [%=], `( )`) with `a` set to `t.a`.


##++skip

####Filter %.n
`++skip` takes a [++list]() `a` and a [gate]() `b` that produces a loobean. `++skip` recursively calls `b` to produce a list containing the values in `a` that return `%.n` from `b`. Inverse of `++skim`.

###Examples
    ~dovryp-toblug/try=> =a |=(a=@ (gth a 1))
    ~dovryp-toblug/try=> (skip (limo [0 1 2 3 ~]) a)
    [i=0 t=[i=1 t=~]]

###Summary
    ++  skip                                                ::  except
      ~/  %skip
      |*  [a=(list) b=_|=(p=* .?(p))]
      |-
      ^+  a
      ?@  a
        ~
      ?:((b i.a) $(a t.a) [i.a $(a t.a)])
`++skip` is a [jetted arm (~/)]().
`++skip` creates a [wet vulcanized gate |*]() which accepts a list `a` and a gate `b` which produces a loobean.
A [dry %gold trap |-]() is created and kicked.
The product is cast ([^+]()) to a `++list`, since `a` is a `++list`.
If `a` is an atom ([?@]()) return null.
Otherwise if the product of `(b i.a)` is `%.y` recurse (using the empty name `$` and the irregular form of [%=]()) with `a` set to `t.a`, if not produce `[i.a $(a t.a)]`.


##++scag
    
####Prefix
`++scag` takes an atom `a` and a [++list]() `b`. Produces the first `a` members of `b`. Inverse of `++slag`.

###Examples
    ~dovryp-toblug/try=> (scag 2 (limo [0 1 2 3 ~]))
    [i=0 t=[i=1 t=~]]

###Summary
    ++  scag                                                ::  prefix
          |*  [a=@ b=(list)]
          |-  ^+  b
          ?:  |(?=(~ b) =(0 a))
            ~
          [i.b $(b t.b, a (dec a))]
`++scag` creates a [wet vulcanized gate |*]() which accepts an atom `a` and a `++list` `b`.
A [dry %gold trap |-]() is created and kicked.
The product is cast ([^+]()) to a `++list` (the type of `b`).
If either ([logical or |, irregular form of ?|]()) `b` is null ([?=]()) or `a` is 0 ([=, irregular .=]()) produce null. 
Otherwise produce a cell with `i.b` and the product of the trap with `b` replaced with `t.b` and `a` replaced with `([dec]() a)`.


##++slag

####Suffix
`++slag` takes an atom `a` and a [++list]() `b`. Produces the last `a` members of `b`. Inverse of `++scag`.

###Examples
    ~dovryp-toblug/try=> (slag 2 (limo [0 1 2 3 ~]))
    [i=2 t=[i=3 t=~]]

###Summary
    ++  slag                                                ::  suffix
      |*  [a=@ b=(list)]
      |-  ^+  b
      ?:  =(0 a)
        b
      ?@  b
        ~
      $(b t.b, a (dec a))
`++scag` creates a [wet vulcanized gate |*]() which accepts an atom `a` and a `++list` `b`.
A [dry %gold trap |-]() is created and kicked.
The product is cast ([^+]()) to a `++list` (the type of `b`).
If ([?:]()) `a` is 0 (irregular [.=](), =), produce `b`. 
If `b` is an atom ([?@]()), produce null.
Otherwise produce the product of the trap with `b` replaced with `t.b` and `a` replaced with `([dec]() a)`.


##++snag

####Index
`++snag` takes an atom `a` and a [++list]() `b`. Produces the value of `b` at position `a`.

###Examples
    ~dovryp-toblug/try=> (snag 2 (limo [3 2 1 0 ~]))
    1

###Summary
    ++  snag                                                ::  index
      ~/  %snag
      |*  [a=@ b=(list)]
      |-
      ?~  b
        ~|('snag-fail' !!)
      ?:  =(0 a)
        i.b
      $(b t.b, a (dec a))
`++snag` is a [jetted arm (~/)]().  
`++snag` creates a [wet vulcanized gate |*]() which accepts an atom `a` and a `++list` `b`.  
A [dry %gold trap |-]() is created and kicked.  
If `b` is null ([?~]()) [~|]() prints a 'snag-fail' before crashing with [!!]().  
If ([?:]()) `a` is 0 (irregular [.=](), =), produce `i.b`.  
Otherwise produce the product of the trap with `b` replaced with `t.b` and `a` replaced with `(dec a)`.  


##++sort
    
####Quicksort
`++sort` takes a [++list]() `a` and a [gate]() `b` that takes two nouns and produces a loobean. `++sort` recursively calls `b` to produce a new list with the members of `a` sorted according to `b`.

###Examples
    ~dovryp-toblug/try=> =a =|([p=@ q=@] |.((gth p q)))
    ~dovryp-toblug/try=> (sort (limo [0 1 2 3 ~]) a)
    ~[3 2 1 0]

###Summary
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
`++sort` is a [jetted arm (~/)]().  
`++sort` creates a [wet vulcanized gate |*]() which accepts a list `a` and a gate `b` which produces a loobean from two nouns.
The subject is replaced with `(homo a)` ([=>]()).
A [dry %gold trap |-]() is created and kicked.
The product is cast to the type of `a`, a `++list`.
If `a` is null ([?~]()) return null.
`++weld` is (slammed)[] using [%+]() with two things:
The result of calling the trap with `a` replaced by the result of `++skim` applied to `t.a` with the gate ([|=]()) using `b` to compare `i.a`. 
The cell composed of `i.a` and the result of calling the trap with `a` replaced by the result of `++skim` applied to `t.a` with the gate [|=]() producing the logical 'not' of `(b c i.a)`.
??  this needs work. why do those gates use _i.a?


##++swag

####Infix
`++swag` takes a cell of atoms `[a b]` and a list `c`. `++swag` produces the values between the indices `a` and `b` in `c`.

###Examples
    ~dovryp-toblug/try=> (swag [1 2] (limo [1 2 3 ~]))
    [i=2 t=[i=3 t=~]] 

###Summary
    ++  swag                                                ::  infix
      |*  [[a=@ b=@] c=(list)]
      (scag b (slag a c))
`++swag` creates a [wet vulcanized gate |*]() which accepts a cell of atoms `[a=@ b=@]` and a list `c`.
`[++scag]()` produces the first `b` members of `[++slag]()`, which produces the last `a` members of `c`.


##++turn

####Transform
`++turn` takes a list `a` and the clam of a noun `b`. `++turn` produces a new list with all the values of `a` produced by `b`.

###Examples
    ~dovryp-toblug/try=> (turn (limo [104 111 111 110 ~]) ,@t)
    <|h o o n|>

###Summary
    ++  turn                                                ::  transform
      ~/  %turn
      |*  [a=(list) b=_,*]
      |-
      ?@  a
        ~
      [i=(b i.a) t=$(a t.a)]
`++turn` is a [jetted arm (~/)]().
`++turn` creates a [wet vulcanized gate |*]() which accepts a list `a` and the clam (`_`, irregular form of `$,`) of the bunt (`,`, irregular form of `$,`) of any noun `b`.
A [dry %gold trap |-]() is created and kicked.
If `a` is an atom ([?@]()) produce null.
Otherwise, produce a cell where i is (b i.a) and t is the product of the gate with a replaced with t.a. 


##++weld

####Concatenate
`++weld` takes two `++list` `a` and `b` and produces a list with `a` and `b` concatenated.

###Examples
    ~dovryp-toblug/try=> (weld (limo [1 2 3 ~]) (limo [4 5 6 ~]))
    ~[1 2 3 4 5 6]

###Summary
    ++  weld                                                ::  concatenate
        ~/  %weld
        |*  [a=(list) b=(list)]
        =>  .(a ^.(homo a), b ^.(homo b))
        |-  ^+  b
        ?~  a  b
        [i.a $(a t.a)]
`++weld` is a [jetted arm (~/)]().  
`++weld` creates a [wet vulcanized gate |*]() which accepts two `++list` `a` and `b`.
The subject is replaced using [=>]() with the `a` as `(homo a)` and `b` as `(homo b)`.
A [dry %gold trap |-]() is created and kicked.
The product is cast to a `++list` (the type of `b`).
If `a` is null ([?~]()) produce `b`.
Otherwise produce a cell containing i.a and the product of the gate with `a` replaced with `t.a`.


##++wild

####Concatenate, no type
`++wild` takes two `++list`, `a` and `b` and produces a cell with the values of `a` and `b`. Same as `++weld`, but without casting back to a `++list`.

###Examples
    ~tomsyt-balsen/try=> (homo (weld "foo" "bar"))
    ~[~~f ~~o ~~o ~~b ~~a ~~r]
    ~tomsyt-balsen/try=> (homo (wild "foo" "bar"))
    ! -find-limb.t
    ! find-fork
    ! exit

###Summary
    ++  wild                                                ::  concatenate
      |*  [a=(list) b=(list)]
      =>  .(a ^.(homo a), b ^.(homo b))
      |-
      ?~  a  b
      [i=i.a $(a t.a)]
`++wild` creates a [wet vulcanized gate |*]() which accepts two `++list` `a` and `b`.
The subject is replaced using [=>]() with the `a` as `(homo a)` and `b` as `(homo b)`.
A [dry %gold trap |-]() is created and kicked.
If `a` is null ([?~]()) produce `b`.
Otherwise produce a cell containing i.a and the product of the gate with `a` replaced with `t.a`.

#Gears

Gears are no longer used in this version of hoon.

##++from
    ++  from                                                ::  range
      |=  [a=@ b=@]
      ^-  (gear ,@)
      =+  c=0
      |?
      ?:  =(c b)
        ~
      [i=a t=^?(..$(a +(a), c +(c)))]

##++long
    ++  long                                                ::
      |*  a=(gear)
      =+  b=0
      |-  ^-  @
      =+  c=(a)
      ?~  c
        b
      $(b +(b), a t.c)

##++lone
    ++  lone  |*(a=* |?([i=a t=none]))                      ::

##++mill
    ++  mill
      |*  [a=_,* b=(gear)]
      |?
      =+  c=(b)
      ?~  c
        ~
      [i=(a i.c) t=^?(..$(b t.c))]

##++none
    ++  none  |?(~)                                         ::

##++over
    ++  over                                                ::
      |=  [a=@ b=@]
      ^-  (gear ,@)
      |?
      ?:  =(a b)
        [i=a t=none]
      [i=a t=^?(..$(a +(a)))]

##++pull
    ++  pull                                                ::
      |*  a=(gear)
      |=  b=_^+(|-(=+(b=(a) ?~(b ~ [i=i.b t=$(a t.b)]))) ~)
      ^+  b
      =+  c=(a)
      ?~  c
        b
      $(b [i.c b], a t.c)

##++push
    ++  push                                                ::
      |*  a=(gear)
      |=  b=_^+(|-(=+(b=(a) ?~(b ~ [i=i.b t=$(a t.b)]))) ~)
      ^+  b
      =+  c=((pull a) ~)
      ((pull (spin c)) b)

##++spin
    ++  spin                                                ::
      |*  a=(list)
      =>  .(a `_(homo a)`a)
      |?
      ?~  a
        ~
      [i=i.a t=^?(..$(a t.a))]
