---
layout: subpage
title: 2c Simple Noun Surgery
axis: doc-hoon
categories: lib
sort: 3
---

  ::::::::::::::::::::::::::::::::::::::::::::::::::::::  ::
::::              chapter 2c, simple noun surgery       ::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cA, bit surgery              ::
::
++  bex                                                 ::  binary exponent
  ~/  %bex
  |=  a=@
  ^-  @
  ?:  =(0 a)
    1
  (mul 2 $(a (dec a)))

::  a is an atom. Produces an atom of 2^a.
::  ~talsur-todres/try=> (bex 4)
::  16


++  can                                                 ::  assemble
  ~/  %can
  |=  [a=bloq b=(list ,[p=@ q=@])]
  ^-  @
  ?~  b
    0
  (mix (end a p.i.b q.i.b) (lsh a p.i.b $(b t.b)))

::


++  cat                                                 ::  concatenate
  ~/  %cat
  |=  [a=bloq b=@ c=@]
  (add (lsh a (met a b) c) b)
::
++  cut                                                 ::  slice
  ~/  %cut
  |=  [a=bloq [b=@ c=@] d=@]
  (end a c (rsh a b d))
::
++  end                                                 ::  tail
  ~/  %end
  |=  [a=bloq b=@ c=@]
  (mod c (bex (mul (bex a) b)))
::
++  lsh                                                 ::  left-shift
  ~/  %lsh
  |=  [a=bloq b=@ c=@]
  (mul (bex (mul (bex a) b)) c)
::
++  met                                                 ::  measure
  ~/  %met
  |=  [a=bloq b=@]
  ^-  @
  =+  c=0
  |-
  ?:  =(0 b)
    c
  $(b (rsh a 1 b), c +(c))
::
++  rap                                                 ::  assemble nonzero
  ~/  %rap
  |=  [a=bloq b=(list ,@)]
  ^-  @
  ?@  b
    0
  (cat a i.b $(b t.b))
::
++  rep                                                 ::  assemble single
  ~/  %rep
  |=  [a=bloq b=(list ,@)]
  ^-  @
  =+  c=0
  |-
  ?@  b
    0
  (con (lsh a c (end a 1 i.b)) $(c +(c), b t.b))
::
++  rip                                                 ::  disassemble
  ~/  %rip
  |=  [a=bloq b=@]
  ^-  (list ,@)
  ?:  =(0 b)
    ~
  [(end a 1 b) $(b (rsh a 1 b))]
::
++  rsh                                                 ::  right-shift
  ~/  %rsh
  |=  [a=bloq b=@ c=@]
  (div c (bex (mul (bex a) b)))
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cB, bit logic                ::
::
++  con                                                 ::  binary or
  ~/  %con
  |=  [a=@ b=@]
  =+  [c=0 d=0]
  |-  ^-  @
  ?:  ?&(=(0 a) =(0 b))
    d
  %=  $
    a   (rsh 0 1 a)
    b   (rsh 0 1 b)
    c   +(c)
    d   (add d (lsh 0 c ?&(=(0 (end 0 1 a)) =(0 (end 0 1 b)))))
  ==
::
++  dis                                                 ::  binary and
  ~/  %dis
  |=  [a=@ b=@]
  =|  [c=@ d=@]
  |-  ^-  @
  ?:  ?|(=(0 a) =(0 b))
    d
  %=  $
    a   (rsh 0 1 a)
    b   (rsh 0 1 b)
    c   +(c)
    d   (add d (lsh 0 c ?|(=(0 (end 0 1 a)) =(0 (end 0 1 b)))))
  ==
::
++  mix                                                 ::  binary xor
  ~/  %mix
  |=  [a=@ b=@]
  ^-  @
  =+  [c=0 d=0]
  |-
  ?:  ?&(=(0 a) =(0 b))
    d
  %=  $
    a   (rsh 0 1 a)
    b   (rsh 0 1 b)
    c   +(c)
    d   (add d (lsh 0 c =((end 0 1 a) (end 0 1 b))))
  ==
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cC, noun orders              ::
::
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
::
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
::
++  gor                                                 ::  g-order
  ~/  %gor
  |=  [a=* b=*]
  ^-  ?
  =+  [c=(mug a) d=(mug b)]
  ?:  =(c d)
    (dor a b)
  (lth c d)
::
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
::
++  vor                                                 ::  v-order
  ~/  %vor
  |=  [a=* b=*]
  ^-  ?
  =+  [c=(mug (mug a)) d=(mug (mug b))]
  ?:  =(c d)
    (dor a b)
  (lth c d)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cD, insecure hashing         ::
::
++  fnv  |=(a=@ (end 5 1 (mul 16.777.619 a)))           ::  FNV scrambler
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
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cE, phonetic base            ::
::
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
  ++  ind  ~/  %ind
           |=  a=@
           =+  b=0
           |-  ^-  (unit ,@)
           ?:(=(256 b) ~ ?:(=(a (tod b)) [~ b] $(b +(b))))
  ++  ins  ~/  %ins
           |=  a=@
           =+  b=0
           |-  ^-  (unit ,@)
           ?:(=(256 b) ~ ?:(=(a (tos b)) [~ b] $(b +(b))))
  ++  tod  ~/(%tod |=(a=@ ?>((lth a 256) (cut 3 [(mul 3 a) 3] dex))))
  ++  tos  ~/(%tos |=(a=@ ?>((lth a 256) (cut 3 [(mul 3 a) 3] sis))))
  --
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                section 2cF, signed and modular ints  ::
::
++  si                                                  ::  signed integer
  |%
  ++  abs  |=(a=@s (add (end 0 1 a) (rsh 0 1 a)))
  ::  absolute value of a
  ::
  ++  dif  |=([a=@s b=@s] (sum a (new !(syn b) (abs b))))
  ::  signed subtraction
  ::
  ++  dul  |=([a=@s b=@] =+(c=(old a) ?:(-.c (mod +.c b) (sub b +.c))))
  ::  signed mod ??
  ::
  ++  fra  |=  [a=@s b=@s]
           (new =(0 (mix (syn a) (syn b))) (div (abs a) (abs b)))
  ::  signed division
  ::
  ++  new  |=([a=? b=@] `@s`?:(a (mul 2 b) ?:(=(0 b) 0 +((mul 2 (dec b))))))
  ::  convert [sign magnitude] pair to @s
  ::
  ++  old  |=(a=@s [(syn a) (abs a)])
  ::  sign magnitude pair
  ::
  ++  pro  |=  [a=@s b=@s]
           (new =(0 (mix (syn a) (syn b))) (mul (abs a) (abs b)))
  ::  signed multiplication
  ::
  ++  rem  |=([a=@s b=@s] (dif a (pro b (fra a b))))
  ::  signed remainder
  ::
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
  ++  sun  |=(a=@u (mul 2 a))
  ::  convert @u to @s
  ::
  ++  syn  |=(a=@s =(0 (end 0 1 a)))
  ::  %.y if a is positive, %.n if a is negative
  --
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
 
>>>>>>> 4ef2770269ac90a6bca1bc784b3a66e5bc62dc44
