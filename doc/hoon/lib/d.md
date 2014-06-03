---
layout: subpage
title: 2d Containers
title-short: Containers 2
axis: doc-hoon
arms: [++apt, ++in, 'all:in', 'any:in', 'del:in', 'dig:in', 'gas:in', 'has:in', 'put:in', 'rep:in', 'tap:in', 'wyt:in', ++by, 'all:by', 'any:by', 'del:by', 'dig:by', 'gas:by', 'get:by', 'has:by', 'mar:by', 'put:by', 'rep:by', 'rib:by', 'run:by', 'tap:by', 'wyt:by', ++to, 'bal:to', 'dep:to', 'gas:to', 'get:to', 'nap:to', 'put:to', 'tap:to', 'top:to', ++mo, ++sa]
categories: lib
sort: 5
---

This section covers the containers sets maps and trees.

#Sets

<h2 id="++apt">++&nbsp;&nbsp;apt</h2>
####Sets invariant
`++apt` takes any tree `a` and produces a loobean indicating whether that tree is a set.

###Examples

###Summary
    ++  apt                                                 ::  set invariant
      |=  a=(tree)
      ?@  a
        &
      ?&  ?@(l.a & ?&((vor n.a n.l.a) (hor n.l.a n.a)))
          ?@(r.a & ?&((vor n.a n.r.a) (hor n.a n.r.a)))
      ==

---
<h2 id="++in">++&nbsp;&nbsp;in</h2>

####Sets container.
`++in` is the container arm for all the set arms. The contained arms inherit its sample, the set `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`[`a` `b` `c` ~])
    ~talsur-todres/try=> ~(wyt in a)
    4
  Note: `++in` is not used alone, but is used to call the arms it contains.

###Summary
    ++  in                                                  ::  set engine
      !:
      ~/  %in
      |/  a=(set)
Debugging traces are enabled with [!:](/doc/hoon/lan/rune/#zapcol).  
`++in` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++in` creates a vulcanized %gold tray that takes a set `a`.
The wet (+-) arms below inherit the sample `a`.

---
<h2 id="all:in">all:in</h2>

####Logical AND
`++all` takes a gate `b` that accepts any noun and produces a loobean representing the logical AND of all the values (`n.a`) in `a`.

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
`+-all` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-all` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts a `b`. `b` ([$+](/doc/hoon/lan/rune/#buclus)) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to a loobean.  
If `a` is an atom ([?@](/doc/hoon/lan/rune/#wutpam)), produce yes.
Otherwise produce the logical AND ([?&](/doc/hoon/lan/rune/#wutpam)) of `(b n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.


---
<h2 id="any:in">any:in</h2>

####Logical OR
`+-any` takes a gate `b` that accepts any noun and produces a loobean of the logical OR of all the values (`n.a`) in `a`

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
`+-any` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-any` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts a [gate](/doc/hoon/tut/4/) `b`. `b` ([$+](/doc/hoon/lan/rune/#buclus)) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to a loobean.  
Otherwise produce the logical OR ([?|](/doc/hoon/lan/rune/#wutbar)) of `(b n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.


---
<h2 id="del:in">del:in</h2>

####Delete at `b`
`+-del` takes any noun b and removes the member of the set `a` where `n.a` is `b`.

###Examples
    ~dovryp-toblug/try=> =b (sa `(list ,@t)`[`a` `b` `c` ~])
    ~dovryp-toblug/try=> (~(del in b) `a`)
    {`c` `b`}

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
`+-del` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-del` creates a [wet vulcanized gate `|*`](/doc/hoon/lan/rune/#bartar) which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to a set (the type of `a`).  
If `a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce null.  
If `b` is `n.a` ([=, irregular form of ^=](/doc/hoon/lan/rune/#wutgar)) test the `++hor` of `b` and `n.a` with [?:](/doc/hoon/lan/rune/#wutcol).  
If the `++hor` is `%.y`, produce a tuple recursing with `a` set to `l.a`. If the `++hor` is `%.n` produce a tuple recursing with `a` set to `r.a` (`$(a r.a)`).  
If `b` is not `n.a` A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to either null or the [bunt](/doc/hoon/lan/tile/#bunt) of `a`, `?(~ _a)`.  
If `l.a` is null, produce `r.a`.  
If `r.a` is null, produce `l.a`.  
If the `++vor` of `n.l.a` and `n.r.a` is `%.y` produce a tuple replacing `l.a` with `r.l.a` in the final value.  
Otherwise produce a tuple replacing `r.a` with `l.r.a` in the middle value.  


---
<h2 id="dig:in">dig:in</h2>

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
`+-dig` creates a [dry %gold gate |=](/doc/hoon/lan/rune/#bartis) that takes any noun `b`.  
`c` is pushed on to the subject with `=+` and set to `1`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast to a `++unit` atom.  
If `a` is null, produce null ([?~](/doc/hoon/lan/rune/#wutsig)).  
If `b` is `n.a` ([?:](/doc/hoon/lan/rune/#wutcol)) produce a `++unit` with `u=(peg c 2)`. See also: [++peg](/doc/hoon/lib/#++peg).  
If the `++gor` of `b` and `n.a` is `%.y`, recurse with `a` set to `l.a` and `c` set to `(peg c 6)`. See also: [++peg](/doc/hoon/lib/#++peg).  
Otherwise recurse with `a` set to `r.a` and `c` set to `(peg c 7)`. See also: [++peg](/doc/hoon/lib/#++peg).  


---
<h2 id="gas:in">gas:in</h2>

####Concatinate
`+-gas` takes a list `b` with members of the same type as `a` and produces `b` concatenated with `a`.

###Examples
    ~dovryp-toblug/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`[`a` `b` `c` ~])
    ~dovryp-toblug/try=> (~(gas in a) `(list ,@t)`[`d` `e` 'f' ~])
    {s `d` 'f' `a` `c` `b`}

###Summary
    +-  gas
      ~/  %gas
      |=  b=(list ,_?>(?=(^ a) n.a))
      |-  ^+  a
      ?@  b
        a
      $(b t.b, a (put(+< a) i.b))
`+-gas` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).
`+-gas` creates a [dry %gold gate |=](/doc/hoon/lan/rune/#bartis) that takes a `++list` whose members match the bunt of `n.a`s in `a`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast to the type of `a` (a set).  
If `b` is an atom ([?@](/doc/hoon/lan/rune/#wutpam)), produce `a`.  
Otherwise, recurse with `b` set to `t.b` and `a` set to `(put(+< a) i.b)`. See also: [+-put](/doc/hoon/lib/#put:in), below.


---
<h2 id="has:in">has:in</h2>

####Existence check
`+-has` accepts any noun `b` and produces a loobean indicating whether that value (`n.a`) exists in `a`.

###Examples
    ~dovryp-toblug/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`[`a` `b` `c` ~])
    ~dovryp-toblug/try=> (~(has in a) `a`)
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
`+-has` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-has` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to a loobean.  
If `a` is an atom ([?@](/doc/hoon/lan/rune/#wutpam)), produce `%.n`.
If `b` is `n.a` produce %.y.
Otherwise, if the `++hor` of `b` and `n.a` is `%.y`, recurse with `a` set to `l.a` or `a` set to `r.a` if `%.n`.  


---
<h2 id="put:in">put:in</h2>

####Insert
`+-put` accepts any noun `b` and produces `a` with `b` added to the sorted loaction in `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`[`a` `b` `c` ~])
    ~talsur-todres/try=> =b (~(put in a) `d`)
    ~talsur-todres/try=> b
    {`d` `a` `c` `b`}
    ~talsur-todres/try=> -.l.+.b
    n=`d`


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

`+-put` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-put` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^+](/doc/hoon/lan/rune/#ketlus)) to type of `a` (a set).  
If `a` is an atom ([?@](/doc/hoon/lan/rune/#wutpam)) produce `[b ~ ~]`.
If `b` is `n.a` produce `a`.
If the `++hor` of `b` and `n.a` is `%.y` ([?:](/doc/hoon/lan/rune/#wutcol)),  
`c` is pushed on to the subject with `=+` and set to the containing gate called with `a` set to `l.a`.  
[?>](/doc/hoon/lan/rune/#wutgar) asserts that `c` is not `^`.  
If the `++vor` of `n.a` and `n.c` is `%.y`, produce `[n.a c r.a]`.  
Otherwise produce `[n.c l.c [n.a r.c r.a]]`.  
If the `++hor` of `b` and `n.a` is `%.n` ([?:](/doc/hoon/lan/rune/#wutcol)),  
`c` is pushed on to the subject with [=+](/doc/hoon/lan/rune/#tislus) and set to the gate called with `a` set to `r.a`.  
[?>](/doc/hoon/lan/rune/#wutgar) asserts that `c` is not `^`.  
If the `++vor` of `n.a` and `n.c` is `%.y`, produce `[n.a l.a c]`.  
Otherwise produce `[n.c [n.a l.a l.c] r.c]`.


---
<h2 id="rep:in">rep:in</h2>

####Reduce
`+-rep` accepts a cell with any noun `b` and a tile `c`. `+-rep` produces `a` with each `n.a` replaced with `(c n.a b)`.

###Examples
    ~talsur-todres/try=> =a (~(gas in *(set ,@)) [1 2 3 ~])
    ~talsur-todres/try=> a
    {1 3 2}
    ~talsur-todres/try=> (~(rep in a) 0 |=([a=@ b=@] (add a b)))
    6

###Summary
    +-  rep
      |*  [b=* c=_,*]
      |-
      ?~  a  b
      $(a r.a, b $(a l.a, b (c n.a b)))
`+-put` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts any noun, `b` and the bunt of the tile of any noun, `c`.
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep).
If `a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce `b`.
Recurse, with `a` set to `r.a` and `b` set to the product of the gate with `a` set to `l.a` and `b` set to `(c n.a b)`.


---
<h2 id="tap:in">tap:in</h2>

####???
"`+-tap` accepts list tile with members of the same type as `a`. `+-tap` produces the set `a` converted to a list using `b`."

Note:  This appears to roughly be doing the same thing as 'gas' and in fact takes a list, not a list tile.
What is happening here?

###Examples
    ~palryp-hocsyt/try=> =s (sa `(list ,@t)`['a' 'b' 'c' ~])
    ~palryp-hocsyt/try=> s
    {'a' 'c' 'b'}
    ~palryp-hocsyt/try=> (~(tap in s) `(list ,@t)`['1' '2' '3' ~])
    ~['b' 'c' 'a' '1' '2' '3']

###Summary
    +-  tap
      ~/  %tap
      |=  b=(list ,_?>(?=(^ a) n.a))
      ^+  b
      ?@  a
        b
      $(a r.a, b [n.a $(a l.a)])


---
<h2 id="wyt:in">wyt:in</h2>

####Depth.
`+-wyt` produces the depth of set `a`.

###Examples
    ~talsur-todres/try=> =a (~(gas in `(set ,@t)`~) `(list ,@t)`[`a` `b` `c` ~])
    ~talsur-todres/try=> ~(wyt in a)
    4

###Summary
  +-  wyt
    .+
    |-  ^-  @
    ?~(a 0 +((add $(a l.a) $(a r.a))))
  --
[.+](/doc/hoon/lib/#dotlus) increments the subject.
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the product is cast ([^-](/doc/hoon/lan/rune/#kethep)) to an atom.
If `a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce `0`.
Otherwise, `++add` the products of the gate called with `a` replaced with `l.a` and `a` replaced with `r.a`.


#Maps

---
<h2 id="++ept">++&nbsp;&nbsp;ept</h2>

###Map invariant

    ++  ept                                                 ::  map invariant
      |=  a=(tree ,[p=* q=*])
      ?@  a
        &
      ?&  ?@(l.a & ?&((vor p.n.a p.n.l.a) (hor p.n.l.a p.n.a)))
          ?@(r.a & ?&((vor p.n.a p.n.r.a) (hor p.n.a p.n.r.a)))
      ==

---
<h2 id="++by">++&nbsp;&nbsp;by</h2>

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
`++by` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`++by` creates a [vulcanized %gold tray](/doc/hoon/lan/rune/#barfas) that takes a map `a`.  


---
<h2 id="all:by">all:by</h2>

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
`+-all` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-all` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts a [gate](/doc/hoon/tut/4/) `b`. `b` ([$+](/doc/hoon/lan/rune/#buclus)) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to a loobean.  
If `a` is an atom ([?@](/doc/hoon/lan/rune/#wutpam)), produce yes.
Otherwise produce the logical AND ([?&](/doc/hoon/lan/rune/#wutpam)) of `(b q.n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.



---
<h2 id="any:by">any:by</h2>

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
`+-any` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-any` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts a [gate](/doc/hoon/tut/4/) `b`. `b` ([$+](/doc/hoon/lan/rune/#buclus)) must accept any noun and produce a loobean.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to a loobean.  
Otherwise produce the logical OR ([?|](/doc/hoon/lan/rune/#wutbar)) of `(b q.n.a)`, the gate called again with `a` replaced with `l.a` and the gate called again with `a` replaced with `r.a`.

---
<h2 id="del:by">del:by</h2>

####Delete at `b`
`+-del` takes any noun b and removes the member of the set `a` where `n.a` is `b`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(del by b) `a`)
    {[p=`b` q=[2 3]]}

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
`+-del` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-del` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to a map (the type of `a`).  
If `a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce null.  
If `b` is `p.n.a` ([=, irregular form of ^=](/doc/hoon/lan/rune/#wutgar)) test the `++gor` of `b` and `p.n.a` with [?:](/doc/hoon/lan/rune/#wutcol).  
If the `++gor` is `%.y`, produce a tuple recursing with `a` set to `l.a` in the middle value. If the `++hor` is `%.n` produce a tuple recursing with `a` set to `r.a` (`$(a r.a)`) in the last value.  
If `b` is not `p.n.a` A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to either null or the [bunt](/doc/hoon/lan/tile/#bunt) of `a`, `?(~ _a)`.  
If `l.a` is null, produce `r.a`.  
If `r.a` is null, produce `l.a`.  
If the `++vor` of `p.n.l.a` and `p.n.r.a` is `%.y` produce a tuple replacing `l.a` with `r.l.a` in the final value.  
Otherwise produce a tuple replacing `r.a` with `l.r.a` in the middle value.  


---
<h2 id="dig:by">dig:by</h2>

####Get axis
`+-dig` takes any noun `b` and produces the axis of `b` within the values (`p.a`) of map `a`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(dig by b) `b`)
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
`+-dig` creates a [dry %gold gate |=](/doc/hoon/lan/rune/#bartis) that takes any noun `b`.  
`c` is pushed on to the subject with `=+` and set to `1`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast to a `++unit` atom.  
If `a` is null, produce null ([?~](/doc/hoon/lan/rune/#wutsig)).  
If `b` is `p.n.a` ([?:](/doc/hoon/lan/rune/#wutcol)) produce a `++unit` with `u=(peg c 2)`. See also: [++peg](/doc/hoon/lib/#++peg).  
If the `++gor` of `b` and `p.n.a` is `%.y`, recurse with `a` set to `l.a` and `c` set to `(peg c 6)`. See also: [++peg](/doc/hoon/lib/#++peg).  
Otherwise recurse with `a` set to `r.a` and `c` set to `(peg c 7)`. See also: [++peg](/doc/hoon/lib/#++peg).  


---
<h2 id="gas:by">gas:by</h2>

####Concat list.
`+-gas` takes a list `b` of cells of any noun and produces a new map with the members of `b` added to `a`.

###Examples
    ~talsur-todres/try=> =a (mo `(list ,[@t *])`[[`a` 1] [`b` 2] ~])
    ~talsur-todres/try=> =b `(list ,[@t *])`[[`c` 3] [`d` 4] ~]
    ~talsur-todres/try=> (~(gas by a) b)
    {[p=`d` q=4] [p=`a` q=1] [p=`c` q=3] [p=`b` q=2]}

###Summary
    +-  gas
      ~/  %gas
      |*  b=(list ,[p=* q=*])
      =>  .(b `(list ,_?>(?=(^ a) n.a))`b)
      |-  ^+  a
      ?@  b
        a
      $(b t.b, a (put(+< a) p.i.b q.i.b))
`+-gas` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-gas` creates a [wet vulcanized gate `|*`](/doc/hoon/lan/rune/#bartar) that takes a `++list` of cells of any noun `[p=* q=*]`.  
`b` is cast (using `` ` ``) to a list of the same type as the members of `a` and used as the subject for the remainder using [`=>`](/doc/hoon/lan/rune/#tisgar).
A dry `%gold` gate is created and kicked with [`|-`](/doc/hoon/lan/rune/#barhep) and the result is cast to the type of `a` (a set).  
If `b` is an atom ([`?@`](/doc/hoon/lan/rune/#wutpam)), produce `a`.  
Otherwise, recurse with `b` set to `t.b` and `a` set to `(put(+< a) i.b)`.  
See also: [`+-put`](/doc/hoon/lib/#put:in), below.


---
<h2 id="get:by">get:by</h2>

####Grab.
`+-get` takes any noun `b` and produces the value (`q.a`) at key (`p.a`) `b` or ~ if the key doesn't exist.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(get by b) `b`)
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
`+-get` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-get` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) that takes accepts any noun `b`.  

A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast to null or a `++unit` where the `u` is of the same type as `q.n.a`.
If `a` is an atom, produce null ([?@](/doc/hoon/lan/rune/#wutpam)).
If `b` is `p.n.a` produce `[~ u=p.n.a]`.
If the `++gor` of `b` and `p.n.a` is `%.y` recurse with `a` set to `l.a`.
Otherwise, recurse with `a` set to `r.a`.


---
<h2 id="has:by">has:by</h2>

####Existence check.
`+-has` takes any noun `b` and produces a loobean whether that key (`p.a`) exists in `a`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(has by b) `b`)
    %.y
    ~talsur-todres/try=> (~(has by b) `c`)
    %.n

###Summary
    +-  has
      ~/  %has
      |*  b=*
      !=(~ (get(+< a) b))
`+-has` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-has` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) that takes accepts any noun `b`.  
`+-has` produces the result of `+-get` `b` as a twig using [!=](/doc/hoon/lan/rune/#zaptis).
  

---
<h2 id="mar:by">mar:by</h2>

####Put with validation
Accepts two nouns of the types of the map's keys and values, respectively.
Validates that the value is not null and puts the pair in the map.  If the value
is null, it deletes the key.

###Examples


###Summary
    +-  mar
      |*  [b=_?>(?=(^ a) p.n.a) c=(unit ,_?>(?=(^ a) q.n.a))]
      ?~  c
        (del b)
      (put b u.c)

`+-mar` produces a [vulcanized wet gate |*](/doc/hoon/lan/run/#bartar) which accepts two nouns of the map's key-value types.

---
<h2 id="put:by">put:by</h2>

####Insert
`+-put` takes a cell of two nouns `[b=* c=*]` and produces the map `a` with added `[b=* c=*]`.

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])  
    ~talsur-todres/try=> (~(put by b) `c` 1)
    {[p=`a` q=1] [p=`c` q=1] [p=`b` q=[2 3]]}

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
`+-put` is a [jetted arm (~/)](/doc/hoon/lan/rune/#sigfas).  
`+-put` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts a cell of any two nouns, `[b=* c=*]`.
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^+](/doc/hoon/lan/rune/#ketlus)) to type of `a` (a map).  
If `a` is an atom ([?@](/doc/hoon/lan/rune/#wutpam)) produce `[[b c] ~ ~]`.
If `b` is `p.n.a` and `c` is `q.n.a`, produce `a`.
If `b` is `p.n.a` and `c` is not `q.n.a`, produce `[[b c] l.a r.a]`.
If the `++gor` of `b` and `p.n.a` is `%.y` ([?:](/doc/hoon/lan/rune/#wutcol)),  
`d` is pushed on to the subject with `=+` and set to the containing gate called with `a` set to `l.a`.  
[?>](/doc/hoon/lan/rune/#wutgar) asserts that `d` is not `^`.  
If the `++vor` of `p.n.a` and `p.n.d` is `%.y`, produce `[n.a d r.a]`.  
Otherwise produce `[n.d l.d [n.a r.d r.a]]`.  
If the `++hor` of `b` and `n.a` is `%.n` ([?:](/doc/hoon/lan/rune/#wutcol)),  
`d` is pushed on to the subject with `=+` and set to the gate called with `a` set to `r.a`.  
[?>](/doc/hoon/lan/rune/#wutgar) asserts that `d` is not `^`.  
If the `++vor` of `p.n.a` and `p.n.d` is `%.y`, produce `[n.a l.a d]`.  
Otherwise produce `[n.d [n.a l.a l.d] r.d]`.

---
<h2 id="rep:by">rep:by</h2>

####Reduce
`+-rep` walks through the map `a` replacing `b` with the product of calling `c` with `n.a` and `b`.

###Examples
    ~talsur-todres/try=> =a (~(gas by *(map ,@ ,@)) [`a` 1] [`b` 2] ~)
    ~talsur-todres/try=> a
    {[p=97 q=1] [p=98 q=2]}
    ~talsur-todres/try=> (~(rep by a) 0 |=([a=[p=@t q=@] b=@] (add q.a b)))
    3

###Summary
    +-  rep
      |*  [b=* c=_,*]
      |-
      ?~  a  b
      $(a r.a, b $(a l.a, b (c n.a b)))


---
<h2 id="rib:by">rib:by</h2>

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
`+-rib` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts a cell of any two nouns, `[b=* c=*]`.


---
<h2 id="run:by">run:by</h2>

####Map / Each
`+-run` takes a gate `b`. `+-run` walks through the map `a` and produces a null-terminated tuple with `[p.n.a (b q.n.a)]`.

###Examples
    ~talsur-todres/try=>  =b (mo `(list ,[@t *])`[[`a` 97] [`b` 98] ~])  
    ~talsur-todres/try=> (~(run by b) ,@t)
    [[`b` `b`] [[`a` `a`] ~ ~] ~]

###Summary
    +-  run
      |*  b=_,*
      |-
      ?~  a  a
      [[p.n.a (b q.n.a)] $(a l.a) $(a r.a)]
`+-run` creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts any gate, `b`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep).  
If `a` is null, return `a` ([?~](/doc/hoon/lan/rune/#wutsig)).
Otherwise, produce a tuple with `[p.n.a (b q.n.a)]`, the containing gate called with `a` replaced by `l.a` and the containing gate called with `a` replaced by `r.a`.
  

---
<h2 id="tap:by">tap:by</h2>

####Listify pairs

###Examples
    ~talsur-todres/try=> =b (mo `(list ,[@t *])`[[`a` 97] [`b` 98] ~])
    ~talsur-todres/try=> =c `(list ,[@t @])`[[`d` 4] [`e` 5] ~]
    ~talsur-todres/try=> (~(tap by b) c)
    ~[[p=`b` q=98] [p=`a` q=97] [p=`d` q=4] [p=`e` q=5]]

###Summary
    +-  tap
      ~/  %tap
      |=  b=(list ,_?>(?=(^ a) n.a))
      ^+  b
      ?@  a
        b
      $(a r.a, b [n.a $(a l.a)])


---
<h2 id="uni:by">uni:by</h2>

####Union, merge
`+-uni` produces the union of map `b` with `a`.

###Examples

###Summary
    +-  uni
      ~/  %uni
      |=  b=_a
      ?@  b  a
      %=  $
        a  (~(put by a) p.n.b q.n.b)
        b  (~(uni by l.b) r.b)
      ==

---
<h2 id="wyt:by">wyt:by</h2>

####Depth of map
`+-wyt` produces the depth of `a`.

###Examples
    ~talsur-todres/try=>  =a (mo `(list ,[@t *])`[['a' 1] ['b' [2 3]] ~])
    ~talsur-todres/try=> ~(wyt by a)
    3
    ~talsur-todres/try=> =a (mo `(list ,[@t *])`[[`a` 1] [`b` [2 3]] [`c` [4 5]] ~])
    ~talsur-todres/try=> ~(wyt by a)
    4

###Summary
    +-  wyt
      .+
      |-  ^-  @
      ?~(a 0 +((add $(a l.a) $(a r.a))))
    --
[.+](/doc/hoon/lib/#dotlus) increments our subject.
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the subject is cast ([^-](/doc/hoon/lan/rune/#kethep)) to an atom.
If `a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce `0`.
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
`++to` creates a [vulcanized %gold tray](/doc/hoon/lan/rune/#barfas) that takes a qeu `a`.
The wet (+-) arms below inherit the sample `a`.


---
<h2 id="bal:to">bal:to</h2>

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


---
<h2 id="dep:to">dep:to</h2>

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
`+-dep` creates a dry `%gold` gate kicks it with [|-](/doc/hoon/lan/rune/barhep) and the result is cast ([^-](/doc/hoon/lan/rune/#kethep)) to an atom.  
If `a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce 0.
Otherwise produce the `++max` of the containing gate called with `a` replaced with `l.a` and `a` replaced with `r.a`.
Increment that product using `+`, the irregular form of `.+`.


---
<h2 id="gas:to">gas:to</h2>

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
`+-gas` creates a [dry %gold gate |=](/doc/hoon/lan/rune/#bartis) that takes any `++list` `b` whose members resemble the `n.a` in `a`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast to the type of `a` (a qeu) using `^+`.  
If `b` is null, produce `a` ([?~](/doc/hoon/lan/rune/#wutsig)).
Otherwise, call the containing gate replacing `b` with `t.b` and `a` with `(put(+< a) i.b)`.
See `+-put` below.


---
<h2 id="get:to">get:to</h2>

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
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the result is cast using [^+](/doc/hoon/lan/rune/#ketlus)to a cell where `p` resembles `n.a` and `q` resmbles `a`.  
If `a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce a crash ([!!](/doc/hoon/lan/rune/#zapzap)).  
If `r.a` is null ([?~](/doc/hoon/lan/rune/#wutsig)), produce `[n.a l.a]`.  
`b` is pushed on to the subject using `=+` and set to the containing gate called with `a` replaced with `r.a`.  
[:-](/doc/hoon/lan/rune/#c is used to produce our final result, p.b and:
If ([?:](/doc/hoon/lan/rune/#wutcol)) `q.b` is null ([?=](/doc/hoon/lan/rune/#wuttis)) or ([|, irregular form of ?|](/doc/hoon/lan/rune/#wutbar) the `++vor` of `n.a` and `n.q.b` is `%.y`.  
Otherwise, produce `[n.q.b [n.a l.a l.q.b] r.q.b]`.


---
<h2 id="nap:to">nap:to</h2>

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
`+-nap` asserts that `a` is ([?=](/doc/hoon/lan/rune/#wuttis)) not ([?>](/doc/hoon/lan/rune/#wutgar)) `^`.
If [?:](/doc/hoon/lan/rune/#wutcol) `l.a` is null, produce `r.a`.
`b` is pushed on to the subject using [=+](/doc/hoon/lan/rune/#tislus) and set to `get(+< l.a)`
`bal(+< ^+(a [p.b q.b r.a]))`


---
<h2 id="put:to">put:to</h2>

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
`+-put`creates a [wet vulcanized gate |*](/doc/hoon/lan/rune/#bartar) which accepts any noun, `b`.  
A dry `%gold` gate is created and kicked with [|-](/doc/hoon/lan/rune/barhep) and the product is cast using [^+](/doc/hoon/lan/rune/#ketlus) to the type of `a` (a qeu).  
If `a` is null, produce `[b ~ ~]`.
Otherwise, produce `bal(+< a(l $(a l.a)))`.


---
<h2 id="tap:to">tap:to</h2>

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
`+-tap` creates a [dry %gold gate |=](/doc/hoon/lan/rune/#bartis) that takes a `++list` whose tile corresponds to the icon of `n.a`.
The product is cast using [^+](/doc/hoon/lan/rune/#ketlus) to the type of `b`.
If `a` is null, produce `b`.
Recurse, replacing `a` with `r.a` and `b` with the cell `n.a` and the containing gate called with `a` replaced with `l.a`.


---
<h2 id="top:to">top:to</h2>

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
`+-top` creates a dry `%gold` gate and kicks it with [|-](/doc/hoon/lan/rune/barhep) and the product is cast using [^-](/doc/hoon/lan/rune/#kethep) to a unit whose `u` has the same icon as `n.a`.
If `a` is null ([?@](/doc/hoon/lan/rune/#wutpam)), produce null. 
If `r.a` is null, produce `[~ n.a]`.
Otherwise recurse, replacing `a` with `r.a`.
  

#Casual containers

<h2 id="++mo">++&nbsp;&nbsp;mo</h2>

####Mapify
`++mo` takes a `++list` of cells `a` and produces a `map` with the members of `a`.

###Examples
    ~talsur-todres/try=> (mo `(list ,[@t *])`[[`a` 1] [`b` 2] ~])
    {[p=`a` q=1] [p=`b` q=2]}

###Summary
    ++  mo                                                  ::  make a map
      |*  a=(list)
      =>  .(a `_(homo a)`a)
      =>  .(a `(list ,[p=_-<.a q=_->.a])`a)
      =+  b=*(map ,_?>(?=(^ a) p.i.a) ,_?>(?=(^ a) q.i.a))
      (~(gas by b) a)


<h2 id="++sa">++&nbsp;&nbsp;sa</h2>
####Setify
`++sa` takes a list `a` and produces a set with the members of `a`.

###Examples
    ~talsur-todres/try=> (sa `(list ,@)`[1 2 3 4 5 ~])
    {5 4 1 3 2}
    ~talsur-todres/try=> (sa `(list ,[@t *])`[[`a` 1] [`b` 2] ~])
    {[`a` 1] [`b` 2]}

###Summary
    ++  sa                                                  ::  make a set
      |*  a=(list)
      =>  .(a `_(homo a)`a)
      =+  b=*(set ,_?>(?=(^ a) i.a))
      (~(gas in b) a)
