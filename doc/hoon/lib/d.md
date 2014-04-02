---
layout: subpage
title: 2d Containers
axis: doc-hoon
categories: lib
sort: 4
---

  ::::::::::::::::::::::::::::::::::::::::::::::::::::::  ::
::::              chapter 2d, containers                ::::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2dA, sets                     ::
::
++  apt                                                 ::  set invariant
  |=  a=(tree)
  ?@  a
    &
  ?&  ?@(l.a & ?&((vor n.a n.l.a) (hor n.l.a n.a)))
      ?@(r.a & ?&((vor n.a n.r.a) (hor n.a n.r.a)))
  ==
::
++  in                                                  ::  set engine
  !:
  ~/  %in
  |/  a=(set)
  +-  all
    ~/  %all
    |*  b=$+(* ?)
    |-  ^-  ?
    ?@  a
      &
    ?&((b n.a) $(a l.a) $(a r.a))
  
  ::  Takes a gate b that takes any noun and produces a loobean. +-all produces
  ::  the logical and of all the values (n.a) in a. 
  ::  ~dovryp-toblug/try=> =b (sa `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
  ::  ~dovryp-toblug/try=> (~(all in b) |=(a=* ?@(-.a & |)))
  ::  %.n


  +-  any
    ~/  %any
    |*  b=$+(* ?)
    |-  ^-  ?
    ?@  a
      |
    ?|((b n.a) $(a l.a) $(a r.a))
  
  ::  Takes a gate b that takes any noun and produces a loobean. +-any produces
  ::  the logical or of all the values (q.n.a) in a. 
  ::  ~dovryp-toblug/try=> =b (sa `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
  ::  ~dovryp-toblug/try=> (~(any in b) |=(a=* ?@(+.a & |)))
  ::  %.y


  +-  del
    ~/  %del
    |*  b=*
    |-  ^+  a
    ?~  a
      ~
    ?.  =(b n.a)
      ?:  (hor b n.a)
        [n.a $(a l.a) r.a]
      [n.a l.a $(a r.a)]
    |-  ^-  ?(~ _a)
    ?~  l.a  r.a
    ?~  r.a  l.a
    ?:  (vor n.l.a n.r.a)
      [n.l.a l.l.a $(l.a r.l.a)]
    [n.r.a $(r.a l.r.a) r.r.a]

  ::  Takes a noun b and removes the member of the set where n.a is b.
  ::  ~dovryp-toblug/try=> =b (sa `(list ,@t)`['a' 'b' 'c' ~])
  ::  ~dovryp-toblug/try=> (~(del in b) 'a')
  ::  {'c' 'b'}


  +-  dig
    |=  b=*
    =+  c=1
    |-  ^-  (unit ,@)
    ?~  a  ~
    ?:  =(b n.a)  [~ u=(peg c 2)]
    ?:  (gor b n.a)
      $(a l.a, c (peg c 6))
    $(a r.a, c (peg c 7))

  ::  finds the ++gor (the order of ++mug hashes) of b and n.a
  ::  replaces a with l.a if true, r.a if not
  ::  replaces c with ++peg c 6 if true, ++peg c 7 if not
  ::  ??  so that's what it does, but what does it mean?


  +-  gas
    ~/  %gas
    |=  b=(list ,_?>(?=(^ a) n.a))
    |-  ^+  a
    ?@  b
      a
    $(b t.b, a (put(+< a) i.b))

  ::  Takes a list with some special form: ?=(^ a) is false, and the members 
  ::  of the list are of the same bunt as the members of the set. Produces the
  ::  set with the added members of b.
  ::  ~dovryp-toblug/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
  ::  ~dovryp-toblug/try=> (~(gas in a) `(list ,@t)`['d' 'e' 'f' 
  ::  {'e' 'd' 'f' 'a' 'c' 'b'}


  +-  has
    ~/  %has
    |*  b=*
    |-  ^-  ?
    ?@  a
      |
    ?:  =(b n.a)
      &
    ?:  (hor b n.a)
      $(a l.a)
    $(a r.a)

  ::  Takes any noun b and produces a loobean indicating whether that value 
  ::  (n.a) exists in a.
  ::  ~dovryp-toblug/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
  ::  ~dovryp-toblug/try=> (~(has in a) 'a')
  ::  %.y
  ::  ~dovryp-toblug/try=> (~(has in a) 'z')
  ::  %.n


  +-  put
    ~/  %put
    |*  b=*
    |-  ^+  a
    ?@  a
      [b ~ ~]
    ?:  =(b n.a)
      a
    ?:  (hor b n.a)
      =+  c=$(a l.a)
      ?>  ?=(^ c)
      ?:  (vor n.a n.c)
        [n.a c r.a]
      [n.c l.c [n.a r.c r.a]]
    =+  c=$(a r.a)
    ?>  ?=(^ c)
    ?:  (vor n.a n.c)
      [n.a l.a c]
    [n.c [n.a l.a l.c] r.c]

  ::  Takes any noun b and adds it to the set a on the head (n=b).
  ::  ~dovryp-toblug/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
  ::  ~dovryp-toblug/try=> (~(put in a) 'd')
  ::  {'d' 'a' 'c' 'b'}


  +-  rep
    |*  [b=* c=_,*]
    |-
    ?~  a  b
    $(a r.a, b $(a l.a, b (c n.a b)))

  ::  Takes a cell with any noun b and a tile c. Walks through the set 
  ::  replacing b with (c n.a b): applying c to n.a b.
  ::  ??  But, what is it for? Can't find calls to it.


  +-  tap
    ~/  %tap
    |=  b=(list ,_?>(?=(^ a) n.a))
    ^+  b
    ?@  a
      b
    $(a r.a, b [n.a $(a l.a)])

  ::  Takes a list tile. Produces the set a converted to a list.


  +-  wyt
    .+
    |-  ^-  @
    ?~(a 0 +((add $(a l.a) $(a r.a))))
  --

  ::  Counts the depth of a.
  ::  ??  


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2dB, maps                     ::
::
++  ept                                                 ::  map invariant
  |=  a=(tree ,[p=* q=*])
  ?@  a
    &
  ?&  ?@(l.a & ?&((vor p.n.a p.n.l.a) (hor p.n.l.a p.n.a)))
      ?@(r.a & ?&((vor p.n.a p.n.r.a) (hor p.n.a p.n.r.a)))
  ==

::  Takes a tree of nouns, produces a loobean. 
::  ??  Not sure about this one.


++  by                                                  ::  map engine
  ~/  %by
  |/  a=(map)

  ::  ++by takes a map a, which is accessible to all of its +- arms

  +-  all
    ~/  %all
    |*  b=$+(* ?)
    |-  ^-  ?
    ?@  a
      &
    ?&((b q.n.a) $(a l.a) $(a r.a))
  
  ::  Takes a gate b that takes any noun and produces a loobean. +-all produces
  ::  the logical and of all the values (q.n.a) in a. 
  ::  ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
  ::  ~talsur-todres/try=> (~(all by b) |=(a=* ?@(a & |)))
  ::  %.n


  +-  any
    ~/  %any
    |*  b=$+(* ?)
    |-  ^-  ?
    ?@  a
      |
    ?|((b q.n.a) $(a l.a) $(a r.a))

  ::  Takes a gate b that takes any noun and produces a loobean. +-any produces
  ::  the logical or of all the values (q.n.a) in a. 
  ::  ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
  ::  ~talsur-todres/try=> (~(all by b) |=(a=* ?@(a & |)))
  ::  %.y
  

  +-  del
    ~/  %del
    |*  b=*
    |-  ^+  a
    ?~  a
      ~
    ?.  =(b p.n.a)
      ?:  (gor b p.n.a)
        [n.a $(a l.a) r.a]
      [n.a l.a $(a r.a)]
    |-  ^-  ?(~ _a)
    ?~  l.a  r.a
    ?~  r.a  l.a
    ?:  (vor p.n.l.a p.n.r.a)
      [n.l.a l.l.a $(l.a r.l.a)]
    [n.r.a $(r.a l.r.a) r.r.a]

  ::  Takes a noun b and removes the member of the map a where p.a is b.
  ::  ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
  ::  ~talsur-todres/try=> (~(del by b) 'a')
  ::  {[p='b' q=[2 3]]}


  +-  dig
    |=  b=*
    =+  c=1
    |-  ^-  (unit ,@)
    ?~  a  ~
    ?:  =(b p.n.a)  [~ u=(peg c 2)]
    ?:  (gor b p.n.a)
      $(a l.a, c (peg c 6))
    $(a r.a, c (peg c 7))
  
  ::  Takes any noun b and produces the axis of b within the values (p.a) of a.
  ::  ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
  ::  ~talsur-todres/try=> (~(dig by b) 'b')
  ::  [~ 2]
  ::  ??  need to confirm this is true
  

  +-  gas
    ~/  %gas
    |*  b=(list ,[p=* q=*])
    =>  .(b `(list ,_?>(?=(^ a) n.a))`b)
    |-  ^+  a
    ?@  b
      a
    $(b t.b, a (put(+< a) p.i.b q.i.b))
  
  ::  ??  Not sure about this. Returning later.


  +-  get
    ~/  %get
    |*  b=*
    |-  ^-  ?(~ [~ u=_?>(?=(^ a) q.n.a)])
    ?@  a
      ~
    ?:  =(b p.n.a)
      [~ u=q.n.a]
    ?:  (gor b p.n.a)
      $(a l.a)
    $(a r.a)
  
  ::  Takes any noun b and produces the value (q.a) at key (p.a) b or null if 
  ::  the key doesn't exist.
  ::  ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
  ::  ~talsur-todres/try=> (~(get by b) 'b')
  ::  [~ [2 3]]


  +-  has
    ~/  %has
    |*  b=*
    !=(~ (get(+< a) b))
  
  ::  Takes any noun b and produces a loobean indicating whether that key (p.a) 
  ::  exists in a.
  ::  ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
  ::  ~talsur-todres/try=> (~(has by b) 'b')
  ::  %.y
  ::  ~talsur-todres/try=> (~(has by b) 'c')
  ::  %.n

  +-  mar
    |*  [b=_?>(?=(^ a) p.n.a) c=(unit ,_?>(?=(^ a) q.n.a))]
    ?~  c
      (del b)
    (put b u.c)

  ::  deletes the key at b or puts the value of the unit c in at b
  ::  ??  Not so sure about this.


  +-  put
    ~/  %put
    |*  [b=* c=*]
    |-  ^+  a
    ?@  a
      [[b c] ~ ~]
    ?:  =(b p.n.a)
      ?:  =(c q.n.a)
        a
      [[b c] l.a r.a]
    ?:  (gor b p.n.a)
      =+  d=$(a l.a)
      ?>  ?=(^ d)
      ?:  (vor p.n.a p.n.d)
        [n.a d r.a]
      [n.d l.d [n.a r.d r.a]]
    =+  d=$(a r.a)
    ?>  ?=(^ d)
    ?:  (vor p.n.a p.n.d)
      [n.a l.a d]
    [n.d [n.a l.a l.d] r.d]
  
  ::  Takes a cell of two nouns [b=* c=*] and produces the map a with added 
  ::  [b=* c=*]
  ::  ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
  ::  ~talsur-todres/try=> (~(put by b) 'c' 1)
  ::  {[p='a' q=1] [p='c' q=1] [p='b' q=[2 3]]}


  +-  rep
    |*  [b=* c=_,*]
    |-
    ?~  a  b
    $(a r.a, b $(a l.a, b (c n.a b)))

  ::  walk through the list calling c with a and b
  ::  could be used to add all the values in a list
  ::  if a is null return b
  ::  else recurse with a set to r.a, b set to (c n.a b)
  ::  ??  returns with (c n.a b) from the last leftmost part of the tree?


  +-  rib
    |*  [b=* c=_,*]
    |-  ^+  [b a]
    ?~  a  [b ~]
    =+  d=(c n.a b)
    =.  n.a  +.d
    =+  e=$(a l.a, b -.d)
    =+  f=$(a r.a, b -.e)
    [-.f [n.a +.e +.f]]

  ::  Produces the accumulated value of c from walking through the tree
  ::  and a new tree
  ::  ??  not sure about this one.


  +-  run
    |*  b=_,*
    |-
    ?~  a  a
    [[p.n.a (b q.n.a)] $(a l.a) $(a r.a)]
  
  ::  Takes a gate b that produces any noun, produces a null-terminated tuple
  ::  by running each element in map a through b. 
  ::  ~talsur-todres/try=>  =b (mo `(list ,[@t *])`[['a' 97] ['b' 98] ~])  
  ::  ~talsur-todres/try=> (~(run by b) ,@t)
  ::  [['b' 'b'] [['a' 'a'] ~ ~] ~]

  +-  tap
    ~/  %tap
    |=  b=(list ,_?>(?=(^ a) n.a))
    ^+  b
    ?@  a
      b
    $(a r.a, b [n.a $(a l.a)])

  ::  b is a list that has similar values to those that are in a
  ::  ??  not sure.


  +-  wyt
    .+
    |-  ^-  @
    ?~(a 0 +((add $(a l.a) $(a r.a))))
  --

  ::  Counts the depth of a.
  ::  ??  This is a bit confusing — it increments on each recursion, but 
  ::  produces 0 when it hits the end?
  ::  -- produces a number or zero

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2dC, queues                   ::
::
++  to                                                  ::  queue engine
  |/  a=(qeu)
  +-  bal
    |-  ^+  a
    ?~  a  ~
    ?.  |(?=(~ l.a) (vor n.a n.l.a))
      $(a [n.l.a l.l.a $(a [n.a r.l.a r.a])])
    ?.  |(?=(~ r.a) (vor n.a n.r.a))
      $(a [n.r.a $(a [n.a l.a l.r.a]) r.r.a])
    a

  ::  Walk through the queue and use vor to order individual parts
  ::  ??  Come back.


  +-  dep
    |-  ^-  @
    ?~  a  0
    +((max $(a l.a) $(a r.a)))
  
  ::  Produce the depth of the queue by following l.a and r.a.


  +-  gas
    |=  b=(list ,_?>(?=(^ a) n.a))
    |-  ^+  a
    ?~(b a $(b t.b, a (put(+< a) i.b)))

  ::  Take the icon of a list b and produce a gate that creates a ++qeu from a
  ::  list.


  +-  get
    |-  ^+  [p=?>(?=(^ a) n.a) q=a]
    ?~  a
      !!
    ?~  r.a
      [n.a l.a]
    =+  b=$(a r.a)
    :-  p.b
    ?:  |(?=(~ q.b) (vor n.a n.q.b))
      [n.a l.a q.b]
    [n.q.b [n.a l.a l.q.b] r.q.b]

  ::  Produce the qeu in [p=* q=*] format.


  +-  nap
    ?>  ?=(^ a)
    ?:  =(~ l.a)  r.a
    =+  b=get(+< l.a)
    bal(+< ^+(a [p.b q.b r.a]))

  ::  ??  Not sure. Returning.


  +-  put
    |*  b=*
    |-  ^+  a
    ?~  a
      [b ~ ~]
    bal(+< a(l $(a l.a)))
  
  ::  Takes any noun b and adds it to top of the qeu.
  ::  =a (~(gas to `(qeu ,@)`~) `(list ,@)`[3 1 2 4 5 6 ~])
  ::  ~dovryp-toblug/try=> (~(put to a) 7)
  ::  {7 6 5 4 2 1 3}


  +-  tap
    |=  b=(list ,_?>(?=(^ a) n.a))
    ^+  b
    ?~  a
      b
    $(a r.a, b [n.a $(a l.a)])
  
  ::  Takes a list b whose icon corresponds to the icon of n.a. Produces a 
  ::  ++qeu with the members of b added to the bottom.
  ::  ~dovryp-toblug/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[3 1 2 4 5 6 ~])
  ::  ~dovryp-toblug/try=> (~(tap to a) `(list ,@)`[99 100 101 ~])
  ::  ~[3 1 2 4 5 6 99 100 101]


  +-  top
    |-  ^-  (unit ,_?>(?=(^ a) n.a))
    ?~  a  ~
    ?~(r.a [~ n.a] $(a r.a))
  
  ::  Produces the rightmost item in the tree of ++qeu a.


  --
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2dD, casual containers        ::
::
++  mo                                                  ::  make a map
  |*  a=(list)
  =>  .(a `_(homo a)`a)
  =>  .(a `(list ,[p=_-<.a q=_->.a])`a)
  =+  b=*(map ,_?>(?=(^ a) p.i.a) ,_?>(?=(^ a) q.i.a))
  (~(gas by b) a)
::
++  sa                                                  ::  make a set
  |*  a=(list)
  =>  .(a `_(homo a)`a)
  =+  b=*(set ,_?>(?=(^ a) i.a))
  (~(gas in b) a)
 
>>>>>>> 4ef2770269ac90a6bca1bc784b3a66e5bc62dc44
