---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 102
title: wuttis
---



#[wuttis %wtts](#wtts)

##Syntax

`?=`, `wuttis`, `[%wtts p=tile q=wing]` is a natural hoon that
produces true if the leg at wing `q` is in tile `p`.

###Form

####Tall

    ?=  p
        q

####Wide

    ?=(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtts p=tile q=wing]
      ==

###Expansion

    ++  mint
      ?-    gen
          [%wtts *]  
        :-  (nice bean)
        %-  fish(sut (play ~(bunt al p.gen))) 
        (cove q:$(gen [%cnzz q.gen], gol %noun))
      ==
    ::
    ++  cove
      |=  nug=nock
      ?-    nug
          [0 *]   p.nug
          [10 *]  $(nug q.nug)
          *       ~|([%cove nug] !!)
      ==
    ::
    ++  fish
      ~/  %fish
      |=  axe=axis
      =+  vot=*(set type)
      |-  ^-  nock
      ?-  sut
          %void       [%1 1]
          %noun       [%1 0]
          [%atom *]   (flip [%3 %0 axe])
          [%bull *]   ~|(%bull-fish !!)
          [%cell *]
        %+  flan
          [%3 %0 axe]
        (flan $(sut p.sut, axe (peg axe 2)) $(sut q.sut, axe (peg axe 3)))
      ::
          [%core *]   [%0 0]
          [%cube *]   [%5 [%1 p.sut] [%0 axe]]
          [%face *]   $(sut q.sut)
          [%fork *]   (flor $(sut p.sut) $(sut q.sut))
          [%hold *]
        ?:  (~(has in vot) sut)
          [%0 0]
        =>  %=(. vot (~(put in vot) sut))
        $(sut repo)
      ==
    ::
    ++  flor
      ~/  %flor
      |=  [bos=nock nif=nock]
      ^-  nock
      ?-  bos
          [1 1]   nif
          [1 0]   bos
          *
        ?-  nif
            [1 1]   bos
            [1 0]   nif
            *       [%6 bos [%1 0] nif]
        ==
      ==
    ::
    ++  flan
      ~/  %flan
      |=  [bos=nock nif=nock]
      ^-  nock
      ?-    bos
          [1 1]   bos
          [1 0]   nif
          *
        ?-    nif
            [1 1]   nif
            [1 0]   bos
            *       [%6 bos nif [%1 1]]
        ==
      ==

##Notes

Note that as presently implemented this is a type operation, not
a tile operation; we just bunt tile `p` and produce a formula
that detects that the leg at `q` matches its type.  Future
versions may generate directly from the tile.