---
layout: post
category: doc
title: `?~`, `wutsig`, `%wtsg`
---

###Synopsis###

`?~`, `wutsig`, `[%wtsg p=wing q=twig r=twig]` is a synthetic hoon 
that produces `q` if `p` is `~`, `r` otherwise.

###Definition###

    ++  twig  
      $%  [%wtsg p=wing q=twig r=twig]
      ==

###Regular form (tall)###

    ?~  p
      q
    r

###Regular form (wide)###

    ?~(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtsg *]
        [%wtcl [%wtts [%axil %null] p.gen] q.gen r.gen]
      ==

