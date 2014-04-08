---
layout: subpage
title: 2d Containers
axis: doc-hoon
categories: lib
sort: 4
---

This section covers the containers sets maps and trees.

#Sets

##++apt
    ++  apt                                                 ::  set invariant
      |=  a=(tree)
      ?@  a
        &
      ?&  ?@(l.a & ?&((vor n.a n.l.a) (hor n.l.a n.a)))
          ?@(r.a & ?&((vor n.a n.r.a) (hor n.a n.r.a)))
      ==
?? don't really understand apt.

##++in

####Sets container.
`++in` is the container arm for all the set arms. The contained arms inherit its sample, the set `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
    ~talsur-todres/try=> ~(wyt in a)
    4
  Note: `++in` is not used alone, but is used to call the arms it contains.

###Summary
    ++  in                                                  ::  set engine
      !:
      ~/  %in
      |/  a=(set)
?? zapcol?  
`++in` is a [jetted arm (~/)]().  
`++in` creates a [vulcanized %gold tray]() that takes a `++set` `a`.  

##+-all  ++in

####Logical AND
`+-all` takes a gate `b` that accepts any noun and produces a loobean representing the logical AND of all the values (`n.a`) in `a`.

###Examples
    ~dovryp-toblug/try=> =b (sa `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
    ~dovryp-toblug/try=> (~(all in b) |=(a=* ?@(-.a & |)))
    %.n

###Summary
    +-  all
      ~/  %all
      |*  b=$+(* ?)
      |-  ^-  ?
      ?@  a
        &
      ?&((b n.a) $(a l.a) $(a r.a))


##+-any  ++in

####Logical and
`+-any` takes a gate `b` that accepts any noun and produces a loobean of the logical OR of all the values (`n.a`) in `a`.

###Examples
    ~dovryp-toblug/try=> =b (sa `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
    ~dovryp-toblug/try=> (~(any in b) |=(a=* ?@(+.a & |)))
    %.y

###Summary
    +-  any
      ~/  %any
      |*  b=$+(* ?)
      |-  ^-  ?
      ?@  a
        |
      ?|((b n.a) $(a l.a) $(a r.a))


##+-del  ++in

####Delete at `b`
`+-del` takes any noun b and removes the member of the set `a` where `n.a` is `b`.

###Examples
    ~dovryp-toblug/try=> =b (sa `(list ,@t)`['a' 'b' 'c' ~])
    ~dovryp-toblug/try=> (~(del in b) 'a')
    {'c' 'b'}

###Summary
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


##+-dig  ++in

####Get axis.
`+-dig` takes any noun `b` and produces the axis of `b` within the `++set` `a`.
      
###Examples
    ~talsur-todres/try=> =a (sa `(list ,@)`[1 2 3 4 5 6 7 ~])
    ~talsur-todres/try=> a
    {5 4 7 6 1 3 2}
    ~talsur-todres/try=> -.a
    n=6
    ~talsur-todres/try=> (~(dig in a) 7)
    [~ 12]
    ~talsur-todres/try=> (~(dig in a) 2)
    [~ 14]
    ~talsur-todres/try=> (~(dig in a) 6)
    [~ 2]

###Summary
    +-  dig
      |=  b=*
      =+  c=1
      |-  ^-  (unit ,@)
      ?~  a  ~
      ?:  =(b n.a)  [~ u=(peg c 2)]
      ?:  (gor b n.a)
        $(a l.a, c (peg c 6))
      $(a r.a, c (peg c 7))


##+-gas  ++in

####Concatinate
`+-gas` takes a list `b` with members of the same type as `a` and produces `b` concatenated with `a`.

###Examples
    ~dovryp-toblug/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
    ~dovryp-toblug/try=> (~(gas in a) `(list ,@t)`['d' 'e' 'f' ~])
    {'e' 'd' 'f' 'a' 'c' 'b'}

###Summary
    +-  gas
      ~/  %gas
      |=  b=(list ,_?>(?=(^ a) n.a))
      |-  ^+  a
      ?@  b
        a
      $(b t.b, a (put(+< a) i.b))


##+-has  ++in

####Existence check
`+-has` accepts any noun `b` and produces a loobean indicating whether that value (`n.a`) exists in `a`.

###Examples
    ~dovryp-toblug/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
    ~dovryp-toblug/try=> (~(has in a) 'a')
    %.y
    ~dovryp-toblug/try=> (~(has in a) 'z')
    %.n

###Summary
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


##+-put  ++in

####Insert
`+-put` accepts any noun `b` and produces `a` with `b` added to the sorted loaction in `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
    ~talsur-todres/try=> =b (~(put in a) 'd')
    ~talsur-todres/try=> b
    {'d' 'a' 'c' 'b'}
    ~talsur-todres/try=> -.l.+.b
    n='d'


###Summary
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


##+-rep  ++in

####??
`+-rep` accepts a cell with any noun `b` and a tile `c`. `+-rep` produces `a` with each `n.a` replaced with `(c n.a b)`.

###Examples
  ??  But, what is it for? Can't find calls to it.

###Summary
    +-  rep
      |*  [b=* c=_,*]
      |-
      ?~  a  b
      $(a r.a, b $(a l.a, b (c n.a b)))


##+-tap  ++in

####??
`+-tap` accepts list tile with members of the same type as `a`. `+-tap` produces the set `a` converted to a list using `b`.

###Examples
  ?? 
  ~talsur-todres/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
  ~talsur-todres/try=> (~(tap in a) (list ,*))
  ! type-fail
  ! exit
  ~talsur-todres/try=> (~(tap in a) (list ,@t))
  ! type-fail
  ! exit

###Summary
    +-  tap
      ~/  %tap
      |=  b=(list ,_?>(?=(^ a) n.a))
      ^+  b
      ?@  a
        b
      $(a r.a, b [n.a $(a l.a)])


##+-wyt  ++in

####Depth.
`+-wyt` produces the depth of set `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`['a' 'b' 'c' ~])
    ~talsur-todres/try=> ~(wyt in a)
    4

###Summary
  +-  wyt
    .+
    |-  ^-  @
    ?~(a 0 +((add $(a l.a) $(a r.a))))
  --


#Maps

##++ept
    ++  ept                                                 ::  map invariant
      |=  a=(tree ,[p=* q=*])
      ?@  a
        &
      ?&  ?@(l.a & ?&((vor p.n.a p.n.l.a) (hor p.n.l.a p.n.a)))
          ?@(r.a & ?&((vor p.n.a p.n.r.a) (hor p.n.a p.n.r.a)))
      ==

??  Not sure about this one.


##++by

###Maps container.
`++by` is the container for all the map arms. The contained arms inherit its sample, the map `a`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
    ~talsur-todres/try=> (~(all by b) |=(a=* ?@(a & |)))
    %.n
  Note: `++by` is not used alone, but is used to call the arms it contains.

###Summary
    ++  by                                                  ::  map engine
      ~/  %by
      |/  a=(map)


##+-all  ++by

####Logical AND
`+-all` takes a gate `b` that accepts any noun and produces a loobean representing the logical AND of all the values (`n.a`) in `a`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
    ~talsur-todres/try=> (~(all by b) |=(a=* ?@(a & |)))
    %.n

###Summary
    +-  all
      ~/  %all
      |*  b=$+(* ?)
      |-  ^-  ?
      ?@  a
        &
      ?&((b q.n.a) $(a l.a) $(a r.a))


##+-any  ++by

####Logical OR
`+-any` takes a gate `b` that accepts any noun and produces a loobean of the logical OR of all the values (`n.a`) in `a`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
    ~talsur-todres/try=> (~(all by b) |=(a=* ?@(a & |)))
    %.y

###Summary
    +-  any
      ~/  %any
      |*  b=$+(* ?)
      |-  ^-  ?
      ?@  a
        |
      ?|((b q.n.a) $(a l.a) $(a r.a))
  

##+-del  ++by

####Delete at `b`
`+-del` takes any noun b and removes the member of the set `a` where `n.a` is `b`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(del by b) 'a')
    {[p='b' q=[2 3]]}

###Summary
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


##+-dig  ++by

####Get axis
`+-dig` takes any noun `b` and produces the axis of `b` within the values (`p.a`) of map `a`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(dig by b) 'b')
    [~ 2]

###Summary
    +-  dig
      |=  b=*
      =+  c=1
      |-  ^-  (unit ,@)
      ?~  a  ~
      ?:  =(b p.n.a)  [~ u=(peg c 2)]
      ?:  (gor b p.n.a)
        $(a l.a, c (peg c 6))
      $(a r.a, c (peg c 7))


##+-gas ++by

####Concat list.
`+-gas` takes a list `b` of cells of any noun and produces a new map with the members of `b` added to `a`.

###Examples
    ~talsur-todres/try=> =a (mo `(list ,[@t *])`[['a' 1] ['b' 2] ~])
    ~talsur-todres/try=> =b `(list ,[@t *])`[['c' 3] ['d' 4] ~]
    ~talsur-todres/try=> (~(gas by a) b)
    {[p='d' q=4] [p='a' q=1] [p='c' q=3] [p='b' q=2]}

###Summary
    +-  gas
      ~/  %gas
      |*  b=(list ,[p=* q=*])
      =>  .(b `(list ,_?>(?=(^ a) n.a))`b)
      |-  ^+  a
      ?@  b
        a
      $(b t.b, a (put(+< a) p.i.b q.i.b))


##+-get ++by

####Grab.
`+-get` takes any noun `b` and produces the value (`q.a`) at key (`p.a`) `b` or ~ if the key doesn't exist.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(get by b) 'b')
    [~ [2 3]]

###Summary
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


##+-has  ++by

####Existence check.
`+-has` takes any noun `b` and produces a loobean whether that key (`p.a`) exists in `a`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(has by b) 'b')
    %.y
    ~talsur-todres/try=> (~(has by b) 'c')
    %.n

###Summary
    +-  has
      ~/  %has
      |*  b=*
      !=(~ (get(+< a) b))
  

##+-mar  ++by

####??

###Examples

###Summary
    +-  mar
      |*  [b=_?>(?=(^ a) p.n.a) c=(unit ,_?>(?=(^ a) q.n.a))]
      ?~  c
        (del b)
      (put b u.c)


##+-put  ++by

####
`+-put` takes a cell of two nouns `[b=* c=*]` and produces the map `a` with added `[b=* c=*]`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(put by b) 'c' 1)
    {[p='a' q=1] [p='c' q=1] [p='b' q=[2 3]]}

###Summary
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


##+-rep  ++by

####Reduce
`+-rep` walks through the map `a` replacing `b` with the product of calling `c` with `n.a` and `b`.

###Examples

###Summary
    +-  rep
      |*  [b=* c=_,*]
      |-
      ?~  a  b
      $(a r.a, b $(a l.a, b (c n.a b)))


##+-rib  ++by

####Map??
`+-rib` takes any noun `b` and a gate `c`. `+-rib` walks through the map `a` replacing the values `n.a` with `(c n.a b)` and produces a transformed `a` and the accumulated `b`.

###Examples

###Summary
    +-  rib
      |*  [b=* c=_,*]
      |-  ^+  [b a]
      ?~  a  [b ~]
      =+  d=(c n.a b)
      =.  n.a  +.d
      =+  e=$(a l.a, b -.d)
      =+  f=$(a r.a, b -.e)
      [-.f [n.a +.e +.f]]


##+-run  ++by

####Map / Each
`+-run` takes a gate `b`. `+-run` walks through the map `a` and produces a null-terminated tuple with `[p.n.a (b q.n.a)]`.

###Examples
    ~talsur-todres/try=>  =b (mo `(list ,[@t *])`[['a' 97] ['b' 98] ~])  
    ~talsur-todres/try=> (~(run by b) ,@t)
    [['b' 'b'] [['a' 'a'] ~ ~] ~]

###Summary
    +-  run
      |*  b=_,*
      |-
      ?~  a  a
      [[p.n.a (b q.n.a)] $(a l.a) $(a r.a)]
  

##+-tap  ++by

####??

###Examples

###Summary
    +-  tap
      ~/  %tap
      |=  b=(list ,_?>(?=(^ a) n.a))
      ^+  b
      ?@  a
        b
      $(a r.a, b [n.a $(a l.a)])


##+-wyt  ++by

####Depth
`+-wyt` produces the depth of `a`.

###Examples
    ~talsur-todres/try=>  =a (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
    ~talsur-todres/try=> ~(wyt by a)
    3
    ~talsur-todres/try=> =a (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ['c' [4 5]] ~])
    ~talsur-todres/try=> ~(wyt by a)
    4

###Summary
    +-  wyt
      .+
      |-  ^-  @
      ?~(a 0 +((add $(a l.a) $(a r.a))))
    --

#Queues

##++to

`++to` is the container arm for all the queue arms. The contained arms inherit its sample, the qeu `a`.

    ++  to                                                  ::  queue engine
      |/  a=(qeu)


##+-bal  ++to

####Vor??
`+-bal` walks through `a` using `++vor`

###Examples

###Summary
    +-  bal
      |-  ^+  a
      ?~  a  ~
      ?.  |(?=(~ l.a) (vor n.a n.l.a))
        $(a [n.l.a l.l.a $(a [n.a r.l.a r.a])])
      ?.  |(?=(~ r.a) (vor n.a n.r.a))
        $(a [n.r.a $(a [n.a l.a l.r.a]) r.r.a])
      a


##+-dep ++to

####Depth
`+-dep` produces the maximum depth of leaves (`l.a` and `r.a`) of queue `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 4 5 6 7 ~])
    ~talsur-todres/try=> ~(dep to a)
    4
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 4 ~])
    ~talsur-todres/try=> ~(dep to a)
    3
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 ~])
    ~talsur-todres/try=> ~(dep to a)
    2


###Summary
    +-  dep
      |-  ^-  @
      ?~  a  0
      +((max $(a l.a) $(a r.a)))


##+-gas  ++to

####??

###Examples

###Summary
    +-  gas
      |=  b=(list ,_?>(?=(^ a) n.a))
      |-  ^+  a
      ?~(b a $(b t.b, a (put(+< a) i.b)))


##+-get  ++to

####p-q ify
`+-get` produces the qeu `a` in the format [p=* q=*].

###Examples
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 4 ~])
    ~talsur-todres/try=> ~(get to a)
    [p=1 q={4 3 2}]

###Summary
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


##+-nap  ++to

####Unshift
`+-nap` removes the head from the qeu `a` and produces a new qeu.

###Examples
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 4 5 6 ~])
    ~talsur-todres/try=> -.a
    n=6
    ~talsur-todres/try=> =b ~(nap to a)
    ~talsur-todres/try=> -.b
    n=2
    ~talsur-todres/try=> b
    {5 4 3 2 1}
    ~talsur-todres/try=> a
    {6 5 4 3 2 1}

###Summary
    +-  nap
      ?>  ?=(^ a)
      ?:  =(~ l.a)  r.a
      =+  b=get(+< l.a)
      bal(+< ^+(a [p.b q.b r.a]))


##+-put  ++to

####Shift
`+-put` accepts any noun, `b` and produces the qeu `a` with `b` added to the head.

###Examples
    =a (~(gas to `(qeu ,@)`~) `(list ,@)`[3 1 2 4 5 6 ~])
    ~dovryp-toblug/try=> (~(put to a) 7)
    {7 6 5 4 2 1 3}

###Summary
    +-  put
      |*  b=*
      |-  ^+  a
      ?~  a
        [b ~ ~]
      bal(+< a(l $(a l.a)))


##+-tap  ++to

####Push
`+-tap` takes a list whose icon corresponds to the icon of `n.a`. `+-tap` produces a qeu with the members of `b` added to the end.

###Examples
    ~dovryp-toblug/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[3 1 2 4 5 6 ~])
    ~dovryp-toblug/try=> (~(tap to a) `(list ,@)`[99 100 101 ~])
    ~[3 1 2 4 5 6 99 100 101]

###Summary
    +-  tap
      |=  b=(list ,_?>(?=(^ a) n.a))
      ^+  b
      ?~  a
        b
      $(a r.a, b [n.a $(a l.a)])
  

##+-top  ++to

####First
`+-top` produces the rightmost item in the tree of qeu `a`.

###Examples 
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 4 5 6 ~])
    ~talsur-todres/try=> ~(top to a)
    [~ 1]

###Summary
    +-  top
      |-  ^-  (unit ,_?>(?=(^ a) n.a))
      ?~  a  ~
      ?~(r.a [~ n.a] $(a r.a))
  

#Casual containers

##++mo

####Mapify
`++mo` takes a `++list` of cells `a` and produces a `map` with the members of `a`.

###Examples
    ~talsur-todres/try=> (mo `(list ,[@t *])`[['a' 1] ['b' 2] ~])
    {[p='a' q=1] [p='b' q=2]}

###Summary
    ++  mo                                                  ::  make a map
      |*  a=(list)
      =>  .(a `_(homo a)`a)
      =>  .(a `(list ,[p=_-<.a q=_->.a])`a)
      =+  b=*(map ,_?>(?=(^ a) p.i.a) ,_?>(?=(^ a) q.i.a))
      (~(gas by b) a)


##++sa
####Setify
`++sa` takes a list `a` and produces a set with the members of `a`.

###Examples
    ~talsur-todres/try=> (sa `(list ,@)`[1 2 3 4 5 ~])
    {5 4 1 3 2}
    ~talsur-todres/try=> (sa `(list ,[@t *])`[['a' 1] ['b' 2] ~])
    {['a' 1] ['b' 2]}

###Summary
    ++  sa                                                  ::  make a set
      |*  a=(list)
      =>  .(a `_(homo a)`a)
      =+  b=*(set ,_?>(?=(^ a) i.a))
      (~(gas in b) a)