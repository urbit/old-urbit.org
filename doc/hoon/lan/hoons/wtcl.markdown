---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 87
title: wutcol
---



#[wutcl, %wtcl](#wtcl)

##Syntax

`?:`, `wutcol`, `[%wtcl p=twig q=twig r=twig]` is a natural hoon
that produces `q` if `p` is yes (`&`, `0`), or `r` if `p` is no
(`|`, 1).

###Form

####Tall

    ?:  p
      q
    r

####Wide

    ?:(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtcl p=twig q=twig r=twig]
      ==


###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wtcl *]
        =+  nor=$(gen p.gen, gol bean)
        =+  fex=(gain p.gen)
        =+  wux=(lose p.gen)
        =+  ^=  duy
            ?:  =(%void fex)
              ?:(=(%void wux) [%0 0] [%1 1])
            ?:(=(%void wux) [%1 0] q.nor)
        =+  hiq=$(sut fex, gen q.gen)
        =+  ran=$(sut wux, gen r.gen)
        [(fork p.hiq p.ran) (cond duy q.hiq q.ran)]
      ==
    ::
    ++  gain
      |=  gen=twig  ^-  type
      (chip & gen)
    ::
    ++  lose
      |=  gen=twig  ^-  type
      (chip | gen)
    ::
    ++  chip
      ~/  %chip
      |=  [way=? gen=twig]  ^-  type
      ?:  ?=([%wtts *] gen)
        (cool way q.gen (play ~(bunt al p.gen)))
      ?:  ?&(way ?=([%wtpm *] gen))
        |-(?~(p.gen sut $(p.gen t.p.gen, sut ^$(gen i.p.gen))))
      ?:  ?&(!way ?=([%wtbr *] gen))
        |-(?~(p.gen sut $(p.gen t.p.gen, sut ^$(gen i.p.gen))))
      =+  neg=~(open ap gen)
      ?:(=(neg gen) sut $(gen neg))
    ::
    ++  cool
      |=  [pol=? hyp=wing ref=type]
      ^-  type
      =+  peh=`wing`(flop hyp)
      |-  ^-  type
      ?~  peh
        ?:(pol (fuse ref) (crop ref))
      =>  .(i.peh ?^(i.peh i.peh [%| p=0 q=i.peh]))
      =+  ^=  poz  ^-  post
          ?-  -.i.peh
            &  [p.i.peh %& (peek %both p.i.peh)]
            |  (finq p.i.peh %both q.i.peh)
          ==
      |-  ^-  type
      ?:  =(1 p.poz)
        ?-  -.q.poz
          0  ?-  -.i.peh
                &  ^$(peh t.peh)
                |  (face q.i.peh ^$(peh t.peh, sut p.q.poz))
             ==
          1  ^$(peh t.peh)
          2  %+  bull 
               [p.p.q.poz q.p.q.poz r.p.q.poz ^$(peh t.peh, sut s.p.q.poz)] 
             q.q.poz
        ==
      =+  [now=(cap p.poz) lat=(mas p.poz)]
      =+  vil=*(set type)
      |-  ^-  type
      ?-    sut
          [%atom *]   %void
          [%bull *]   (reco |=(p=type (bull p.sut ^$(sut p))))
          [%cell *]
        ?:  =(2 now)
          (cell ^$(p.poz lat, sut p.sut) q.sut)
        (cell p.sut ^$(p.poz lat, sut q.sut))
      ::
          [%core *]   ?.(=(3 now) sut (core ^$(p.poz lat, sut p.sut) q.sut))
          [%cube *]   (reco |=(p=type ^$(sut p)))
          [%face *]   (reco |=(p=type (face p.sut ^$(sut p))))
          [%fork *]
        ?:  (~(has in vil) sut)
          %void
        =>  .(vil (~(put in vil) sut))
        (fork $(sut p.sut) $(sut q.sut))
      ::
          [%hold *]   (reco |=(p=type ^$(sut p)))
          %noun       (reco |=(p=type ^$(sut p)))
          %void       %void
      ==
    ::
    ++  cond
      ~/  %cond
      |=  [pex=nock yom=nock woq=nock]
      ^-  nock
      ?-  pex
        [1 0]  yom
        [1 1]  woq
        *      [%6 pex yom woq]
      ==

##Notes

It's not unheard of to say `?:` as "if."
