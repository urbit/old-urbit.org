---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 1
title: buccab
---

#buccab `$_` %bccb

##Syntax

`$_`, `buccab`, `[%bccb p=tile]` is a synthetic hoon that
produces the bunt (default value) for `p`.

##Form

`p` is a tile.

####Tall

    $_  p

####Wide

    $_(p)

####Irregular

    _p

###Reduction

    $_  p

reduces to

    ~(bunt al p)

###Examples

##Semantics

`%bccb` is a twig.

###Definition###

    ++  twig  
      $%  [%bccb p=tile]
      ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bccb *]
        ~(bunt al p.gen)
      ==

    ++  al
      =+  [nag=`*`& gom=`axis`1]
      |_  sec=tile
      :::: 
      ++  bunt
        |-  ^-  twig
        ?-    sec
            [^ *]
          [$(sec p.sec) $(sec q.sec)]
        ::
            [%axil *]
          ?-  p.sec
            [%atom *]  [%dtzy p.p.sec 0]
            %noun      [%dttr [%dtzz %$ 0] [[%dtzz %$ 0] [%dtzz %$ 1]]]
            %cell      =+(nec=$(sec [%axil %noun]) [nec nec])
            %bean      [%dtts [%dtzz %$ 0] [%dtzz %$ 0]]
            %null      [%dtzz %n %$]
          ==
        ::
            [%bark *]
          [%ktts p.sec $(sec q.sec)]
        ::
            [%bush *]
          [%wtcl [%bczp %bean] $(sec p.sec) $(sec q.sec)]
        ::
            [%fern *]
          |-  ^-  twig
          ?@  t.p.sec
            ^$(sec i.p.sec)
          [%wtcl [%bczp %bean] ^$(sec i.p.sec) $(p.sec t.p.sec)]
        ::
            [%herb *]
          (home [%tsgl [%cnzy %$] p.sec])
        ::
            [%kelp *]
          |-  ^-  twig
          ?@  t.p.sec
            ^$(sec i.p.sec)
          [%wtcl [%bczp %bean] ^$(sec i.p.sec) $(p.sec t.p.sec)]
        ::
            [%leaf *]
          [%dtzz p.sec q.sec]
        ::
            [%reed *]
          [%wtcl [%bczp %bean] $(sec p.sec) $(sec q.sec)]
        ::
            [%weed *]
          (home p.sec)
        ==


###Notes###

Bunting a tile - if sec is a tile, ~(bunt al sec) produces its bunt - makes a twig that creates a blank default example of the tile's icon.

Bunting is actually the most common use of a tile. Consider the gates we've just been defining - how do we build a gate? With

++  deq
  =+  x=0
  |.  
  =+  y=0
  |-  
  ?:  =(x +(y))
    y
  $(y +(y))

The value x=0 is a useless default. It's in our gate only because the gate is built first, then modified with the real sample. Accordingly, in practice to build a gate we use the synthetic hoon |= (bartis, %brts), which is defined as

++  twig  $%  [%brts p=tile q=hoon]
          ==
and

++  open
  ^-  twig
  ?-    gen
    [%bctr *]  [%ktsg ~(bunt al p.gen)]
    [%brcb *]  [%tsls [%bctr p.gen] [%brcn q.gen]]
    [%brts *]  [%brcb p.gen (~(put by *(map term foot)) %$ [%ash q.gen])]
  ==

(The only hoon we haven't met here is ^~ (ketsig, %ktsg), which tells the compiler to compute a constant expression at compile time. Obviously, the default sample in a gate should under almost every circumstance be a constant.)

With |= we have:

++  deq
  |=  x=@
  =+  y=0
  |-  
  ?:  =(x +(y))
    y
  $(y +(y))
or if we prefer

++  deq  |=(x=@ =+(y=0 |-(?:(=(x +(y)) y $(y +(y))))))
What is x=@? A tile. And the tile in |= is always bunted to create the default sample.

Furthermore, it's wrong to say that the default sample is useless. It generates a corresponding default product. It is perfectly legitimate to simply apply a gate, even a previously unviolated gate, without changing the sample at all.

For example, one type of tile is simply a gate. When we bunt such a gate, we have no choice but to produce the default product. Thus any gate arm that wants to be used as a tile has the responsibility to produce a useful default product.


