title: 2e miscellaneous libraries
section: 2e
arms: 
axis: doc-hoon
categories: lib
sort: 2
---

section 2eA, packing
   
##++cue

####Unpack an atom

`++cue` is the inverse of [++jam](), which compresses a noun into an atom.++jam and ++cue create a reversible mapping between nouns and atoms.

###Examples

~midlys-rocpet/try=> (cue (jam 1))
1

~midlys-rocpet/try=> (cue 4.657)
[1 2]

~midlys-rocpet/try=> (cue (jam [1 1]))
[1 1]

###Summary

    ++  cue                                                 ::  unpack
      ~/  %cue
      |=  a=@
      ^-  *
      =+  b=0
      =+  m=`(map ,@ ,*)`~
      =<  q
      |-  ^-  [p=@ q=* r=_m]
      ?:  =(0 (cut 0 [b 1] a))
        =+  c=(rub +(b) a)
        [+(p.c) q.c (~(put by m) b q.c)]
      =+  c=(add 2 b)
      ?:  =(0 (cut 0 [+(b) 1] a))
        =+  u=$(b c)
        =+  v=$(b (add p.u c), m r.u)
        =+  w=[q.u q.v]
        [(add 2 (add p.u p.v)) w (~(put by r.v) b w)]
      =+  d=(rub c a)
      [(add 2 p.d) (need (~(get by m) q.d)) m]
    ::

`++cue` is a jetted function [~/]() that creates a [dry %gold gate]() that accepts an atomic sample labeled `a` [^=](). `++cue` produces a noun [^-]()

##++jam

####Pack a noun 

`++jam` compresses a noun into an atom , which can be decompressed with `++cue`. ++jam and ++cue create a reversible mapping between nouns and atoms.

###Examples

~midlys-rocpet/try=> (jam 1)
12

~midlys-rocpet/try=> (jam [1 1])
817

###Summary

    ++  jam                                                 ::  pack
      ~/  %jam
      |=  a=*
      ^-  @
      =+  b=0
      =+  m=`(map ,* ,@)`~
      =<  q
      |-  ^-  [p=@ q=@ r=_m]
      =+  c=(~(get by m) a)
      ?@  c
        =>  .(m (~(put by m) a b))
        ?:  ?=(@ a)
          =+  d=(mat a)
          [(add 1 p.d) (lsh 0 1 q.d) m]
        =>  .(b (add 2 b))
        =+  d=$(a -.a)
        =+  e=$(a +.a, b (add b p.d), m r.d)
        [(add 2 (add p.d p.e)) (mix 1 (lsh 0 2 (cat 0 q.d q.e))) r.e]
      ?:  ?&(?=(@ a) (lte (met 0 a) (met 0 u.c)))
        =+  d=(mat a)
        [(add 1 p.d) (lsh 0 1 q.d) m]
      =+  d=(mat u.c)
      [(add 2 p.d) (mix 3 (lsh 0 2 q.d)) m]
    ::

`++jam` is a jetted function [~/]() that creates a [dry %gold gate]() that accepts an atomic sample labeled `a` [^=]() and produces a noun [^-]()

##++mat

####Length encode

`++mat` is only used internally to `++jam` and `++cue`.

    ++  mat                                                 ::  length-encode
      ~/  %mat
      |=  a=@
      ^-  [p=@ q=@]
      ?:  =(0 a)
        [1 1]
      =+  b=(met 0 a)
      =+  c=(met 0 b)
      :-  (add (add c c) b)
      (cat 0 (bex c) (mix (end 0 (dec c) b) (lsh 0 (dec c) a)))
    ::


##++rub


####Length decode

`++rub` is only used internally to `++jam` and `++cue`.

    ++  rub                                                 ::  length-decode
      ~/  %rub
      |=  [a=@ b=@]
      ^-  [p=@ q=@]
      =+  c==+(c=0 |-(?.(=(0 (cut 0 [(add a c) 1] b)) c $(c +(c)))))
      ?:  =(0 c)
        [1 0]
      =+  d=(add a +(c))
      =+  e=(add (bex (dec c)) (cut 0 [d (dec c)] b))
      [(add (add c c) e) (cut 0 [(add d (dec c)) e] b)]


#section 2eB, parsing (tracing)

##++last

####Farther trace

++last compares two [line column] pairs (`++hair`)[] and produces the one that is farther along.   

###Examples

    ~midlys-rocpet/try=> (last [1 1] [1 2])
    [p=1 q=2]

    ~midlys-rocpet/try=> (last [2 1] [1 2])
    [p=2 q=1]

###Summary

    ++  last  |=  [zyc=hair naz=hair]
              ^-  hair
              ?:  =(p.zyc p.naz)
                ?:((gth q.zyc q.naz) zyc naz)
              ?:((gth p.zyc p.naz) zyc naz)


##++lust

####Trace newline

`++lust` takes a character (++char) and sets a [line column] pair (++hair) to the beginning of the next line if the character is a newline character (ASCII 10), otherwise it increments the column number. 

###Examples

    ~midlys-rocpet/try=> (lust 'a' [1 1])
    [p=1 q=2]

    ~midlys-rocpet/try=> (lust `@t`10 [1 1])
    [p=2 q=1]

###Summary

    ++  lust  |=  [weq=char naz=hair]
              ^-  hair
              ?:(=(10 weq) [+(p.naz) 1] [p.naz +(q.naz)])
    
    
    
    
section 2eC, parsing (custom rules)


##++cold

####Replace

++cold creates a gate that applies a ++rule to a nail, and replaces the parsed product with a constant.

###Examples

~midlys-rocpet/try=> ((cold %foo (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p=%foo q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((cold %foo (just 'a')) [[1 1] "bc"])
[p=[p=1 q=1] q=~]

###Summary

    ++  cold
      ~/  %cold
      |*  [cus=* sef=_rule]
      ~/  %fun
      |=  tub=nail
      =+  vex=(sef tub)
      ?@  q.vex
        vex
      [p=p.vex q=[~ u=[p=cus q=q.u.q.vex]]]



##++cook

####Modify

++cook creates a gate that applies a ++rule to a ++nail, and modifies the parsed product with an expression.

###Examples

~midlys-rocpet/try=> ((cook ,@ud (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p=97 q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((cook ,@tas (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p=%a q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((cook |=(a=@ +(a)) (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p=98 q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((cook |=(a=@ `@t`+(a)) (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p='b' q=[p=[p=1 q=2] q="bc"]]]]


###Summary
    ++  cook
      ~/  %cook
      |*  [poq=_,* sef=_rule]
      ~/  %fun
      |=  tub=nail
      =+  vex=(sef tub)
      ?@  q.vex
        vex
      [p=p.vex q=[~ u=[p=(poq p.u.q.vex) q=q.u.q.vex]]]
    ::

##++easy

####always parses

++easy always succeeds and consumes no characters.

###Examples

~midlys-rocpet/try=> ((easy %foo) [[1 1] "abc"])
[p=[p=1 q=1] q=[~ [p=%foo q=[p=[p=1 q=1] q="abc"]]]]
~midlys-rocpet/try=> ((easy %foo) [[1 1] "bc"])
[p=[p=1 q=1] q=[~ [p=%foo q=[p=[p=1 q=1] q="bc"]]]]
    ++  easy
      ~/  %easy
      |*  huf=*
      ~/  %fun
      |=  tub=nail
      ^-  (like ,_huf)
      [p=p.tub q=[~ u=[p=huf q=tub]]]
    ::

##++fail

####never parses

++fail always fails to parse.

###Examples

~midlys-rocpet/try=> (fail [[1 1] "abc"])
[p=[p=1 q=1] q=~]

###Summary

    ++  fail  |=(tub=nail [p=p.tub q=~])


##++full

####end of nail

++full only succeeds if given a rule that successfully parses the entire nail to the end.

###Examples

~midlys-rocpet/try=> ((full (just 'a')) [[1 1] "ab"])
[p=[p=1 q=2] q=~]
~midlys-rocpet/try=> ((full (jest 'ab')) [[1 1] "ab"])
[p=[p=1 q=3] q=[~ u=[p='ab' q=[p=[p=1 q=3] q=""]]]]
~midlys-rocpet/try=> ((full ;~(plug (just 'a') (just 'b'))) [[1 1] "ab"])
[p=[p=1 q=3] q=[~ u=[p=[~~a ~~b] q=[p=[p=1 q=3] q=""]]]]
~midlys-rocpet/try=> 

###Summary

    ++  full
      |*  sef=_rule
      |=  tub=nail
      =+  vex=(sef tub)
      ?@(q.vex vex ?:(=(~ q.q.u.q.vex) vex [p=p.vex q=~]))


    
##++funk

XX not used

    ++  funk
      |*  [pre=tape sef=_rule]
      |=  tub=nail
      (sef p.tub (weld pre q.tub))


##++here

    ++  here
      ~/  %here
      |*  [hez=_|=([a=pint b=*] [a b]) sef=_rule]
      ~/  %fun
      |=  tub=nail
      =+  vex=(sef tub)
      ?@  q.vex
        vex
      [p=p.vex q=[~ u=[p=(hez [p.tub p.q.u.q.vex] p.u.q.vex) q=q.u.q.vex]]]
    
##++jest

####match a cord

++jest matches matches and consumes a cord.

###Examples

~midlys-rocpet/try=> ((jest 'abc') [[1 1] "abcd"])
[p=[p=1 q=4] q=[~ [p='abc' q=[p=[p=1 q=4] q="d"]]]]
~midlys-rocpet/try=> ((jest 'foo') [[1 1] "foo"])
[p=[p=1 q=4] q=[~ [p='foo' q=[p=[p=1 q=4] q=""]]]]
~midlys-rocpet/try=> ((jest 'foo') [[1 1] "bar"])
[p=[p=1 q=1] q=~]
~midlys-rocpet/try=> ((jest 'foo') [[1 1] "fo"])
[p=[p=1 q=3] q=~]
~midlys-rocpet/try=> ((jest 'foo') [[1 1] "food"])
[p=[p=1 q=4] q=[~ [p='foo' q=[p=[p=1 q=4] q="d"]]]]

    ++  jest
      |=  daf=@t
      |=  tub=nail
      =+  fad=daf
      |-  ^-  (like ,@t)
      ?:  =(0 daf)
        [p=p.tub q=[~ u=[p=fad q=tub]]]
      ?:  |(?=(~ q.tub) !=((end 3 1 daf) i.q.tub))
        (fail tub)
      $(p.tub (lust i.q.tub p.tub), q.tub t.q.tub, daf (rsh 3 1 daf))

##++just

####match a char

++just matches matches and consumes a single character.

###Examples

~midlys-rocpet/try=> ((just 'a') [[1 1] "abc"])
[p=[p=1 q=2] q=[~ [p=~~a q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((just 'b') [[1 1] "abc"])
[p=[p=1 q=1] q=~]

###Summary

    ++  just                                                ::  XX redundant, jest
      ~/  %just
      |=  daf=char
      ~/  %fun
      |=  tub=nail
      ^-  (like char)
      ?@  q.tub
        (fail tub)
      ?.  =(daf i.q.tub)
        (fail tub)
      (next tub)
    
##++knee 
  
####callback

    ++  knee
      |*  [gar=* sef=_|.(rule)]
      |=  tub=nail
      ^-  (like ,_gar)
      ((sef) tub)
    ::

##++mask

####match with list of characters

++match matches the next character to a list of characters.

###Examples
~midlys-rocpet/try=> ((mask "abc") [[1 1] "abc"])
[p=[p=1 q=2] q=[~ [p=~~a q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((mask "abc") [[1 1] "bbc"])
[p=[p=1 q=2] q=[~ [p=~~b q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((mask "abc") [[1 1] "dbc"])
[p=[p=1 q=1] q=~]

###Summary

    ++  mask
      ~/  %mask
      |=  bud=(list char)
      ~/  %fun
      |=  tub=nail
      ^-  (like char)
      ?@  q.tub
        (fail tub)
      ?.  (lien bud |=(a=char =(i.q.tub a)))
        (fail tub)
      (next tub)
    ::


##++next

####consume a character

++next always succeeds and consumes a character.

###Examples

~midlys-rocpet/try=> (next [[1 1] "ebc"])
[p=[p=1 q=2] q=[~ [p=~~e q=[p=[p=1 q=2] q="bc"]]]]

###Summary

    ++  next
      |=  tub=nail
      ^-  (like char)
      ?@  q.tub
        (fail tub)
      =+  zac=(lust i.q.tub p.tub)
      [zac [~ i.q.tub [zac t.q.tub]]]

##++sear

####test and transform, or fail

++sear applies a rule to a nail, applies a test to the product in the edge, and transforms the product if the test succeeded. Otherwise ++sear fails.

###Examples

~midlys-rocpet/try=> ((sear |=(a=* ?@(a (some a) ~)) (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p=97 q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((sear |=(a=* ?@(a [~ u=a] ~)) (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p=97 q=[p=[p=1 q=2] q="bc"]]]]

###summary

    ++  sear
      ~/  %sear
      |*  [pyq=_|=(* *(unit)) sef=_rule]
      ~/  %fun
      |=  tub=nail
      =+  vex=(sef tub)
      ?@  q.vex
        vex
      =+  gey=(pyq p.u.q.vex)
      ?@  gey
        [p=p.vex q=~]
      [p=p.vex q=[~ u=[p=u.gey q=q.u.q.vex]]]



##++shim

####range of values

++shim succeeds if the character is within a range.

###Examples

~midlys-rocpet/try=> ((shim 'a' 'z') [[1 1] "abc"])
[p=[p=1 q=2] q=[~ [p=~~a q=[p=[p=1 q=2] q="bc"]]]]
~midlys-rocpet/try=> ((shim 'A' 'Z') [[1 1] "abc"])
[p=[p=1 q=1] q=~]
~midlys-rocpet/try=> ((shim 'A' 'Z') [[1 1] "Abc"])
[p=[p=1 q=2] q=[~ [p=~~~41. q=[p=[p=1 q=2] q="bc"]]]]

###Summary

    ++  shim
      ~/  %shim
      |=  zep=[p=@ q=@]
      ~/  %fun
      |=  tub=nail
      ^-  (like char)
      ?@  q.tub
        (fail tub)
      ?.  ?&((gte i.q.tub p.zep) (lte i.q.tub q.zep))
        (fail tub)
      (next tub)

##++stag

####add label

++stag adds a label to the product of a rule if the rule successfully parses

    ++  stag
      ~/  %stag
      |*  [gob=* sef=_rule]
      ~/  %fun
      |=  tub=nail
      =+  vex=(sef tub)
      ?@  q.vex
        vex
      [p=p.vex q=[~ u=[p=[gob p.u.q.vex] q=q.u.q.vex]]]
    ::

~midlys-rocpet/try=> ((stag %foo (just 'a')) [[1 1] "abc"])
[p=[p=1 q=2] q=[~ u=[p=[%foo ~~a] q=[p=[p=1 q=2] q="bc"]]]]

##++stet


    ++  stet
      |*  leh=(list ,[?(@ [@ @]) _rule])
      |-  
      ?~  leh 
        ~ 
      [i=[p=-.i.leh q=+.i.leh] t=$(leh t.leh)]

##++stew

    ++  stew
      ~/  %stew
      |*  leh=(list ,[p=?(@ [@ @]) q=_rule])
      =+  ^=  wor
          |=  [ort=?(@ [@ @]) wan=?(@ [@ @])]
          ?@  ort
            ?@(wan (lth ort wan) (lth ort -.wan))
          ?@(wan (lth +.ort wan) (lth +.ort -.wan))
      =+  ^=  hel
          =+  hel=`(tree $_(?>(?=(^ leh) i.leh)))`~
          |-  ^+  hel
          ?~  leh
            ~
          =+  yal=$(leh t.leh)
          |-  ^+  hel
          ?~  yal
            [i.leh ~ ~]
          ?:  (wor p.i.leh p.n.yal)
            =+  nuc=$(yal l.yal)
            ?>  ?=(^ nuc)
            ?:  (vor p.n.yal p.n.nuc)
              [n.yal nuc r.yal]
            [n.nuc l.nuc [n.yal r.nuc r.yal]]
          =+  nuc=$(yal r.yal)
          ?>  ?=(^ nuc)
          ?:  (vor p.n.yal p.n.nuc)
            [n.yal l.yal nuc]
          [n.nuc [n.yal l.yal l.nuc] r.nuc]
      ~%  %fun  ..^$  ~
      |=  tub=nail
      ?@  q.tub
        (fail tub)
      |-
      ?@  hel
        (fail tub)
      ?:  ?@  p.n.hel
            =(p.n.hel i.q.tub)
          ?&((gte i.q.tub -.p.n.hel) (lte i.q.tub +.p.n.hel))
        ::  (q.n.hel [(lust i.q.tub p.tub) t.q.tub])
        (q.n.hel tub)
      ?:  (wor i.q.tub p.n.hel)
        $(hel l.hel)
      $(hel r.hel)


##++stir


    ++  stir
      ~/  %stir
      |*  [rud=* raq=_|*([a=* b=*] [a b]) fel=_rule]
      ~/  %fun
      |=  tub=nail
      ^-  (like ,_rud)
      =+  vex=(fel tub)
      ?@  q.vex
        [p.vex [~ rud tub]]
      =+  wag=$(tub q.u.q.vex)
      ?>  ?=(^ q.wag)
      [(last p.vex p.wag) [~ (raq p.u.q.vex p.u.q.wag) q.u.q.wag]]


##++stun



    ++  stun
      ~/  %stun
      |*  [[les=@ mos=@] fel=_rule]
      ~/  %fun
      |=  tub=nail
      ^-  (like (list ,_(wonk (fel))))
      ?:  =(0 mos)
        [p.tub [~ ~ tub]]
      =+  vex=(fel tub)
      ?@  q.vex
        ?:  =(0 les)
          [p.vex [~ ~ tub]]
        vex
      =+  ^=  wag  %=  $
                     les  ?:(=(0 les) 0 (dec les))
                     mos  ?:(=(0 mos) 0 (dec mos))
                     tub  q.u.q.vex
                   ==
      ?@  q.wag
        wag
      [p.wag [~ [p.u.q.vex p.u.q.wag] q.u.q.wag]]



section 2eD, parsing (combinators)



    ++  bend
      ~/  %bend
      |*  raq=_|*([a=* b=*] [~ u=[a b]])
      ~/  %fun
      |*  [vex=edge sab=_rule]
      ?@  q.vex
        vex
      =+  yit=(sab q.u.q.vex)
      =+  yur=(last p.vex p.yit)
      ?@  q.yit
        [p=yur q=q.vex]
      =+  vux=(raq p.u.q.vex p.u.q.yit)
      ?~  vux
        [p=yur q=q.vex]
      [p=yur q=[~ u=[p=u.vux q=q.u.q.yit]]]
    ::



    ++  comp
      ~/  %comp
      |*  raq=_|*([a=* b=*] [a b])
      ~/  %fun
      |*  [vex=edge sab=_rule]
      ?@  q.vex
        vex
      =+  yit=(sab q.u.q.vex)
      =+  yur=(last p.vex p.yit)
      ?@  q.yit
        [p=yur q=q.yit]
      [p=yur q=[~ u=[p=(raq p.u.q.vex p.u.q.yit) q=q.u.q.yit]]]
    ::



    ++  glue
      ~/  %glue
      |*  bus=_rule
      ~/  %fun
      |*  [vex=edge sab=_rule]
      (plug vex ;~(pfix bus sab))
    ::



    ++  pfix
      ~/  %pfix
      |*  [vex=edge sab=_rule]
      ?@  q.vex
        vex
      =+  yit=(sab q.u.q.vex)
      [p=(last p.yit p.vex) q=q.yit]
    ::



    ++  plug
      ~/  %plug
      |*  [vex=edge sab=_rule]
      ?@  q.vex
        vex
      =+  yit=(sab q.u.q.vex)
      =+  yur=(last p.vex p.yit)
      ?@  q.yit
        [p=yur q=q.yit]
      [p=yur q=[~ u=[p=[p.u.q.vex p.u.q.yit] q=q.u.q.yit]]]
    ::



    ++  pose
      ~/  %pose
      |*  [vex=edge sab=_rule]
      ?@  q.vex
        =+  roq=(sab)
        [p=(last p.vex p.roq) q=q.roq]
      vex
    ::



    ++  sfix
      ~/  %sfix
      |*  [vex=edge sab=_rule]
      ?@  q.vex
        vex
      =+  yit=(sab q.u.q.vex)
      [p=(last p.vex p.yit) q=?@(q.yit ~ [~ u=[p=p.u.q.vex q=q.u.q.yit]])]





    ::                section 2eE, parsing (composers)      ::
    ::
    ++  bass
      |*  [wuc=@ tyd=_rule]
      %+  cook
        |=  waq=(list ,@)
        %+  roll
          waq
        =|([p=@ q=@] |.((add p (mul wuc q))))
      tyd
    ::
    ++  boss
      |*  [wuc=@ tyd=_rule]
      %+  cook
        |=  waq=(list ,@)
        %+  reel
          waq
        =|([p=@ q=@] |.((add p (mul wuc q))))
      tyd
    ::
    ++  ifix
      |*  [fel=[p=_rule q=_rule] hof=_rule]
      ;~(pfix p.fel ;~(sfix hof q.fel))
    ::
    ++  more
      |*  [bus=_rule fel=_rule]
      ;~(pose (most bus fel) (easy ~))
    ::
    ++  most
      |*  [bus=_rule fel=_rule]
      ;~(plug fel (star ;~(pfix bus fel)))
    ::
    ++  plus  |*(fel=_rule ;~(plug fel (star fel)))
    ++  slug
      |*  [rud=* raq=_|*([a=* b=*] [a b])]
      |*  [bus=_rule fel=_rule]
      ;~((comp raq) fel (stir rud raq ;~(pfix bus fel)))
    ::
    ++  star
      |*  fel=_rule
      (stir `(list ,_(wonk *fel))`~ |*([a=* b=*] [a b]) fel)
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eF, parsing (ascii)          ::
    ::
    ++  ace  (just ' ')
    ++  bar  (just '|')
    ++  bas  (just '\\')
    ++  buc  (just '$')
    ++  cab  (just '_')
    ++  cen  (just '%')
    ++  col  (just ':')
    ++  com  (just ',')
    ++  doq  (just '"')
    ++  dot  (just '.')
    ++  fas  (just '/')
    ++  gal  (just '<')
    ++  gar  (just '>')
    ++  hax  (just '#')
    ++  kel  (just '{')
    ++  ker  (just '}')
    ++  ket  (just '^')
    ++  lus  (just '+')
    ++  hep  (just '-')
    ++  pel  (just '(')
    ++  pam  (just '&')
    ++  per  (just ')')
    ++  pat  (just '@')
    ++  sel  (just '[')
    ++  sem  (just ';')
    ++  ser  (just ']')
    ++  sig  (just '~')
    ++  soq  (just '\'')
    ++  tar  (just '*')
    ++  tec  (just '`')
    ++  tis  (just '=')
    ++  wut  (just '?')
    ++  zap  (just '!')
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eG, parsing (whitespace)     ::
    ::
    ++  dog  ;~(plug dot gay)
    ++  doh  ;~(plug ;~(plug hep hep) gay)
    ++  dun  (cold ~ ;~(plug hep hep))
    ++  duq  (cold ~ ;~(plug tis hep))
    ++  duz  (cold ~ ;~(plug tis tis))
    ++  gah  (mask [`@`10 ' ' ~])
    ++  gap  (cold ~ ;~(plug gaq (star ;~(pose vul gah))))
    ++  gaq  ;~(pose (just `@`10) ;~(plug gah ;~(pose gah vul)) vul)
    ++  gay  ;~(pose gap (easy ~))
    ++  vul  (cold ~ ;~(plug col col (star (shim 32 126)) (just ^-(@ 10))))
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eH, parsing (idioms)         ::
    ::
    ++  alf  ;~(pose low hig)
    ++  aln  ;~(pose low hig nud)
    ++  alp  ;~(pose low hig nud hep)
    ++  bet  ;~(pose (cold 2 hep) (cold 3 lus))
    ++  bin  (bass 2 (most gon but))
    ++  but  (cook |=(a=@ (sub a '0')) (shim '0' '1'))
    ++  dem  (bass 10 (most gon dit))
    ++  dit  (cook |=(a=@ (sub a '0')) (shim '0' '9'))
    ++  gul  ;~(pose (cold 2 gal) (cold 3 gar))
    ++  gon  ;~(pose ;~(plug bas gay fas) (easy ~))
    ++  hex  (bass 16 (most gon hit))
    ++  hig  (shim 'A' 'Z')
    ++  hit  ;~  pose
               dit
               (cook |=(a=char (sub a 87)) (shim 'a' 'f'))
               (cook |=(a=char (sub a 55)) (shim 'A' 'F'))
             ==
    ++  low  (shim 'a' 'z')
    ++  mes  (cook |=([a=@ b=@] (add (mul 16 a) b)) ;~(plug hit hit))
    ++  nix  (boss 256 (star ;~(pose aln cab)))
    ++  nud  (shim '0' '9')
    ++  poy  ;~(pfix bas ;~(pose bas soq mes))
    ++  qit  ;~(pose (shim 32 38) (shim 40 91) (shim 93 126) (shim 128 255) poy)
    ++  qut  (ifix [soq soq] (boss 256 (more gon qit)))
    ++  sym
      %+  cook
        |=(a=tape (rap 3 ^-((list ,@) a)))
      ;~(plug low (star ;~(pose nud low hep)))
    ::
    ++  ven  ;~  (comp |=([a=@ b=@] (peg a b)))
               bet
               =+  hom=`?`|
               |=  tub=nail
               ^-  (like axis)
               =+  vex=?:(hom (bet tub) (gul tub))
               ?@  q.vex
                 [p.tub [~ 1 tub]]
               =+  wag=$(p.tub p.vex, hom !hom, tub q.u.q.vex)
               ?>  ?=(^ q.wag)
               [p.wag [~ (peg p.u.q.vex p.u.q.wag) q.u.q.wag]]
             ==
    ++  vit
      ;~  pose
        (cook |=(a=@ (sub a 65)) (shim 'A' 'Z'))
        (cook |=(a=@ (sub a 71)) (shim 'a' 'z'))
        (cook |=(a=@ (add a 4)) (shim '0' '9'))
        (cold 62 (just '-'))
        (cold 63 (just '+'))
      ==
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eI, parsing (external)       ::
    ::
    ++  rash  |*([naf=@ sab=_rule] (scan (trip naf) sab))
    ++  rush  |*  [naf=@ sab=_rule]
              =+  vex=((full sab) [[1 1] (trip naf)])
              ?~(q.vex ~ [~ u=p.u.q.vex])
    ++  scan  |*  [los=tape sab=_rule]
              =+  vex=((full sab) [[1 1] los])
              ?@  q.vex
                <!--  -->
                ~|('syntax-error' !!)
              p.u.q.vex
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eJ, formatting (basic text)  ::
    ::
    ++  cass                                                ::  case-insensitive
      |=  vib=tape
      %+  rap  3
      (turn vib |=(a=@ ?.(&((gte a 'A') (lte a 'Z')) a (add 32 a))))
    ::
    ++  crip  |=(a=tape `@t`(rap 3 a))
    ++  mesc
      |=  vib=tape
      ^-  tape
      ?@  vib
        ~
      ?:  =('\\' i.vib)
        ['\\' '\\' $(vib t.vib)]
      ?:  ?|((gth i.vib 126) (lth i.vib 32) =(39 i.vib))
        ['\\' (weld ~(rux at i.vib) (runt [1 47] $(vib t.vib)))]
      [i.vib $(vib t.vib)]
    ::
    ++  runt
      |=  [[a=@ b=@] c=tape]
      ^-  tape
      ?:  =(0 a)
        c
      [b $(a (dec a))]
    ::
    ++  sand                                                ::  atom sanity
      |=  a=@ta
      |=  b=@  ^-  (unit ,@)
      ?.(((sane a) b) ~ [~ b])
    ::
    ++  sane                                                ::  atom sanity
      |=  a=@ta
      |=  b=@  ^-  ?
      ?.  =(%t (end 3 1 a))
        ~|(%sane-stub !!)
      =+  [inx=0 len=(met 3 b)]
      ?:  =(%tas a)
        |-  ^-  ?
        ?:  =(inx len)  &
        =+  cur=(cut 3 [inx 1] b)
        ?&  ?|  &((gte cur 'a') (lte cur 'z'))
                &(=('-' cur) !=(0 inx) !=(len inx))
            ==
            $(inx +(inx))
        ==
      ?:  =(%ta a)
        |-  ^-  ?
        ?:  =(inx len)  &
        =+  cur=(cut 3 [inx 1] b)
        ?&  ?|  &((gte cur 'a') (lte cur 'z'))
                &((gte cur 'A') (lte cur 'Z'))
                |(=('-' cur) =('~' cur) =('_' cur) =('.' cur))
            ==
            $(inx +(inx))
        ==
      |-  ^-  ?
      ?:  =(0 b)  &
      =+  cur=(end 3 1 b)
      ?:  &((lth cur 32) !=(10 cur))  |
      =+  len=(teff cur)
      ?&  |(=(1 len) =+(i=1 |-(|(=(i len) &((gte (cut 3 [i 1] b) 128) $(i +(i)))))))
          $(b (rsh 3 len b))
      ==
    ::
    ++  trim
      |=  [a=@ b=tape]
      ^-  [p=tape q=tape]
      ?@  b
        [~ ~]
      ?:  =(0 a)
        [~ b]
      =+  c=$(a (dec a), b t.b)
      [[i.b p.c] q.c]
    ::
    ++  trip
      ~/  %trip
      |=  a=@  ^-  tape
      ?:  =(0 (met 3 a))
        ~
      [^-(@ta (end 3 1 a)) $(a (rsh 3 1 a))]
    ::
    ++  teff                                                ::  length utf8
      |=  a=@t  ^-  @
      =+  b=(end 3 1 a)
      ?:  =(0 b)
        ?>(=(0 a) 0)
      ?>  |((gte b 32) =(10 b))
      ?:((lte b 127) 1 ?:((lte b 223) 2 ?:((lte b 239) 3 4)))
    ::
    ++  turf                                                ::  utf8 to utf32
      |=  a=@t
      ^-  @c
      %+  rap  5
      |-  ^-  (list ,@c)
      =+  b=(teff a)
      ?:  =(0 b)  ~
      :-  %+  can  0
          %+  turn
            ^-  (list ,[p=@ q=@])
            ?+  b  !!
              1  [[0 7] ~]
              2  [[8 6] [0 5] ~]
              3  [[16 6] [8 6] [0 4] ~]
              4  [[24 6] [16 6] [8 6] [0 3] ~]
            ==
          |=([p=@ q=@] [q (cut 0 [p q] a)])
      $(a (rsh 3 b a))
    ::
    ++  tuba                                                ::  utf8 to utf32 tape
      |=  a=tape
      ^-  (list ,@c)
      (rip 5 (turf (rap 3 a)))                              ::  XX horrible
    ::
    ++  tufa                                                ::  utf32 to utf8 tape
      |=  a=(list ,@c)
      ^-  tape
      ?~  a  ""
      (weld (rip 3 (tuft i.a)) $(a t.a))
    ::
    ++  tuft                                                ::  utf32 to utf8 text
      |=  a=@c
      ^-  @t
      %+  rap  3
      |-  ^-  (list ,@)
      ?:  =(0 a)
        ~
      =+  b=(end 5 1 a)
      =+  c=$(a (rsh 5 1 a))
      ?:  (lth b 0x7f)
        [b c]
      ?:  (lth b 0x7ff)
        :*  (mix 0b1100.0000 (cut 0 [6 5] b))
            (mix 0b1000.0000 (end 0 6 b))
            c
        ==
      ?:  (lth b 0xffff)
        :*  (mix 0b1110.0000 (cut 0 [12 4] b))
            (mix 0b1000.0000 (cut 0 [6 6] b))
            (mix 0b1000.0000 (end 0 6 b))
            c
        ==
      :*  (mix 0b1111.0000 (cut 0 [18 3] b))
          (mix 0b1000.0000 (cut 0 [12 6] b))
          (mix 0b1000.0000 (cut 0 [6 6] b))
          (mix 0b1000.0000 (end 0 6 b))
          c
      ==
    ::
    ++  wack
      |=  a=@ta
      ^-  @ta
      =+  b=(rip 3 a)
      %+  rap  3
      |-  ^-  tape
      ?~  b
        ~
      ?:  =('~' i.b)  ['~' '~' $(b t.b)]
      ?:  =('_' i.b)  ['~' '-' $(b t.b)]
      [i.b $(b t.b)]
    ::
    ++  wick
      |=  a=@
      ^-  @ta
      =+  b=(rip 3 a)
      %+  rap  3
      |-  ^-  tape
      ?~  b
        ~
      ?:  =('~' i.b)
        ?~  t.b  !!
        [?:(=('~' i.t.b) '~' ?>(=('-' i.t.b) '_')) $(b t.t.b)]
      [i.b $(b t.b)]
    ::
    ++  woad
      |=  a=@ta
      ^-  @t
      %+  rap  3
      |-  ^-  (list ,@)
      ?:  =(0 a)
        ~
      =+  b=(end 3 1 a)
      =+  c=(rsh 3 1 a)
      ?:  =('.' b)
        [' ' $(a c)]
      ?.  =('~' b)
        [b $(a c)]
      =>  .(b (end 3 1 c), c (rsh 3 1 c))
      ?+  b  =-  (weld (rip 3 (tuft p.d)) $(a q.d))
             ^=  d
             =+  d=0
             |-  ^-  [p=@ q=@]
             ?:  =('.' b)
               [d c]
             ?<  =(0 c)
             %=    $
                b  (end 3 1 c)
                c  (rsh 3 1 c)
                d  %+  add  (mul 16 d)
                   %+  sub  b
                   ?:  &((gte b '0') (lte b '9'))  48
                   ?>(&((gte b 'a') (lte b 'z')) 87)
             ==
        %'.'  ['.' $(a c)]
        %'~'  ['~' $(a c)]
      ==
    ::
    ++  wood
      |=  a=@t
      ^-  @ta
      %+  rap  3
      |-  ^-  (list ,@)
      ?:  =(0 a)
        ~
      =+  b=(teff a)
      =+  c=(turf (end 3 b a))
      =+  d=$(a (rsh 3 b a))
      ?:  ?|  &((gte c 'a') (lte c 'z'))
              &((gte c '0') (lte c '9'))
              =('-' c)
          ==
        [c d]
      ?+  c  
        :-  '~'
        =+  e=(met 2 c)
        |-  ^-  tape
        ?:  =(0 c)
          ['.' d]
        =.  e  (dec e)
        =+  f=(rsh 2 e c)
        [(add ?:((lte f 9) 48 87) f) $(c (end 2 e c))]
      ::
        %' '  ['.' d]
        %'.'  ['~' '.' d]
        %'~'  ['~' '~' d]
      ==
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eK, formatting (layout)      ::
    ::
    ++  re
      |_  tac=tank
      ++  ram
        ^-  tape
        ?-    -.tac
            %leaf  p.tac
            %palm  ram(tac [%rose [p.p.tac (weld q.p.tac r.p.tac) s.p.tac] q.tac])
            %rose
          %+  weld
            q.p.tac
          |-  ^-  tape
          ?@  q.tac
            r.p.tac
          =+  voz=$(q.tac t.q.tac)
          (weld ram(tac i.q.tac) ?@(t.q.tac voz (weld p.p.tac voz)))
        ==
      ::
      ++  win
        |=  [tab=@ edg=@]
        =+  lug=`wall`~
        |^  |-  ^-  wall
            ?-    -.tac
                %leaf  (rig p.tac)
                %palm
              ?:  fit
                (rig ram)
              ?@  q.tac
                (rig q.p.tac)
              ?@  t.q.tac
                (rig(tab (add 2 tab), lug $(tac i.q.tac)) q.p.tac)
              =>  .(q.tac `(list tank)`q.tac)
              =+  lyn=(mul 2 (lent q.tac))
              =+  ^=  qyr
                  |-  ^-  wall
                  ?@  q.tac
                    lug
                  %=  ^$
                    tac  i.q.tac
                    tab  (add tab (sub lyn 2))
                    lug  $(q.tac t.q.tac, lyn (sub lyn 2))
                  ==
              (wig(lug qyr) q.p.tac)
            ::
                %rose
              ?:  fit
                (rig ram)
              =+  ^=  gyl
                |-  ^-  wall
                ?@  q.tac
                  ?:(=(%$ r.p.tac) lug (rig r.p.tac))
                ^$(tac i.q.tac, lug $(q.tac t.q.tac), tab din)
              ?:  =(%$ q.p.tac)
                gyl
              (wig(lug gyl) q.p.tac)
            ==
        ::
        ++  din  (mod (add 2 tab) (mul 2 (div edg 3)))
        ++  fit  (lte (lent ram) (sub edg tab))
        ++  rig
          |=  hom=tape
          ^-  wall
          ?:  (lte (lent hom) (sub edg tab))
            [(runt [tab ' '] hom) lug]
          =>  .(tab (add tab 2), edg (sub edg 2))
          =+  mut=(trim (sub edg tab) hom)
          :-  (runt [(sub tab 2) ' '] ['\\' '/' (weld p.mut `_hom`['\\' '/' ~])])
          =>  .(hom q.mut)
          |-
          ?@  hom
            :-  %+  runt
                  [(sub tab 2) ' ']
                ['\\' '/' (runt [(sub edg tab) ' '] ['\\' '/' ~])]
            lug
          =>  .(mut (trim (sub edg tab) hom))
          [(runt [tab ' '] p.mut) $(hom q.mut)]
        ::
        ++  wig
          |=  hom=tape
          ^-  wall
          ?@  lug
            (rig hom)
          =+  lin=(lent hom)
          =+  wug=:(add 1 tab lin)
          ?.  =+  mir=i.lug
              |-  ?@  mir
                    |
                  ?|(=(0 wug) ?&(=(' ' i.mir) $(mir t.mir, wug (dec wug))))
            (rig hom)
          [(runt [tab ' '] (weld hom `tape`[' ' (slag wug i.lug)])) t.lug]
        --
      --
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eL, formatting (path)        ::
    ::
    ++  ab
      |%
      ++  bix  (bass 16 (stun [2 2] six))
      ++  hif  (boss 256 ;~(plug tip tiq (easy ~)))
      ++  huf  %+  cook
                 |=([a=@ b=@] (wred:un ~(zug mu ~(zag mu [a b]))))
               ;~(plug hif ;~(pfix hep hif))
      ++  hyf  (bass 0x1.0000.0000 ;~(plug huf ;~(pfix hep huf) (easy ~)))
      ++  pev  (bass 32 ;~(plug sev (stun [0 4] siv)))
      ++  pew  (bass 64 ;~(plug sew (stun [0 4] siw)))
      ++  piv  (bass 32 (stun [5 5] siv))
      ++  piw  (bass 64 (stun [5 5] siw))
      ++  qeb  (bass 2 ;~(plug seb (stun [0 3] sib)))
      ++  qex  (bass 16 ;~(plug sex (stun [0 3] hit)))
      ++  qib  (bass 2 (stun [4 4] sib))
      ++  qix  (bass 16 (stun [4 4] six))
      ++  seb  (cold 1 (just '1'))
      ++  sed  (cook |=(a=@ (sub a '0')) (shim '1' '9'))
      ++  sev  ;~(pose sed sov)
      ++  sew  ;~(pose sed sow)
      ++  sex  ;~(pose sed sox)
      ++  sib  (cook |=(a=@ (sub a '0')) (shim '0' '1'))
      ++  siq  ;~  pose
                 (shim 'a' 'z')
                 (shim 'A' 'Z')
                 (shim '0' '9')
                 hep
                 (cold 32 dot)
                 ;~(pfix sig ;~(pose sig dot bix))
               ==
      ++  sid  (cook |=(a=@ (sub a '0')) (shim '0' '9'))
      ++  siv  ;~(pose sid sov)
      ++  siw  ;~(pose sid sow)
      ++  six  ;~(pose sid sox)
      ++  sov  (cook |=(a=@ (sub a 87)) (shim 'a' 'v'))
      ++  sow  ;~  pose
                 (cook |=(a=@ (sub a 87)) (shim 'a' 'z'))
                 (cook |=(a=@ (sub a 29)) (shim 'A' 'Z'))
                 (cold 62 (just '-'))
                 (cold 63 (just '~'))
               ==
      ++  sox  (cook |=(a=@ (sub a 87)) (shim 'a' 'f'))
      ++  ted  (bass 10 ;~(plug sed (stun [0 2] sid)))
      ++  tip  (sear |=(a=@ (ins:po a)) til)
      ++  tiq  (sear |=(a=@ (ind:po a)) til)
      ++  tid  (bass 10 (stun [3 3] sid))
      ++  til  (boss 256 (stun [3 3] low))
      ++  urs  %+  cook
                 |=(a=tape (rap 3 ^-((list ,@) a)))
               (star ;~(pose nud low hep dot sig cab)) 
      ++  voy  ;~(pfix bas ;~(pose bas soq bix))
      ++  vym  (bass 256 ;~(plug low (star ;~(pose low nud))))
      ++  vyn  (bass 256 ;~(plug hep vym (easy ~)))
      --
    ++  ag
      |%
      ++  ape  |*(fel=_rule ;~(pose (cold 0 (just '0')) fel))
      ++  bay  (ape (bass 16 ;~(plug qeb:ab (star ;~(pfix dog qib:ab)))))
      ++  bip  =+  tod=(ape qex:ab)
               (bass 0x1.0000 ;~(plug tod (stun [7 7] ;~(pfix dog tod))))
      ++  dem  (ape (bass 1.000 ;~(plug ted:ab (star ;~(pfix dog tid:ab)))))
      ++  dim  (ape (bass 10 ;~(plug sed:ab (star sid:ab))))
      ++  dum  (bass 10 (plus sid:ab))
      ++  fed  ;~  pose
                 (bass 0x1.0000.0000.0000.0000 (most doh hyf:ab))
                 huf:ab
                 hif:ab
                 tiq:ab
               ==
      ++  hex  (ape (bass 0x1.0000 ;~(plug qex:ab (star ;~(pfix dog qix:ab)))))
      ++  lip  =+  tod=(ape ted:ab)
               (bass 256 ;~(plug tod (stun [3 3] ;~(pfix dog tod))))
      ++  qut  %+  ifix  [soq soq]
               %+  boss  256
               %-  star  ;~  pose
                           ;~(pfix bas ;~(pose bas soq bix:ab))
                           ;~(pose (shim 32 38) (shim 40 91) (shim 93 126))
                         ==
      ++  sym  (cook |=(a=(list ,@) (rap 3 a)) ;~(plug vym:ab (star vyn:ab)))
      ++  tyq  (cook |=(a=(list ,@) (rap 3 a)) (plus siq:ab))
      ++  viz  (ape (bass 0x200.0000 ;~(plug pev:ab (star ;~(pfix dog piv:ab)))))
      ++  wiz  (ape (bass 0x4000.0000 ;~(plug pew:ab (star ;~(pfix dog piw:ab)))))
      --
    ::
    ++  co
      =<  |_  lot=coin
          ++  rear  |=(rom=tape =>(.(rex rom) rend))
          ++  rent  `@ta`(rap 3 rend)
          ++  rend
            ^-  tape
            ?:  ?=(%blob -.lot)
              ['~' '0' ((w-co 1) (jam p.lot))]
            ?:  ?=(%many -.lot)
              :-  '.'
              |-  ^-  tape
              ?~   p.lot
                ['_' '_' rex]
              ['_' rend(lot i.p.lot, rex $(p.lot t.p.lot))]
            =+  [yed=(end 3 1 p.p.lot) hay=(cut 3 [1 1] p.p.lot)]
            |-  ^-  tape
            ?+    yed  (z-co q.p.lot)
                %c   ['~' '-' (weld (rip 3 (wood (tuft q.p.lot))) rex)]
                %d
              ?+    hay  (z-co q.p.lot)
                  %a
                =+  yod=(yore q.p.lot)
                =>  ^+(. .(rex ?~(f.t.yod rex ['.' (s-co f.t.yod)])))
                =>  ^+  .
                    %=    .
                        rex
                      ?:  &(=(~ f.t.yod) =(0 h.t.yod) =(0 m.t.yod) =(0 s.t.yod))
                        rex
                      =>  .(rex ['.' (y-co s.t.yod)])
                      =>  .(rex ['.' (y-co m.t.yod)])
                      ['.' '.' (y-co h.t.yod)]
                    ==
                =>  .(rex ['.' (a-co d.t.yod)])
                =>  .(rex ['.' (a-co m.yod)])
                =>  .(rex ?:(a.yod rex ['-' rex]))
                ['~' (a-co y.yod)]
              ::
                  %r
                =+  yug=(yell q.p.lot)
                =>  ^+(. .(rex ?~(f.yug rex ['.' (s-co f.yug)])))
                :-  '~'
                ?:  &(=(0 d.yug) =(0 m.yug) =(0 h.yug) =(0 s.yug))
                  ['.' 's' '0' rex]
                =>  ^+(. ?:(=(0 s.yug) . .(rex ['.' 's' (a-co s.yug)])))
                =>  ^+(. ?:(=(0 m.yug) . .(rex ['.' 'm' (a-co m.yug)])))
                =>  ^+(. ?:(=(0 h.yug) . .(rex ['.' 'h' (a-co h.yug)])))
                =>  ^+(. ?:(=(0 d.yug) . .(rex ['.' 'd' (a-co d.yug)])))
                +.rex
              ==
            ::
                %f
              ?:  =(& q.p.lot)
                ['.' 'y' rex]
              ?:(=(| q.p.lot) ['.' 'n' rex] (z-co q.p.lot))
            ::
                %n   ['~' rex]
                %i
              ?+  hay  (z-co q.p.lot)
                %f  ((ro-co [3 10 4] |=(a=@ ~(d ne a))) q.p.lot)
                %s  ((ro-co [4 16 8] |=(a=@ ~(x ne a))) q.p.lot)
              ==
            ::
                %p
              =+  dyx=(met 3 q.p.lot)
              :-  '~'
              ?:  (lte dyx 1)
                (weld (trip (tod:po q.p.lot)) rex)
              ?:  =(2 dyx)
                ;:  weld
                  (trip (tos:po (end 3 1 q.p.lot)))
                  (trip (tod:po (rsh 3 1 q.p.lot)))
                  rex
                ==
              =+  [dyz=(met 5 q.p.lot) fin=|]
              |-  ^-  tape
              ?:  =(0 dyz)
                rex
              %=    $
                  fin      &
                  dyz      (dec dyz)
                  q.p.lot  (rsh 5 1 q.p.lot)
                  rex
                =+  syb=(wren:un (end 5 1 q.p.lot))
                =+  cog=~(zig mu [(rsh 4 1 syb) (end 4 1 syb)])
                ;:  weld
                  (trip (tos:po (end 3 1 p.cog)))
                  (trip (tod:po (rsh 3 1 p.cog)))
                  `tape`['-' ~]
                  (trip (tos:po (end 3 1 q.cog)))
                  (trip (tod:po (rsh 3 1 q.cog)))
                  `tape`?:(fin ['-' ?:(=(1 (end 0 1 dyz)) ~ ['-' ~])] ~)
                  rex
                ==
              ==
            ::
                %r
              ?+  hay  (z-co q.p.lot)
                %d  ['.' '~' (r-co (rlyd q.p.lot))]
                %h  ['.' '~' '~' (r-co (rlyh q.p.lot))]
                %q  ['.' '~' '~' '~' (r-co (rlyq q.p.lot))]
                %s  ['.' (r-co (rlys q.p.lot))]
              ==
            ::
                %u
              =-  (weld p.gam ?:(=(0 q.p.lot) `tape`['0' ~] q.gam))
              ^=  gam  ^-  [p=tape q=tape]
              ?+  hay  [~ ((ox-co [10 3] |=(a=@ ~(d ne a))) q.p.lot)]
                %b  [['0' 'b' ~] ((ox-co [2 4] |=(a=@ ~(d ne a))) q.p.lot)]
                %x  [['0' 'x' ~] ((ox-co [16 4] |=(a=@ ~(x ne a))) q.p.lot)]
                %v  [['0' 'v' ~] ((ox-co [32 5] |=(a=@ ~(x ne a))) q.p.lot)]
                %w  [['0' 'w' ~] ((ox-co [64 5] |=(a=@ ~(w ne a))) q.p.lot)]
              ==
            ::
                %s
              %+  weld
                ?:((syn:si q.p.lot) "--" "-")
              $(yed 'u', q.p.lot (abs:si q.p.lot))
            ::
                %t
              ?:  =('a' hay)
                ?:  =('s' (cut 3 [2 1] p.p.lot))
                  (weld (rip 3 q.p.lot) rex)
                ['~' '.' (weld (rip 3 (wack q.p.lot)) rex)]
              ['~' '~' (weld (rip 3 (wood q.p.lot)) rex)]
            ==
          --
      =+  rex=*tape
      =<  |%
          ++  a-co  |=(dat=@ ((d-co 1) dat))
          ++  d-co  |=(min=@ (em-co [10 min] |=([? b=@ c=tape] [~(d ne b) c])))
          ++  r-co
            |=  [syn=? nub=@ der=@]
            =>  .(rex ['.' ((d-co 1) der)])
            =>  .(rex ((d-co 1) nub))
            ?:(syn rex ['-' rex])
          ::
          ++  s-co
            |=  esc=(list ,@)  ^-  tape
            ~|  [%so-co esc]
            ?~  esc
              rex
            :-  '.'
            =>(.(rex $(esc t.esc)) ((x-co 4) i.esc))
        ::
          ++  w-co  |=(min=@ (em-co [64 min] |=([? b=@ c=tape] [~(w ne b) c])))
          ++  x-co  |=(min=@ (em-co [16 min] |=([? b=@ c=tape] [~(x ne b) c])))
          ++  y-co  |=(dat=@ ((d-co 2) dat))
          ++  z-co  |=(dat=@ `tape`['0' 'x' ((x-co 1) dat)])
          --
      |%
      ++  em-co
        |=  [[bas=@ min=@] [par=$+([? @ tape] tape)]]
        |=  hol=@
        ^-  tape
        ?:  &(=(0 hol) =(0 min))
          rex
        =+  [rad=(mod hol bas) dar=(div hol bas)]
        %=  $
          min  ?:(=(0 min) 0 (dec min))
          hol  dar
          rex  (par =(0 dar) rad rex)
        ==
      ::
      ++  ox-co
        |=  [[bas=@ gop=@] dug=$+(@ @)]
        %+  em-co
          [|-(?:(=(0 gop) 1 (mul bas $(gop (dec gop))))) 0]
        |=  [top=? seg=@ res=tape]
        %+  weld
          ?:(top ~ `tape`['.' ~])
        %.  seg
        %+  em-co(rex res)
          [bas ?:(top 0 gop)]
        |=([? b=@ c=tape] [(dug b) c])
      ::
      ++  ro-co
        |=  [[buz=@ bas=@ dop=@] dug=$+(@ @)]
        |=  hol=@
        ^-  tape
        ?:  =(0 dop)
          rex
        =>  .(rex $(dop (dec dop)))
        :-  '.'
        %-  (em-co [bas 1] |=([? b=@ c=tape] [(dug b) c]))
        [(cut buz [(dec dop) 1] hol)]
      --
    ::
    ++  ne
      |_  tig=@
      ++  d  (add tig '0')
      ++  x  ?:((gte tig 10) (add tig 87) d)
      ++  w  ?:(=(tig 63) '~' ?:(=(tig 62) '-' ?:((gte tig 36) (add tig 29) x)))
      --
    ::
    ++  mu
      |_  [top=@ bot=@]
      ++  zag  [p=(end 4 1 (add top bot)) q=bot]
      ++  zig  [p=(end 4 1 (add top (sub 0x1.0000 bot))) q=bot]
      ++  zug  (mix (lsh 4 1 top) bot)
      --
    ::
    ++  so
      |%
      ++  bisk
        ;~  pose
          ;~  pfix  (just '0')
            ;~  pose
              (stag %ub ;~(pfix (just 'b') bay:ag))
              (stag %ux ;~(pfix (just 'x') hex:ag))
              (stag %uv ;~(pfix (just 'v') viz:ag))
              (stag %uw ;~(pfix (just 'w') wiz:ag))
            ==
          ==
          (stag %ud dem:ag)
        ==
      ++  crub
        ;~  pose
          %+  cook
            |=(det=date `dime`[%da (year det)])
          ;~  plug
            %+  cook
              |=([a=@ b=?] [b a])
            ;~(plug dim:ag ;~(pose (cold | hep) (easy &)))
            ;~(pfix dot dim:ag)   ::  month
            ;~(pfix dot dim:ag)   ::  day
            ;~  pose
              ;~  pfix
                ;~(plug dot dot)
                ;~  plug
                  dum:ag
                  ;~(pfix dot dum:ag)
                  ;~(pfix dot dum:ag)
                  ;~(pose ;~(pfix ;~(plug dot dot) (most dot qix:ab)) (easy ~))
                ==
              ==
              (easy [0 0 0 ~])
            ==
          ==
        ::
          %+  cook
            |=  [a=(list ,[p=?(%d %h %m %s) q=@]) b=(list ,@)]
            =+  rop=`tarp`[0 0 0 0 b]
            |-  ^-  dime
            ?~  a
              [%dr (yule rop)]
            ?-  p.i.a
              %d  $(a t.a, d.rop (add q.i.a d.rop))
              %h  $(a t.a, h.rop (add q.i.a h.rop))
              %m  $(a t.a, m.rop (add q.i.a m.rop))
              %s  $(a t.a, s.rop (add q.i.a s.rop))
            ==
          ;~  plug
            %+  most
              dot
            ;~  pose
              ;~(pfix (just 'd') (stag %d dim:ag))
              ;~(pfix (just 'h') (stag %h dim:ag))
              ;~(pfix (just 'm') (stag %m dim:ag))
              ;~(pfix (just 's') (stag %s dim:ag))
            ==
            ;~(pose ;~(pfix ;~(plug dot dot) (most dot qix:ab)) (easy ~))
          ==
        ::
          (stag %p fed:ag)
          ;~(pfix dot (stag %ta (cook wick urs:ab)))
          ;~(pfix sig (stag %t (cook woad urs:ab)))
          ;~(pfix hep (stag %c (cook turf (cook woad urs:ab))))
        ==
      ++  nuck
        %+  knee  *coin  |.  ~+
        %-  stew  
        ^.  stet  ^.  limo
        :~  :-  ['a' 'z']  (cook |=(a=@ta [~ %tas a]) sym)
            :-  ['0' '9']  (stag ~ bisk)
            :-  '-'        (stag ~ tash)
            :-  '.'        ;~(pfix dot perd)
            :-  '~'        ;~(pfix sig ;~(pose twid (easy [~ %n 0])))
        ==
      ++  perd
        ;~  pose
          (stag ~ zust)
          (stag %many (ifix [cab ;~(plug cab cab)] (more cab nuck)))
        ==
      ++  royl
        =+  ^=  vox
            ;~  plug
              ;~(pose (cold | hep) (easy &))
              ;~(plug dim:ag ;~(pose ;~(pfix dot dim:ag) (easy 0)))
            ==
        ;~  pose
          (stag %rh (cook rylh ;~(pfix ;~(plug sig sig) vox)))
          (stag %rq (cook rylq ;~(pfix ;~(plug sig sig sig) vox)))
          (stag %rd (cook ryld ;~(pfix sig vox)))
          (stag %rs (cook ryls vox))
        ==
      ++  tash
        =+  ^=  neg
            |=  [syn=? mol=dime]  ^-  dime
            ?>  =('u' (end 3 1 p.mol))
            [(cat 3 's' (rsh 3 1 p.mol)) (new:si syn q.mol)]
        ;~  pfix  hep
          ;~  pose
            (cook |=(a=dime (neg | a)) bisk)
            ;~(pfix hep (cook |=(a=dime (neg & a)) bisk))
          ==
        ==
      ++  twid
        ;~  pose
          (cook |=(a=@ [%blob (cue a)]) ;~(pfix (just '0') wiz:ag))
          (stag ~ crub)
        ==
      ::
      ++  zust
        ;~  pose
          (stag %is bip:ag)
          (stag %if lip:ag)
          (stag %f ;~(pose (cold & (just 'y')) (cold | (just 'n'))))
          royl
        ==
      --
    ++  scot  |=(mol=dime ~(rent co %$ mol))
    ++  scow  |=(mol=dime ~(rend co %$ mol))
    ++  slaw
      |=  [mod=@tas txt=@ta]
      ^-  (unit ,@)
      =+  con=(slay txt)
      ?.(&(?=([~ %$ @ @] con) =(p.p.u.con mod)) ~ [~ q.p.u.con])
    ::
    ++  slay
      |=  txt=@ta  ^-  (unit coin)
      =+  vex=((full nuck:so) [[1 1] (trip txt)])
      ?@  q.vex
        ~
      [~ p.u.q.vex]
    ::
    ++  smyt
      |=  bon=path  ^-  tank
      :+  %rose  [['/' ~] ['/' ~] ['/' ~]]
      |-  ^-  (list tank)
      (turn bon |=(a=@ [%leaf (rip 3 a)]))
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eM, pseudo-cryptography      ::
    ::
    ++  un                                                  ::  =(x (wred (wren x)))
      |%
      ++  wren                                              ::  conceal structure
        |=  pyn=@  ^-  @
        =+  len=(met 3 pyn)
        ?:  =(0 len)
          0
        =>  .(len (dec len))
        =+  mig=(zaft (xafo len (cut 3 [len 1] pyn)))
        %+  can  3
        %-  flop  ^-  (list ,[@ @])
        :-  [1 mig]
        |-  ^-  (list ,[@ @])
        ?:  =(0 len)
          ~
        =>  .(len (dec len))
        =+  mog=(zyft :(mix mig (end 3 1 len) (cut 3 [len 1] pyn)))
        [[1 mog] $(mig mog)]
      ::
      ++  wred                                              ::  restore structure
        |=  cry=@  ^-  @
        =+  len=(met 3 cry)
        ?:  =(0 len)
          0
        =>  .(len (dec len))
        =+  mig=(cut 3 [len 1] cry)
        %+  can  3
        %-  flop  ^-  (list ,[@ @])
        :-  [1 (xaro len (zart mig))]
        |-  ^-  (list ,[@ @])
        ?:  =(0 len)
          ~
        =>  .(len (dec len))
        =+  mog=(cut 3 [len 1] cry)
        [[1 :(mix mig (end 3 1 len) (zyrt mog))] $(mig mog)]
      ::
      ++  xafo  |=([a=@ b=@] +((mod (add (dec b) a) 255)))
      ++  xaro  |=([a=@ b=@] +((mod (add (dec b) (sub 255 (mod a 255))) 255)))
      ::
      ++  zaft                                              ::  forward 255-sbox
        |=  a=@
        =+  ^=  b
            0xcc.75bc.86c8.2fb1.9a42.f0b3.79a0.92ca.21f6.1e41.cde5.fcc0.
            7e85.51ae.1005.c72d.1246.07e8.7c64.a914.8d69.d9f4.59c2.8038.
            1f4a.dca2.6fdf.66f9.f561.a12e.5a16.f7b0.a39f.364e.cb70.7318.
            1de1.ad31.63d1.abd4.db68.6a33.134d.a760.edee.5434.493a.e323.
            930d.8f3d.3562.bb81.0b24.43cf.bea5.a6eb.52b4.0229.06b2.6704.
            78c9.45ec.d75e.58af.c577.b7b9.c40e.017d.90c3.87f8.96fa.1153.
            0372.7f30.1c32.ac83.ff17.c6e4.d36d.6b55.e2ce.8c71.8a5b.b6f3.
            9d4b.eab5.8b3c.e7f2.a8fe.9574.5de0.bf20.3f15.9784.9939.5f9c.
            e609.564f.d8a4.b825.9819.94aa.2c08.8e4c.9b22.477a.2840.3ed6.
            3750.6ef1.44dd.89ef.6576.d00a.fbda.9ed2.3b6c.7b0c.bde9.2ade.
            5c88.c182.481a.1b0f.2bfd.d591.2726.57ba
        (cut 3 [(dec a) 1] b)
      ::
      ++  zart                                              ::  reverse 255-sbox
        |=  a=@
        =+  ^=  b
            0x68.4f07.ea1c.73c9.75c2.efc8.d559.5125.f621.a7a8.8591.5613.
            dd52.40eb.65a2.60b7.4bcb.1123.ceb0.1bd6.3c84.2906.b164.19b3.
            1e95.5fec.ffbc.f187.fbe2.6680.7c77.d30e.e94a.9414.fd9a.017d.
            3a7e.5a55.8ff5.8bf9.c181.e5b6.6ab2.35da.50aa.9293.3bc0.cdc6.
            f3bf.1a58.4130.f844.3846.744e.36a0.f205.789e.32d8.5e54.5c22.
            0f76.fce7.4569.0d99.d26e.e879.dc16.2df4.887f.1ffe.4dba.6f5d.
            bbcc.2663.1762.aed7.af8a.ca20.dbb4.9bc7.a942.834c.105b.c4d4.
            8202.3e61.a671.90e6.273d.bdab.3157.cfa4.0c2e.df86.2496.f7ed.
            2b48.2a9d.5318.a343.d128.be9c.a5ad.6bb5.6dfa.c5e1.3408.128d.
            2c04.0339.97a1.2ff0.49d0.eeb8.6c0a.0b37.b967.c347.d9ac.e072.
            e409.7b9f.1598.1d3f.33de.8ce3.8970.8e7a
        (cut 3 [(dec a) 1] b)
      ::
      ++  zyft                                              ::  forward 256-sbox
        |=  a=@
        =+  ^=  b
            0xbb49.b71f.b881.b402.17e4.6b86.69b5.1647.115f.dddb.7ca5.
              8371.4bd5.19a9.b092.605d.0d9b.e030.a0cc.78ba.5706.4d2d.
              986a.768c.f8e8.c4c7.2f1c.effe.3cae.01c0.253e.65d3.3872.
              ce0e.7a74.8ac6.daac.7e5c.6479.44ec.4143.3d20.4af0.ee6c.
              c828.deca.0377.249f.ffcd.7b4f.eb7d.66f2.8951.042e.595a.
              8e13.f9c3.a79a.f788.6199.9391.7fab.6200.4ce5.0758.e2f1.
              7594.c945.d218.4248.afa1.e61a.54fb.1482.bea4.96a2.3473.
              63c2.e7cb.155b.120a.4ed7.bfd8.b31b.4008.f329.fca3.5380.
              9556.0cb2.8722.2bea.e96e.3ac5.d1bc.10e3.2c52.a62a.b1d6.
              35aa.d05e.f6a8.0f3b.31ed.559d.09ad.f585.6d21.fd1d.8d67.
              370b.26f4.70c1.b923.4684.6fbd.cf8b.5036.0539.9cdc.d93f.
              9068.1edf.8f33.b632.d427.97fa.9ee1
        (cut 3 [a 1] b)
      ::
      ++  zyrt                                              ::  reverse 256-sbox
        |=  a=@
        =+  ^=  b
            0x9fc8.2753.6e02.8fcf.8b35.2b20.5598.7caa.c9a9.30b0.9b48.
              47ce.6371.80f6.407d.00dd.0aa5.ed10.ecb7.0f5a.5c3a.e605.
              c077.4337.17bd.9eda.62a4.79a7.ccb8.44cd.8e64.1ec4.5b6b.
              1842.ffd8.1dfb.fd07.f2f9.594c.3be3.73c6.2cb6.8438.e434.
              8d3d.ea6a.5268.72db.a001.2e11.de8c.88d3.0369.4f7a.87e2.
              860d.0991.25d0.16b9.978a.4bf4.2a1a.e96c.fa50.85b5.9aeb.
              9dbb.b2d9.a2d1.7bba.66be.e81f.1946.29a8.f5d2.f30c.2499.
              c1b3.6583.89e1.ee36.e0b4.6092.937e.d74e.2f6f.513e.9615.
              9c5d.d581.e7ab.fe74.f01b.78b1.ae75.af57.0ec2.adc7.3245.
              12bf.2314.3967.0806.31dc.cb94.d43f.493c.54a6.0421.c3a1.
              1c4a.28ac.fc0b.26ca.5870.e576.f7f1.616d.905f.ef41.33bc.
              df4d.225e.2d56.7fd6.1395.a3f8.c582
        (cut 3 [a 1] b)
      --
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eN, virtualization           ::
    ::
    ++  mack
      |=  [sub=* fol=*]
      ^-  (unit)
      =+  ton=(mink [sub fol] |=(* ~))
      ?.(?=([0 *] ton) ~ [~ p.ton])
    ::
    ++  mink
      ~/  %mink
      |=  [[sub=* fol=*] sky=$+(* (unit))]
      =+  tax=*(list ,[@ta *])
      |-  ^-  tone
      ?@  fol
        [%2 tax]
      ?:  ?=(^ -.fol)
        =+  hed=$(fol -.fol)
        ?:  ?=(2 -.hed)
          hed
        =+  tal=$(fol +.fol)
        ?-  -.tal
          0  ?-(-.hed 0 [%0 p.hed p.tal], 1 hed)
          1  ?-(-.hed 0 tal, 1 [%1 (weld p.hed p.tal)])
          2  tal
        ==
      ?-    fol
      ::
          [0 b=@]
        ?:  =(0 b.fol)  [%2 tax]
        ?:  =(1 b.fol)  [%0 sub]
        ?:  ?=(@ sub)   [%2 tax]
        =+  [now=(cap b.fol) lat=(mas b.fol)]
        $(b.fol lat, sub ?:(=(2 now) -.sub +.sub))
      ::
          [1 b=*]
        [%0 b.fol]
      ::
          [2 b=^ c=*]
        =+  ben=$(fol [b.fol c.fol])
        ?.  ?=(0 -.ben)  ben
        ?>(?=(^ p.ben) $(sub -.p.ben, fol +.p.ben))
      ::
          [3 b=*]
        =+  ben=$(fol b.fol)
        ?.  ?=(0 -.ben)  ben
        [%0 .?(p.ben)]
      ::
          [4 b=*]
        =+  ben=$(fol b.fol)
        ?.  ?=(0 -.ben)  ben
        ?.  ?=(@ p.ben)  [%2 tax]
        [%0 .+(p.ben)]
      ::
          [5 b=*]
        =+  ben=$(fol b.fol)
        ?.  ?=(0 -.ben)  ben
        ?.  ?=(^ p.ben)  [%2 tax]
        [%0 =(-.p.ben +.p.ben)]
      ::
          [6 b=* c=* d=*]
        $(fol =>(fol [2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]))
      ::
          [7 b=* c=*]       $(fol =>(fol [2 b 1 c]))
          [8 b=* c=*]       $(fol =>(fol [7 [[0 1] b] c]))
          [9 b=* c=*]       $(fol =>(fol [7 c 0 b]))
          [10 @ c=*]        $(fol c.fol)
          [10 [* c=*] d=*]
        =+  ben=$(fol c.fol)
        ?.  ?=(0 -.ben)  ben
        ?:  ?=(?(%hunk %lose %mean %spot) +<-.fol)
          $(fol d.fol, tax [[+<-.fol p.ben] tax])
        $(fol d.fol)
      ::
          [11 b=*]
        =+  ben=$(fol b.fol)
        ?.  ?=(0 -.ben)  ben
        =+  val=(sky p.ben)
        ?@(val [%1 p.ben ~] [%0 +.val])
      ::
          *
        [%2 tax]
      ==
    ::
    ++  mock
      |=  [[sub=* fol=*] sky=$+(* (unit))]
      (mook (mink [sub fol] sky))
    ::
    ++  mook
      |=  ton=tone
      ^-  toon
      ?.  ?=([2 *] ton)  ton
      :-  %2
      =+  yel=(lent p.ton)
      =.  p.ton
        ?.  (gth yel 256)  p.ton
        %+  weld
          (scag 128 p.ton)
        ^-  (list ,[@ta *])
        :_  (slag (sub yel 128) p.ton)
        :-  %lose
        %+  rap  3
        ;:  weld
          "[skipped "
          ~(rend co %$ %ud (sub yel 256))
          " frames]"
        ==
      |-  ^-  (list tank)
      ?~  p.ton  ~
      =+  rex=$(p.ton t.p.ton)
      ?+    -.i.p.ton  rex
          %hunk  [(tank +.i.p.ton) rex]
          %lose  [[%leaf (rip 3 (,@ +.i.p.ton))] rex]
          %mean  :_  rex
                 ?@  +.i.p.ton  [%leaf (rip 3 (,@ +.i.p.ton))]
                 =+  mac=(mack +.i.p.ton +<.i.p.ton)
                 ?~(mac [%leaf "####"] (tank u.mac))
          %spot  :_  rex
                 =+  sot=(spot +.i.p.ton)
                 :-  %leaf
                 ;:  weld
                   ~(ram re (smyt p.sot))
                   ":<["
                   ~(rend co ~ %ud p.p.q.sot)
                   " "
                   ~(rend co ~ %ud q.p.q.sot)
                   "].["
                   ~(rend co ~ %ud p.q.q.sot)
                   " "
                   ~(rend co ~ %ud q.q.q.sot)
                   "]>"
                 ==
      ==
    ::
    ++  mang
      |=  [[gat=* sam=*] sky=$+(* (unit))]
      ^-  (unit)
      =+  ton=(mong [[gat sam] sky])
      ?.(?=([0 *] ton) ~ [~ p.ton])
    ::
    ++  mong
      |=  [[gat=* sam=*] sky=$+(* (unit))]
      ^-  toon
      ?.  &(?=(^ gat) ?=(^ +.gat))
        [%2 ~]
      (mock [[-.gat [sam +>.gat]] -.gat] sky)
    ::
    ++  mung
      |=  [[gat=* sam=*] sky=$+(* (unit))]
      ^-  tone
      ?.  &(?=(^ gat) ?=(^ +.gat))
        [%2 ~]
      (mink [[-.gat [sam +>.gat]] -.gat] sky)
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eO, diff (move me)           ::
    ::
    ::
    ++  berk                                                ::  invert diff patch
      |*  bur=(urge)
      |-  ^+  bur
      ?~  bur  ~
      :_  $(bur t.bur)
      ?-  -.i.bur
        &  i.bur
        |  [%| q.i.bur p.i.bur]
      ==
    ::
    ++  diff                                                ::  generate patch
      |=  pum=umph
      |=  [old=* new=*]  ^-  udon
      :-  pum
      ?+  pum  ~|(%unsupported !!)
        %a  [%a old new]
        %c  =+  [hel=(lore ((hard ,@) old)) hev=(lore ((hard ,@) new))]
            [%c (lusk hel hev (loss hel hev))]
      ==
    ::
    ++  loss                                                ::  longest subsequence
      ~/  %loss
      |*  [hel=(list) hev=(list)]
      |-  ^+  hev
      =+  ^=  sev
          =+  [inx=0 sev=*(map ,@t (list ,@ud))]
          |-  ^+  sev
          ?~  hev  sev
          =+  guy=(~(get by sev) i.hev)
          $(hev t.hev, inx +(inx), sev (~(put by sev) i.hev [inx ?~(guy ~ u.guy)]))
      =|  gox=[p=@ud q=(map ,@ud ,[p=@ud q=_hev])]
      =<  abet
      =<  main
      |%
      ++  abet                                              ::  subsequence
        ^+  hev
        ?:  =(0 p.gox)  ~
        (flop q:(need (~(get by q.gox) (dec p.gox))))
      ::
      ++  hink                                              ::  extend fits top
        |=  [inx=@ud goy=@ud]  ^-  ?
        |(=(p.gox inx) (lth goy p:(need (~(get by q.gox) inx))))
      ::
      ++  lonk                                              ::  extend fits bottom
        |=  [inx=@ud goy=@ud]  ^-  ?
        |(=(0 inx) (gth goy p:(need (~(get by q.gox) (dec inx)))))
      ::
      ++  lune                                              ::  extend
        |=  [inx=@ud goy=@ud]
        ^+  +>
        %_    +>.$
            gox
          :-  ?:(=(inx p.gox) +(p.gox) p.gox)
          %+  ~(put by q.gox)  inx
          [goy (snag goy hev) ?:(=(0 inx) ~ q:(need (~(get by q.gox) (dec inx))))]
        ==
      ::
      ++  merg                                              ::  merge all matches
        |=  gay=(list ,@ud)
        ^+  +>
        =+  ^=  zes
            =+  [inx=0 zes=*(list ,[p=@ud q=@ud])]
            |-  ^+  zes
            ?:  |(?=(~ gay) (gth inx p.gox))  zes
            ?.  (lonk inx i.gay)  $(gay t.gay)
            ?.  (hink inx i.gay)  $(inx +(inx))
            $(inx +(inx), gay t.gay, zes [[inx i.gay] zes])
        |-  ^+  +>.^$
        ?~(zes +>.^$ $(zes t.zes, +>.^$ (lune i.zes)))
      ::
      ++  main
        =+  hol=hel
        |-  ^+  +>
        ?~  hol  +>
        =+  guy=(~(get by sev) i.hol)
        $(hol t.hol, +> (merg (flop `(list ,@ud)`?~(guy ~ u.guy))))
      --
    ::
    ++  locz                                                ::  trivial algorithm
      |=  [hel=tape hev=tape]
      ^-  tape
      =+  [leh=(lent hel) veh=(lent hev)]
      =-  (flop q.yun)
      ^=  yun
      |-  ^-  [p=@ud q=tape]
      ~+
      ?:  |(=(0 leh) =(0 veh))  [0 ~]
      =+  [dis=(snag (dec leh) hel) dat=(snag (dec veh) hev)]
      ?:  =(dis dat)
        =+  say=$(leh (dec leh), veh (dec veh))
        [+(p.say) [dis q.say]]
      =+  [lef=$(leh (dec leh)) rig=$(veh (dec veh))]
      ?:((gth p.lef p.rig) lef rig)
    ::
    ++  lore                                                ::  atom to line list
      ~/  %lore
      |=  lub=@
      =|  tez=(list ,@t)
      |-  ^+  tez
      ?:  =(0 lub)  (flop tez)
      =+  ^=  meg
          =+  meg=0
          |-  ^-  @ud
          =+  gam=(cut 3 [meg 1] lub)
          ?:(|(=(10 gam) =(0 gam)) meg $(meg +(meg)))
      $(lub (rsh 3 +(meg) lub), tez [(end 3 meg lub) tez])
    ::
    ++  role                                                ::  line list to atom
      |=  tez=(list ,@t)
      (rap 3 (turn tez |=(a=@t (cat 3 a 10))))
    ::
    ++  lump                                                ::  apply patch
      |=  [don=udon src=*]
      ^-  *
      ?+    p.don  ~|(%unsupported !!)
          %a
        ?+  -.q.don  ~|(%unsupported !!)
          %a  q.p.q.don
          %c  (lurk ((hard (list)) src) p.q.don)
        ==
      ::
          %c
        =+  dst=(lore ((hard ,@) src))
        %-  role
        ?+  -.q.don  ~|(%unsupported !!)
          %a  ((hard (list ,@t)) q.p.q.don)
          %c  (lurk dst p.q.don)
        ==
      ==
    ::
    ++  limp                                                ::  invert patch
      |=  don=udon  ^-  udon
      :-  p.don
      ?+  -.q.don  ~|(%unsupported !!)
        %a  [%a q.p.q.don p.p.q.don]
        %c  [%c (berk p.q.don)]
        %d  [%d q.q.don p.q.don]
      ==
    ::
    ++  hump                                                ::  general prepatch
      |=  [pum=umph src=*]  ^-  *
      ?+  pum  ~|(%unsupported !!)
        %a   src
        %c  (lore ((hard ,@) src))
      ==
    ::
    ++  husk                                                ::  unprepatch
      |=  [pum=umph dst=*]  ^-  *
      ?+  pum  ~|(%unsupported !!)
        %a  dst
        %c  (role ((hard (list ,@)) dst))
      ==
    ::
    ++  lurk                                                ::  apply list patch
      |*  [hel=(list) rug=(urge)]
      ^+  hel
      =+  war=`_hel`~
      |-  ^+  hel
      ?~  rug  (flop war)
      ?-    -.i.rug
          &
        %=   $
          rug  t.rug
          hel  (slag p.i.rug hel)
          war  (weld (flop (scag p.i.rug hel)) war)
        ==
      ::
          |
        %=  $
          rug  t.rug
          hel  =+  gur=(flop p.i.rug)
               |-  ^+  hel
               ?~  gur  hel
               ?>(&(?=(^ hel) =(i.gur i.hel)) $(hel t.hel, gur t.gur))
          war  (weld q.i.rug war)
        ==
      ==
    ::
    ++  lusk                                                ::  lcs to list patch
      |*  [hel=(list) hev=(list) lcs=(list)]
      =+  ^=  rag
          ^-  $%  [& p=@ud]
                  [| p=_lcs q=_lcs]
              ==
          [%& 0]
      =>  .(rag [p=rag q=*(list ,_rag)])
      =<  abet  =<  main
      |%
      ++  abet  =.(q.rag ?:(=([& 0] p.rag) q.rag [p.rag q.rag]) (flop q.rag))
      ++  done
        |=  new=_p.rag
        ^+  rag
        ?-  -.p.rag
          |   ?-  -.new
                |  [[%| (weld p.new p.p.rag) (weld q.new q.p.rag)] q.rag]
                &  [new [p.rag q.rag]]
              ==
          &   ?-  -.new
                |  [new ?:(=(0 p.p.rag) q.rag [p.rag q.rag])]
                &  [[%& (add p.p.rag p.new)] q.rag]
              ==
        ==
      ::
      ++  main
        |-  ^+  +
        ?~  hel
          ?~  hev
            ?>(?=(~ lcs) +)
          $(hev t.hev, rag (done %| ~ [i.hev ~]))
        ?~  hev
          $(hel t.hel, rag (done %| [i.hel ~] ~))
        ?~  lcs
          +(rag (done %| (flop hel) (flop hev)))
        ?:  =(i.hel i.lcs)
          ?:  =(i.hev i.lcs)
            $(lcs t.lcs, hel t.hel, hev t.hev, rag (done %& 1))
          $(hev t.hev, rag (done %| ~ [i.hev ~]))
        ?:  =(i.hev i.lcs)
          $(hel t.hel, rag (done %| [i.hel ~] ~))
        $(hel t.hel, hev t.hev, rag (done %| [i.hel ~] [i.hev ~]))
      --
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eY, SHA-256 (move me)        ::
    ::
    ++  shad  |=(ruz=@ (shax (shax ruz)))                   ::  double sha-256
    ++  shaf                                                ::  half sha-256
      |=  [sal=@ ruz=@]
      =+  haz=(shas sal ruz)
      (mix (end 7 1 haz) (rsh 7 1 haz))
    ::
    ++  shak                                                ::  XX shd be PBKDF
      |=  [who=@p wud=@]
      (shas (mix %shak who) wud)
    ::
    ++  sham                                                ::  noun hash
      |=  yux=*  ^-  @uvH  ^-  @
      ?@  yux
        (shaf %mash yux)
      (shaf %sham (jam yux))
    ::
    ++  shas                                                ::  salted hash
      |=  [sal=@ ruz=@]
      (shax (mix sal (shax ruz)))
    ::
    ++  shax                                                ::  sha-256
      ~/  %shax
      |=  ruz=@  ^-  @
      ~|  %sha
      =+  [few==>(fe .(a 5)) wac=|=([a=@ b=@] (cut 5 [a 1] b))]
      =+  [sum=sum.few ror=ror.few net=net.few inv=inv.few]
      =+  ral=(lsh 0 3 (met 3 ruz))
      =+  ^=  ful
          %+  can  0
          :~  [ral ruz]
              [8 128]
              [(mod (sub 960 (mod (add 8 ral) 512)) 512) 0]
              [64 (~(net fe 6) ral)]
          ==
      =+  lex=(met 9 ful)
      =+  ^=  kbx  0xc671.78f2.bef9.a3f7.a450.6ceb.90be.fffa.
                     8cc7.0208.84c8.7814.78a5.636f.748f.82ee.
                     682e.6ff3.5b9c.ca4f.4ed8.aa4a.391c.0cb3.
                     34b0.bcb5.2748.774c.1e37.6c08.19a4.c116.
                     106a.a070.f40e.3585.d699.0624.d192.e819.
                     c76c.51a3.c24b.8b70.a81a.664b.a2bf.e8a1.
                     9272.2c85.81c2.c92e.766a.0abb.650a.7354.
                     5338.0d13.4d2c.6dfc.2e1b.2138.27b7.0a85.
                     1429.2967.06ca.6351.d5a7.9147.c6e0.0bf3.
                     bf59.7fc7.b003.27c8.a831.c66d.983e.5152.
                     76f9.88da.5cb0.a9dc.4a74.84aa.2de9.2c6f.
                     240c.a1cc.0fc1.9dc6.efbe.4786.e49b.69c1.
                     c19b.f174.9bdc.06a7.80de.b1fe.72be.5d74.
                     550c.7dc3.2431.85be.1283.5b01.d807.aa98.
                     ab1c.5ed5.923f.82a4.59f1.11f1.3956.c25b.
                     e9b5.dba5.b5c0.fbcf.7137.4491.428a.2f98
      =+  ^=  hax  0x5be0.cd19.1f83.d9ab.9b05.688c.510e.527f.
                     a54f.f53a.3c6e.f372.bb67.ae85.6a09.e667
      =+  i=0
      |-  ^-  @
      ?:  =(i lex)
        (rep 5 (turn (rip 5 hax) net))
      =+  ^=  wox
          =+  dux=(cut 9 [i 1] ful)
          =+  wox=(rep 5 (turn (rip 5 dux) net))
          =+  j=16
          |-  ^-  @
          ?:  =(64 j)
            wox
          =+  :*  l=(wac (sub j 15) wox)
                  m=(wac (sub j 2) wox)
                  n=(wac (sub j 16) wox)
                  o=(wac (sub j 7) wox)
              ==
          =+  x=:(mix (ror 0 7 l) (ror 0 18 l) (rsh 0 3 l))
          =+  y=:(mix (ror 0 17 m) (ror 0 19 m) (rsh 0 10 m))
          =+  z=:(sum n x o y)
          $(wox (con (lsh 5 j z) wox), j +(j))
      =+  j=0
      =+  :*  a=(wac 0 hax)
              b=(wac 1 hax)
              c=(wac 2 hax)
              d=(wac 3 hax)
              e=(wac 4 hax)
              f=(wac 5 hax)
              g=(wac 6 hax)
              h=(wac 7 hax)
          ==
      |-  ^-  @
      ?:  =(64 j)
        %=  ^$
          i  +(i)
          hax  %+  rep  5
               :~  (sum a (wac 0 hax))
                   (sum b (wac 1 hax))
                   (sum c (wac 2 hax))
                   (sum d (wac 3 hax))
                   (sum e (wac 4 hax))
                   (sum f (wac 5 hax))
                   (sum g (wac 6 hax))
                   (sum h (wac 7 hax))
               ==
        ==
      =+  l=:(mix (ror 0 2 a) (ror 0 13 a) (ror 0 22 a))    ::  s0
      =+  m=:(mix (dis a b) (dis a c) (dis b c))            ::  maj
      =+  n=(sum l m)                                       ::  t2
      =+  o=:(mix (ror 0 6 e) (ror 0 11 e) (ror 0 25 e))    ::  s1
      =+  p=(mix (dis e f) (dis (inv e) g))                 ::  ch
      =+  q=:(sum h o p (wac j kbx) (wac j wox))            ::  t1
      $(j +(j), a (sum q n), b a, c b, d c, e (sum d q), f e, g f, h g)
    ::
    ++  shaw                                                ::  hash to nbits
      |=  [sal=@ len=@ ruz=@]
      (~(raw og (shas sal (mix len ruz))) len)
    ::
    ++  og                                                  ::  shax-powered rng
      ~/  %og
      |_  a=@
      ++  rad                                               ::  random in range
        |=  b=@  ^-  @
        =+  c=(raw (met 0 b))
        ?:((lth c b) c $(a +(a)))
        ::
      ++  raw                                               ::  random bits
        ~/  %raw
        |=  b=@  ^-  @
        %+  can
          0
        =+  c=(shas %og-a (mix b a))
        |-  ^-  (list ,[@ @])
        ?:  =(0 b)
          ~
        =+  d=(shas %og-b (mix b (mix a c)))
        ?:  (lth b 256)
          [[b (end 0 b d)] ~]
        [[256 d] $(c d, b (sub b 256))]
      --
    ++  shaz                                                ::  sha-512
      |=  ruz=@  ^-  @
      (shal [(met 3 ruz) ruz])
    ++  shal                                                ::  sha-512 with length
      ~/  %shal
      |=  [len=@ ruz=@]  ^-  @
      =>  .(ruz (cut 3 [0 len] ruz))
      =+  [few==>(fe .(a 6)) wac=|=([a=@ b=@] (cut 6 [a 1] b))]
      =+  [sum=sum.few ror=ror.few net=net.few inv=inv.few]
      =+  ral=(lsh 0 3 len)
      =+  ^=  ful
          %+  can  0
          :~  [ral ruz]
              [8 128]
              [(mod (sub 1.920 (mod (add 8 ral) 1.024)) 1.024) 0]
              [128 (~(net fe 7) ral)]
          ==
      =+  lex=(met 10 ful)
      =+  ^=  kbx  0x6c44.198c.4a47.5817.5fcb.6fab.3ad6.faec.
                     597f.299c.fc65.7e2a.4cc5.d4be.cb3e.42b6.
                     431d.67c4.9c10.0d4c.3c9e.be0a.15c9.bebc.
                     32ca.ab7b.40c7.2493.28db.77f5.2304.7d84.
                     1b71.0b35.131c.471b.113f.9804.bef9.0dae.
                     0a63.7dc5.a2c8.98a6.06f0.67aa.7217.6fba.
                     f57d.4f7f.ee6e.d178.eada.7dd6.cde0.eb1e.
                     d186.b8c7.21c0.c207.ca27.3ece.ea26.619c.
                     c671.78f2.e372.532b.bef9.a3f7.b2c6.7915.
                     a450.6ceb.de82.bde9.90be.fffa.2363.1e28.
                     8cc7.0208.1a64.39ec.84c8.7814.a1f0.ab72.
                     78a5.636f.4317.2f60.748f.82ee.5def.b2fc.
                     682e.6ff3.d6b2.b8a3.5b9c.ca4f.7763.e373.
                     4ed8.aa4a.e341.8acb.391c.0cb3.c5c9.5a63.
                     34b0.bcb5.e19b.48a8.2748.774c.df8e.eb99.
                     1e37.6c08.5141.ab53.19a4.c116.b8d2.d0c8.
                     106a.a070.32bb.d1b8.f40e.3585.5771.202a.
                     d699.0624.5565.a910.d192.e819.d6ef.5218.
                     c76c.51a3.0654.be30.c24b.8b70.d0f8.9791.
                     a81a.664b.bc42.3001.a2bf.e8a1.4cf1.0364.
                     9272.2c85.1482.353b.81c2.c92e.47ed.aee6.
                     766a.0abb.3c77.b2a8.650a.7354.8baf.63de.
                     5338.0d13.9d95.b3df.4d2c.6dfc.5ac4.2aed.
                     2e1b.2138.5c26.c926.27b7.0a85.46d2.2ffc.
                     1429.2967.0a0e.6e70.06ca.6351.e003.826f.
                     d5a7.9147.930a.a725.c6e0.0bf3.3da8.8fc2.
                     bf59.7fc7.beef.0ee4.b003.27c8.98fb.213f.
                     a831.c66d.2db4.3210.983e.5152.ee66.dfab.
                     76f9.88da.8311.53b5.5cb0.a9dc.bd41.fbd4.
                     4a74.84aa.6ea6.e483.2de9.2c6f.592b.0275.
                     240c.a1cc.77ac.9c65.0fc1.9dc6.8b8c.d5b5.
                     efbe.4786.384f.25e3.e49b.69c1.9ef1.4ad2.
                     c19b.f174.cf69.2694.9bdc.06a7.25c7.1235.
                     80de.b1fe.3b16.96b1.72be.5d74.f27b.896f.
                     550c.7dc3.d5ff.b4e2.2431.85be.4ee4.b28c.
                     1283.5b01.4570.6fbe.d807.aa98.a303.0242.
                     ab1c.5ed5.da6d.8118.923f.82a4.af19.4f9b.
                     59f1.11f1.b605.d019.3956.c25b.f348.b538.
                     e9b5.dba5.8189.dbbc.b5c0.fbcf.ec4d.3b2f.
                     7137.4491.23ef.65cd.428a.2f98.d728.ae22
      =+  ^=  hax  0x5be0.cd19.137e.2179.1f83.d9ab.fb41.bd6b.
                     9b05.688c.2b3e.6c1f.510e.527f.ade6.82d1.
                     a54f.f53a.5f1d.36f1.3c6e.f372.fe94.f82b.
                     bb67.ae85.84ca.a73b.6a09.e667.f3bc.c908
      =+  i=0
      |-  ^-  @
      ?:  =(i lex)
        (rep 6 (turn (rip 6 hax) net))
      =+  ^=  wox
          =+  dux=(cut 10 [i 1] ful)
          =+  wox=(rep 6 (turn (rip 6 dux) net))
          =+  j=16
          |-  ^-  @
          ?:  =(80 j)
            wox
          =+  :*  l=(wac (sub j 15) wox)
                  m=(wac (sub j 2) wox)
                  n=(wac (sub j 16) wox)
                  o=(wac (sub j 7) wox)
              ==
          =+  x=:(mix (ror 0 1 l) (ror 0 8 l) (rsh 0 7 l))
          =+  y=:(mix (ror 0 19 m) (ror 0 61 m) (rsh 0 6 m))
          =+  z=:(sum n x o y)
          $(wox (con (lsh 6 j z) wox), j +(j))
      =+  j=0
      =+  :*  a=(wac 0 hax)
              b=(wac 1 hax)
              c=(wac 2 hax)
              d=(wac 3 hax)
              e=(wac 4 hax)
              f=(wac 5 hax)
              g=(wac 6 hax)
              h=(wac 7 hax)
          ==
      |-  ^-  @
      ?:  =(80 j)
        %=  ^$
          i  +(i)
          hax  %+  rep  6
               :~  (sum a (wac 0 hax))
                   (sum b (wac 1 hax))
                   (sum c (wac 2 hax))
                   (sum d (wac 3 hax))
                   (sum e (wac 4 hax))
                   (sum f (wac 5 hax))
                   (sum g (wac 6 hax))
                   (sum h (wac 7 hax))
               ==
        ==
      =+  l=:(mix (ror 0 28 a) (ror 0 34 a) (ror 0 39 a))   ::  S0
      =+  m=:(mix (dis a b) (dis a c) (dis b c))            ::  maj
      =+  n=(sum l m)                                       ::  t2
      =+  o=:(mix (ror 0 14 e) (ror 0 18 e) (ror 0 41 e))   ::  S1
      =+  p=(mix (dis e f) (dis (inv e) g))                 ::  ch
      =+  q=:(sum h o p (wac j kbx) (wac j wox))            ::  t1
      $(j +(j), a (sum q n), b a, c b, d c, e (sum d q), f e, g f, h g)
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::                section 2eZ, OLD rendering (kill me)  ::
    ::
    ++  show                            ::  XX deprecated, use type
      |=  vem=*
      |^  ^-  tank
          ?:  ?=(@ vem)
            [%leaf (mesc (trip vem))]
          ?-    vem
              [s=~ c=*]
            [%leaf '\'' (weld (mesc (tape +.vem)) `tape`['\'' ~])]
          ::
              [s=%a c=@]        [%leaf (mesc (trip c.vem))]
              [s=%b c=*]        (shop c.vem |=(a=@ ~(rub at a)))
              [s=[%c p=@] c=*]
            :+  %palm
              [['.' ~] ['-' ~] ~ ~]
            [[%leaf (mesc (trip p.s.vem))] $(vem c.vem) ~]
          ::
              [s=%d c=*]        (shop c.vem |=(a=@ ~(rud at a)))
              [s=%k c=*]        (tank c.vem)
              [s=%h c=*]
            ?:  =(0 c.vem)      ::  XX remove after 220
              [%leaf '#' ~]
            :+  %rose
              [['/' ~] ['/' ~] ~]
            =+  yol=((list ,@ta) c.vem)
            (turn yol |=(a=@ta [%leaf (trip a)]))
          ::
              [s=%o c=*]
            %=    $
                vem
              :-  [%m '%h:<[%d %d].[%d %d]>']
              [-.c.vem +<-.c.vem +<+.c.vem +>-.c.vem +>+.c.vem ~]
            ==
          ::
              [s=%p c=*]        (shop c.vem |=(a=@ ~(rup at a)))
              [s=%q c=*]        (shop c.vem |=(a=@ ~(r at a)))
              [s=%r c=*]        $(vem [[%r ' ' '{' '}'] c.vem])
              [s=%t c=*]        (shop c.vem |=(a=@ ~(rt at a)))
              [s=%v c=*]        (shop c.vem |=(a=@ ~(ruv at a)))
              [s=%x c=*]        (shop c.vem |=(a=@ ~(rux at a)))
              [s=[%m p=@] c=*]  (shep p.s.vem c.vem)
              [s=[%r p=@] c=*]
            $(vem [[%r ' ' (cut 3 [0 1] p.s.vem) (cut 3 [1 1] p.s.vem)] c.vem])
          ::
              [s=[%r p=@ q=@ r=@] c=*]
            :+  %rose
              :*  p=(mesc (trip p.s.vem))
                  q=(mesc (trip q.s.vem))
                  r=(mesc (trip r.s.vem))
              ==
            |-  ^-  (list tank)
            ?@  c.vem
              ~
            [^$(vem -.c.vem) $(c.vem +.c.vem)]
          ::
              [s=%z c=*]        $(vem [[%r %$ %$ %$] c.vem])
              *                 !!
          ==
      ++  shep
        |=  [fom=@ gar=*]
        ^-  tank
        =+  l=(met 3 fom)
        =+  i=0
        :-  %leaf
        |-  ^-  tape
        ?:  (gte i l)
          ~
        =+  c=(cut 3 [i 1] fom)
        ?.  =(37 c)
          (weld (mesc [c ~]) $(i +(i)))
        =+  d=(cut 3 [+(i) 1] fom)
        ?.  .?(gar)
          ['\\' '#' $(i (add 2 i))]
        (weld ~(ram re (show d -.gar)) $(i (add 2 i), gar +.gar))
      ::
      ++  shop
        |=  [aug=* vel=$+(a=@ tape)]
        ^-  tank
        ?:  ?=(@ aug)
          [%leaf (vel aug)]
        :+  %rose
          [[' ' ~] ['[' ~] [']' ~]]
        =>  .(aug `*`aug)
        |-  ^-  (list tank)
        ?:  ?=(@ aug)
          [^$ ~]
        [^$(aug -.aug) $(aug +.aug)]
      --
    ++  at
      |_  a=@
      ++  r
        ?:  ?&  (gte (met 3 a) 2)
                |-
                ?:  =(0 a)
                  &
                =+  vis=(end 3 1 a)
                ?&  ?|(=('-' vis) ?&((gte vis 'a') (lte vis 'z')))
                    $(a (rsh 3 1 a))
                ==
            ==
          rtam
        ?:  (lte (met 3 a) 2)
          rud
        rux
      ::
      ++  rf    `tape`[?-(a & '&', | '|', * !!) ~]
      ++  rn    `tape`[?>(=(0 a) '~') ~]
      ++  rt    `tape`['\'' (weld (mesc (trip a)) `tape`['\'' ~])]
      ++  rta   rt
      ++  rtam  `tape`['%' (trip a)]
      ++  rub   `tape`['0' 'b' (rum 2 ~ |=(b=@ (add '0' b)))]
      ++  rud   (rum 10 ~ |=(b=@ (add '0' b)))
      ++  rum
        |=  [b=@ c=tape d=$+(@ @)]
        ^-  tape
        ?:  =(0 a)
          [(d 0) c]
        =+  e=0
        |-  ^-  tape
        ?:  =(0 a)
          c
        =+  f=&(!=(0 e) =(0 (mod e ?:(=(10 b) 3 4))))
        %=  $
          a  (div a b)
          c  [(d (mod a b)) ?:(f [?:(=(10 b) ',' '-') c] c)]
          e  +(e)
        ==
      ::
      ++  rup
        =+  b=(met 3 a)
        ^-  tape
        :-  '-'
        |-  ^-  tape
        ?:  (gth (met 5 a) 1)
          %+  weld
            $(a (rsh 5 1 a), b (sub b 4))
          `tape`['-' '-' $(a (end 5 1 a), b 4)]
        ?:  =(0 b)
          ['~' ~]
        ?:  (lte b 1)
          (trip (tos:po a))
        |-  ^-  tape
        ?:  =(2 b)
          =+  c=(rsh 3 1 a)
          =+  d=(end 3 1 a)
          (weld (trip (tod:po c)) (trip (tos:po (mix c d))))
        =+  c=(rsh 3 2 a)
        =+  d=(end 3 2 a)
        (weld ^$(a c, b (met 3 c)) `tape`['-' $(a (mix c d), b 2)])
      ::
      ++  ruv
        ^-  tape
        :+  '0'
          'v'
        %^    rum
            64
          ~
        |=  b=@
        ?:  =(63 b)
          '+'
        ?:  =(62 b)
          '-'
        ?:((lth b 26) (add 65 b) ?:((lth b 52) (add 71 b) (sub b 4)))
      ::
      ++  rux  `tape`['0' 'x' (rum 16 ~ |=(b=@ (add b ?:((lth b 10) 48 87))))]
      --
