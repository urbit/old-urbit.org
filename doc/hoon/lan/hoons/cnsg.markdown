---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 38
title: censig
---



`%~`, `censig`, `[%cnsg p=wing q=twig r=twig]` is a synthetic
hoon that pulls `p` from the tray `q` with its sample set to `r`.

###Definition###

    ++  twig  
      $%  [%cnsg p=twig]
      ==

###Regular form (tall)###

Kingside:

    %~  p
      q
    r

Queenside:

    %~  p  q
    r

###Regular form (wide)###

    %~(p q r)

###Irregular form###

    ~(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnsg *]
        [%cntr p.gen q.gen [[[[%& 6] ~] r.gen] ~]]
      ==
