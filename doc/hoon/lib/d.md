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
Debugging traces are enabled with [!:]().  
`++in` is a [jetted arm (~/)]().  
`++in` creates a [vulcanized %gold tray]() that takes a set `a`.
The wet (+-) arms below inherit the sample `a`.

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
`+-all` is a [jetted arm (~/)]().  
`+-all` creates a [wet vulcanized gate |*]() which accepts a [gate]() `b`. `b` ([$+]()) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to a loobean.  
If `a` is an atom ([?@]()), produce yes.
Otherwise produce the logical AND ([?&]()) of `(b n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.


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
`+-any` is a [jetted arm (~/)]().  
`+-any` creates a [wet vulcanized gate |*]() which accepts a [gate]() `b`. `b` ([$+]()) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to a loobean.  
Otherwise produce the logical OR ([?|]()) of `(b n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.


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
`+-del` is a [jetted arm (~/)]().  
`+-del` creates a [wet vulcanized gate |*]() which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to a set (the type of `a`).  
If `a` is null ([?~]()), produce null.  
If `b` is `n.a` ([=, irregular form of ^=]()) test the `++hor` of `b` and `n.a` with [?:]().  
If the `++hor` is `%.y`, produce a tuple recursing with `a` set to `l.a`. If the `++hor` is `%.n` produce a tuple recursing with `a` set to `r.a` (`$(a r.a)`).  
If `b` is not `n.a` A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to either null or the [bunt]() of `a`, `?(~ _a)`.  
If `l.a` is null, produce `r.a`.  
If `r.a` is null, produce `l.a`.  
If the `++vor` of `n.l.a` and `n.r.a` is `%.y` produce a tuple replacing `l.a` with `r.l.a` in the final value.  
Otherwise produce a tuple replacing `r.a` with `l.r.a` in the middle value.  


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
`+-dig` creates a [dry %gold gate |=]() that takes any noun `b`.  
`c` is pushed on to the subject with `=+` and set to `1`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast to a `++unit` atom.  
If `a` is null, produce null ([?~]()).  
If `b` is `n.a` ([?:]()) produce a `++unit` with `u=(peg c 2)`. See also: [++peg]().  
If the `++gor` of `b` and `n.a` is `%.y`, recurse with `a` set to `l.a` and `c` set to `(peg c 6)`. See also: [++peg]().  
Otherwise recurse with `a` set to `r.a` and `c` set to `(peg c 7)`. See also: [++peg]().  


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
`+-gas` is a [jetted arm (~/)]().
`+-gas` creates a [dry %gold gate |=]() that takes a `++list` whose members match the bunt of `n.a`s in `a`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast to the type of `a` (a set).  
If `b` is an atom ([?@]()), produce `a`.  
Otherwise, recurse with `b` set to `t.b` and `a` set to `(put(+< a) i.b)`. See also: [+-put](), below.


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
`+-has` is a [jetted arm (~/)]().  
`+-has` creates a [wet vulcanized gate |*]() which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to a loobean.  
If `a` is an atom ([?@]()), produce `%.n`.
If `b` is `n.a` produce %.y.
Otherwise, if the `++hor` of `b` and `n.a` is `%.y`, recurse with `a` set to `l.a` or `a` set to `r.a` if `%.n`.  


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
`+-put` is a [jetted arm (~/)]().  
`+-put` creates a [wet vulcanized gate |*]() which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^+]()) to type of `a` (a set).  
If `a` is an atom ([?@]()) produce `[b ~ ~]`.
If `b` is `n.a` produce `a`.
If the `++hor` of `b` and `n.a` is `%.y` ([?:]()),  
`c` is pushed on to the subject with `=+` and set to the containing gate called with `a` set to `l.a`.  
[?>]() asserts that `c` is not `^`.  
If the `++vor` of `n.a` and `n.c` is `%.y`, produce `[n.a c r.a]`.  
Otherwise produce `[n.c l.c [n.a r.c r.a]]`.  
If the `++hor` of `b` and `n.a` is `%.n` ([?:]()),  
`c` is pushed on to the subject with `=+` and set to the gate called with `a` set to `r.a`.  
[?>]() asserts that `c` is not `^`.  
If the `++vor` of `n.a` and `n.c` is `%.y`, produce `[n.a l.a c]`.  
Otherwise produce `[n.c [n.a l.a l.c] r.c]`.


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
`+-put` creates a [wet vulcanized gate |*]() which accepts any noun, `b` and the bunt of the tile of any noun, `c`.
A dry `%gold` gate is created and kicked with [|-]().
If `a` is null ([?~]()), produce `b`.
Recurse, with `a` set to `r.a` and `b` set to the product of the gate with `a` set to `l.a` and `b` set to `(c n.a b)`.


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
[.+]() increments the subject.
A dry `%gold` gate is created and kicked with [|-]() and the product is cast ([^-]()) to an atom.
If `a` is null ([?~]()), produce `0`.
Otherwise, `++add` the products of the gate called with `a` replaced with `l.a` and `a` replaced with `r.a`.


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
`++by` is a [jetted arm (~/)]().  
`++by` creates a [vulcanized %gold tray]() that takes a map `a`.  


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
`+-all` is a [jetted arm (~/)]().  
`+-all` creates a [wet vulcanized gate |*]() which accepts a [gate]() `b`. `b` ([$+]()) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to a loobean.  
If `a` is an atom ([?@]()), produce yes.
Otherwise produce the logical AND ([?&]()) of `(b q.n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.



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
`+-any` is a [jetted arm (~/)]().  
`+-any` creates a [wet vulcanized gate |*]() which accepts a [gate]() `b`. `b` ([$+]()) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to a loobean.  
Otherwise produce the logical OR ([?|]()) of `(b q.n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.

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
`+-del` is a [jetted arm (~/)]().  
`+-del` creates a [wet vulcanized gate |*]() which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to a map (the type of `a`).  
If `a` is null ([?~]()), produce null.  
If `b` is `p.n.a` ([=, irregular form of ^=]()) test the `++gor` of `b` and `p.n.a` with [?:]().  
If the `++gor` is `%.y`, produce a tuple recursing with `a` set to `l.a` in the middle value. If the `++hor` is `%.n` produce a tuple recursing with `a` set to `r.a` (`$(a r.a)`) in the last value.  
If `b` is not `p.n.a` A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^-]()) to either null or the [bunt]() of `a`, `?(~ _a)`.  
If `l.a` is null, produce `r.a`.  
If `r.a` is null, produce `l.a`.  
If the `++vor` of `p.n.l.a` and `p.n.r.a` is `%.y` produce a tuple replacing `l.a` with `r.l.a` in the final value.  
Otherwise produce a tuple replacing `r.a` with `l.r.a` in the middle value.  


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
`+-dig` creates a [dry %gold gate |=]() that takes any noun `b`.  
`c` is pushed on to the subject with `=+` and set to `1`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast to a `++unit` atom.  
If `a` is null, produce null ([?~]()).  
If `b` is `p.n.a` ([?:]()) produce a `++unit` with `u=(peg c 2)`. See also: [++peg]().  
If the `++gor` of `b` and `p.n.a` is `%.y`, recurse with `a` set to `l.a` and `c` set to `(peg c 6)`. See also: [++peg]().  
Otherwise recurse with `a` set to `r.a` and `c` set to `(peg c 7)`. See also: [++peg]().  


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
`+-gas` is a [jetted arm (~/)]().  
`+-gas` creates a [wet vulcanized gate |*]() that takes a `++list` of cells of any noun `[p=* q=*]`.  
`b` is cast (using `) to a list of the same type as the members of `a` and used as the subject for the remainder using [=>]().
A dry `%gold` gate is created and kicked with [|-]() and the result is cast to the type of `a` (a set).  
If `b` is an atom ([?@]()), produce `a`.  
Otherwise, recurse with `b` set to `t.b` and `a` set to `(put(+< a) i.b)`. See also: [+-put](), below.


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
`+-get` is a [jetted arm (~/)]().  
`+-get` creates a [wet vulcanized gate |*]() that takes accepts any noun `b`.  

A dry `%gold` gate is created and kicked with [|-]() and the result is cast to null or a `++unit` where the `u` is of the same type as `q.n.a`.
If `a` is an atom, produce null ([?@]()).
If `b` is `p.n.a` produce `[~ u=p.n.a]`.
If the `++gor` of `b` and `p.n.a` is `%.y` recurse with `a` set to `l.a`.
Otherwise, recurse with `a` set to `r.a`.


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
`+-has` is a [jetted arm (~/)]().  
`+-has` creates a [wet vulcanized gate |*]() that takes accepts any noun `b`.  
`+-has` produces the result of `+-get` `b` as a twig using [!=]().
  

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

####Insert
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
`+-put` is a [jetted arm (~/)]().  
`+-put` creates a [wet vulcanized gate |*]() which accepts a cell of any two nouns, `[b=* c=*]`.
A dry `%gold` gate is created and kicked with [|-]() and the result is cast ([^+]()) to type of `a` (a map).  
If `a` is an atom ([?@]()) produce `[[b c] ~ ~]`.
If `b` is `p.n.a` and `c` is `q.n.a`, produce `a`.
If `b` is `p.n.a` and `c` is not `q.n.a`, produce `[[b c] l.a r.a]`.
If the `++gor` of `b` and `p.n.a` is `%.y` ([?:]()),  
`d` is pushed on to the subject with `=+` and set to the containing gate called with `a` set to `l.a`.  
[?>]() asserts that `d` is not `^`.  
If the `++vor` of `p.n.a` and `p.n.d` is `%.y`, produce `[n.a d r.a]`.  
Otherwise produce `[n.d l.d [n.a r.d r.a]]`.  
If the `++hor` of `b` and `n.a` is `%.n` ([?:]()),  
`d` is pushed on to the subject with `=+` and set to the gate called with `a` set to `r.a`.  
[?>]() asserts that `d` is not `^`.  
If the `++vor` of `p.n.a` and `p.n.d` is `%.y`, produce `[n.a l.a d]`.  
Otherwise produce `[n.d [n.a l.a l.d] r.d]`.

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
`+-rib` creates a [wet vulcanized gate |*]() which accepts a cell of any two nouns, `[b=* c=*]`.


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
`+-run` creates a [wet vulcanized gate |*]() which accepts any gate, `b`.  
A dry `%gold` gate is created and kicked with [|-]().  
If `a` is null, return `a` ([?~]()).
Otherwise, produce a tuple with `[p.n.a (b q.n.a)]`, the containing gate called with `a` replaced by `l.a` and the containing gate called with `a` replaced by `r.a`.
  

##+-tap  ++by

####??

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 97] ['b' 98] ~])
    ~talsur-todres/try=> =c `(list ,[@t @])`[['d' 4] ['e' 5] ~]
    ~talsur-todres/try=> (~(tap by b) c)
    ~[[p='b' q=98] [p='a' q=97] [p='d' q=4] [p='e' q=5]]

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
[.+]() increments our subject.
A dry `%gold` gate is created and kicked with [|-]() and the subject is cast ([^-]()) to an atom.
If `a` is null ([?~]()), produce `0`.
Otherwise, `++add` the products of the gate called with `a` replaced with `l.a` and `a` replaced with `r.a`.


#Queues

##++to


####Queues container.
`++to` is the container arm for all the queue arms. The contained arms inherit its sample, the qeu `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 4 5 6 7 ~])
    ~talsur-todres/try=> ~(dep to a)
    4
Note: `++to` is not used alone, but is used to call the arms it contains.

###Summary
    ++  to                                                  ::  queue engine
      |/  a=(qeu)
`++to` creates a [vulcanized %gold tray]() that takes a qeu `a`.
The wet (+-) arms below inherit the sample `a`.


##+-bal  ++to

####Vor??
`+-bal` walks through `a` using `++vor`

###Examples
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[6 1 3 6 1 3 4 6 ~])
    ~talsur-todres/try=> a
    {6 4 3 1 6 3 1 6}
    ~talsur-todres/try=> ~(bal to a)
    {6 4 3 1 6 3 1 6}

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
`+-dep` creates a dry `%gold` gate kicks it with [|-]() and the result is cast ([^-]()) to an atom.  
If `a` is null ([?~]()), produce 0.
Otherwise produce the `++max` of the containing gate called with `a` replaced with `l.a` and `a` replaced with `r.a`.
Increment that product using `+`, the irregular form of `.+`.


##+-gas  ++to

####Insert
`+-gas` accepts a `++list` `b` whose members share the same type as `a` and produces a new qeu with `b` added to `a`.

###Examples
    ~talsur-todres/try=> (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 ~])
    {3 2 1}
    ~talsur-todres/try=> =a (~(gas to `(qeu ,@)`~) `(list ,@)`[1 2 3 ~])
    ~talsur-todres/try=> =b `(list ,@)`[4 5 6 ~]
    ~talsur-todres/try=> (~(gas to a) b)
    {6 5 4 3 2 1}

###Summary
    +-  gas
      |=  b=(list ,_?>(?=(^ a) n.a))
      |-  ^+  a
      ?~(b a $(b t.b, a (put(+< a) i.b)))
`+-gas` creates a [dry %gold gate |=]() that takes any `++list` `b` whose members resemble the `n.a` in `a`.  
A dry `%gold` gate is created and kicked with [|-]() and the result is cast to the type of `a` (a qeu) using `^+`.  
If `b` is null, produce `a` ([?~]()).
Otherwise, call the containing gate replacing `b` with `t.b` and `a` with `(put(+< a) i.b)`.
See `+-put` below.


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
A dry `%gold` gate is created and kicked with [|-]() and the result is cast using [^+]()to a cell where `p` resembles `n.a` and `q` resmbles `a`.  
If `a` is null ([?~]()), produce a crash ([!!]()).  
If `r.a` is null ([?~]()), produce `[n.a l.a]`.  
`b` is pushed on to the subject using `=+` and set to the containing gate called with `a` replaced with `r.a`.  
[:-]() is used to produce our final result, p.b and:
If ([?:]()) `q.b` is null ([?=]()) or ([|, irregular form of ?|]()) the `++vor` of `n.a` and `n.q.b` is `%.y`.  
Otherwise, produce `[n.q.b [n.a l.a l.q.b] r.q.b]`.


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
`+-nap` asserts that `a` is ([?=]()) not ([?>]()) `^`.
If [?:]() `l.a` is null, produce `r.a`.
`b` is pushed on to the subject using [=+]() and set to `get(+< l.a)`
`bal(+< ^+(a [p.b q.b r.a]))`


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
`+-put`creates a [wet vulcanized gate |*]() which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-]() and the product is cast using [^+]() to the type of `a` (a qeu).  
If `a` is null, produce `[b ~ ~]`.
Otherwise, produce `bal(+< a(l $(a l.a)))`.


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
`+-tap` creates a [dry %gold gate |=]() that takes a `++list` whose tile corresponds to the icon of `n.a`.
The product is cast using [^+]() to the type of `b`.
If `a` is null, produce `b`.
Recurse, replacing `a` with `r.a` and `b` with the cell `n.a` and the containing gate called with `a` replaced with `l.a`.


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
`+-top` creates a dry `%gold` gate and kicks it with [|-]() and the product is cast using [^-]() to a unit whose `u` has the same icon as `n.a`.
If `a` is null ([?@]()), produce null. 
If `r.a` is null, produce `[~ n.a]`.
Otherwise recurse, replacing `a` with `r.a`.
  

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