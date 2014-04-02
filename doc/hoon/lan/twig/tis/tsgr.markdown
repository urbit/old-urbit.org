---
layout: subpage
category: tis
title: tisgar
---

`=>`, `tisgar`, `[%tsgr p=twig q=twig]` is a natural hoon that
uses the product of `p` as the subject of `q`.

###Definition###

    ++  twig  
      $%  [%tsgr p=twig q=twig]
      ==

###Regular form (tall)###

    =>  p
    q

###Regular form (wide)###

    =>(p q)

###Compilation###
    
    ++  mint
      ?-    gen
          [%tsgr *]  
        =+  fid=$(gen p.gen, gol %noun)
        =+  dov=$(sut p.fid, gen q.gen)
        [p.dov (comb q.fid q.dov)]
      ==

    ++  comb
      |=  [mal=nock buz=nock]
      ^-  nock
      ?:  ?&(?=([0 *] mal) !=(0 p.mal))
        ?:  ?&(?=([0 *] buz) !=(0 p.buz))
          [%0 (peg p.mal p.buz)]
        ?:  ?=([2 [0 *] [0 *]] buz)
          [%2 [%0 (peg p.mal p.p.buz)] [%0 (peg p.mal p.q.buz)]]
        [%7 mal buz]
      ?:  ?=([^ [0 1]] mal)
        [%8 p.mal buz]
      ?:  =([0 1] buz)
        mal
      [%7 mal buz]

###Notes###

Observe that `=>` strives to be at least slightly non-naive in
composing Nock formulas.  This is why `=+` can be a synthetic
hoon, despite matching Nock `8`.
