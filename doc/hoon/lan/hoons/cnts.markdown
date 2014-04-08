---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 40
title: centis
---


#[centis, `%=`, %cnts](#cnts)

##Syntax

`%=`, `centis`, `[%cnts p=wing q=tram]` is a natural hoon that
evaluates `p` with the changes specified in `q`.


###Form

`p` is a wing

`q` is a tram

`p.i.q` is a wing
`q.i.q` is a twig
`p.i.t.q` is a wing
`q.i.t.q` is a twig

####Tall

    %=  p
      p.i.q    q.i.q
      p.i.t.q  q.i.t.q
    ==

####Wide

    %=(p p.i.q q.i.q, p.i.t.q q.i.t.q)

####Irregular

    p(p.i.q q.i.q, p.i.t.q q.i.t.q)

###Reduction
None, `%=` is Natural

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%cnts p=wing q=tram]
      ==
    ++  tram  (list ,[p=wing q=twig]) 


###Expansion

###Compilation###
   
You are not expected to understand this:

    ++  mint
      ?-    gen
          [%cnts *]  
        =+  lar=(foil (seek %read p.gen))
        =+  mew=(snub q.gen)
        =-  [(nice p.yom) ?:(=(0 p.q.lar) q.yom [%9 p.q.lar q.yom])]
        ^=  yom
        =+  hej=*(list ,[p=axis q=nock])
        |-  ^-  [p=type q=nock]
        ?~  mew
          [(fire q.q.lar) (hike p.lar hej)]
        =+  zil=^$(gen q.i.mew, gol %noun)
        =+  wip=(tock p.i.mew p.zil q.q.lar)
        $(mew t.mew, q.q.lar q.wip, hej [[p.wip q.zil] hej])
      ==
    ::
    ++  fino
      |=  [dep=@ud way=?(%read %rite %both %free) cog=term]
      =+  gil=*(set type)
      |-  ^-  [p=@ud q=(unit post)]
      ?+    sut  [dep ~]
          [%bull *]
        ?.  =(cog p.p.sut)
          $(sut q.sut)
        ?.  ?=(0 dep)
          $(dep (dec dep), sut q.sut)
        [0 ~ 1 %2 p.sut q.sut]
      ::
          [%cell *]
        =+  taf=$(sut p.sut)
        ?~  q.taf
          =+  bov=$(dep p.taf, sut q.sut)
          ?~  q.bov
            bov
          [p.bov ~ (peg 3 p.u.q.bov) q.u.q.bov]
        [p.taf ~ (peg 2 p.u.q.taf) q.u.q.taf]
      ::
          [%core *]
        =+  zem=(look cog q.r.q.sut)
        =>  ^+(. ?:(|(=(~ zem) =(0 dep)) . .(dep (dec dep), zem ~)))
        ?^  zem
          [dep ~ 1 [%1 (peg 2 p.u.zem) [[sut(p.q %gold) q.u.zem] ~]]]
        =+  taf=$(sut p.sut)
        ?~  q.taf
          taf
        ?.  (park way p.u.q.taf)
          ~|(%find-park !!)
        [p.taf ~ (peg 3 p.u.q.taf) q.u.q.taf]
      ::
          [%cube *]
        $(sut repo)
      ::
          [%face *]
        ?:  =(cog p.sut)
          ?.  ?=(0 dep)
            [(dec dep) ~]
          [0 ~ 1 %0 q.sut]
        [dep ~]
      ::
          [%fork *]
        ~|  %fork
        ?:  (~(has in gil) q.sut)
          $(sut p.sut)
        ?:  (~(has in gil) p.sut)
          $(sut q.sut)
        =+  [hax=$(sut p.sut) yor=$(sut q.sut)]
        ~|  %find-fork
        ?:  =(hax yor)
          hax
        ?>  &(?=(^ q.hax) ?=(^ q.yor) =(p.hax p.yor) =(p.u.q.hax p.u.q.yor))
        :-   p.hax
        ?-  -.q.u.q.hax
          0  ?>  ?=(0 -.q.u.q.yor)
             [~ p.u.q.hax %0 (fork p.q.u.q.hax p.q.u.q.yor)]
          1  ?>  &(?=(1 -.q.u.q.yor) =(p.q.u.q.yor p.q.u.q.hax))
             [~ p.u.q.hax %1 p.q.u.q.hax (weld q.q.u.q.hax q.q.u.q.yor)]
          2  ?>  ?&  ?=(2 -.q.u.q.yor) 
                     =(p.p.q.u.q.hax p.p.q.u.q.yor)
                     =(q.p.q.u.q.hax q.p.q.u.q.yor)
                     =(r.p.q.u.q.hax r.p.q.u.q.yor)
                 ==
             :*  ~
                 p.u.q.hax
                 %2
                 :*  p.p.q.u.q.hax 
                     q.p.q.u.q.hax 
                     r.p.q.u.q.hax 
                     (fork s.p.q.u.q.hax s.p.q.u.q.yor)
                 ==
                 (fork q.q.u.q.hax q.q.u.q.yor)
             ==
        ==
      ::
          [%hold *]
        ?:  (~(has in gil) sut)
          [dep ~]
        $(gil (~(put in gil) sut), sut repo)
      ==
    ::
    ++  fink
      ~/  %fink
      |=  [dep=@ud way=?(%read %rite %both %free) cog=term]
      ^-  port
      ~_  (dunk 'type')
      ~_  (show [%c 'find-limb'] ?:(=(%$ cog) '$' [%a cog]))
      =+  hoq=(fino dep way cog)
      ?~  q.hoq
        ~|(%find-none !!)
      (flee u.q.hoq)
    ::
    ++  seek
      ~/  %seek
      |=  [way=?(%read %rite %both %free) hyp=wing]
      ^-  port
      ?~  hyp
        [1 %& sut]
      =>  .(i.hyp ?^(i.hyp i.hyp [%| p=0 q=i.hyp]))
      =+  zar=$(hyp t.hyp)
      =+  ^=  syp
          ?-    -.q.zar
              &  p.q.zar
              |  (fire (turn q.q.zar |=([p=type q=foot] [p [%ash ~ 1]])))
          ==
      ?-    i.hyp
          [& *]
        [(peg p.zar p.i.hyp) %& (peek(sut syp) way p.i.hyp)]
      ::
          [| *]
        =>  .(sut syp)
        =+  hud=(fink p.i.hyp way q.i.hyp)
        [(peg p.zar p.hud) q.hud]
      ==
    ::
    ++  snub
      ~/  %snub
      |=  har=(list ,[p=wing q=twig])
      ^-  (list ,[p=wing q=twig])
      (turn har |=([a=wing b=twig] [(flop a) b]))
    ::
    ++  tock
      ~/  %tock
      |=  [peh=wing mur=type men=(list ,[p=type q=foot])]
      ^-  [p=axis q=(list ,[p=type q=foot])]
      =-  [(need p.wib) q.wib]
      ^=  wib
      |-  ^-  [p=(unit axis) q=(list ,[p=type q=foot])]
      ?@  men
        [*(unit axis) ~]
      =+  geq=(tack(sut p.i.men) peh mur)
      =+  mox=$(men t.men)
      [(mate p.mox `_p.mox`[~ p.geq]) [[q.geq q.i.men] q.mox]]
    ::
    ++  fire
      ~/  %fire
      |=  hag=(list ,[p=type q=foot])
      ^-  type
      ?:  ?=([[* [%elm ~ 1]] ~] hag)
        p.i.hag
      :-  %hold
      %+  turn
        hag.$
      |=  [p=type q=foot]
      ?.  ?=([%core *] p)
        ~|(%fire-core !!)
      =+  dox=[%core q.q.p q.p]
      ?:  ?=(%ash -.q)
        ~|  %fire-ash
        ::  ~_  (dunk(sut [%cell q.q.p p.p]) %fire-dry)
        ?>  ?|(!vet (nest(sut q.q.p) & p.p))
        [dox p.q]
      ~|  [%fire-odd -.q]
      ?>  ?=(%elm -.q)
      ~|  %fire-elm
      ::  ~_  (dunk(sut [%cell q.q.p p.p]) %fire-wet)
      ?>  ?|  !vet
              (~(has in rib) [sut dox p.q])
              (mull(sut p, rib (~(put in rib) [sut dox p.q])) %noun dox p.q)
          ==
      [p p.q]
    ::
    ++  foil
      ~/  %foil
      |=  pok=port
      ^-  prop
      ?-  -.q.pok
        &  [p.pok [~ [[p.q.pok [%elm ~ 1]] ~]]]
        |  [p.pok [p.q.pok q.q.pok]]
      ==


##Notes

See the explanation in Chapter 7.


