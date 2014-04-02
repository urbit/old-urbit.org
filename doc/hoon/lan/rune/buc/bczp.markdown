---
layout: subpage
category: buc
title: buczap
---

`$!`, `buczap`, `[%bczp p=base]` is a synthetic hoon that
produces the bunt (default value) for `[%axil p]`.

###Definition###

    ++  twig  
      $%  [%bczp p=base]
      ==
    ++  base  ?([%atom p=odor] %noun %cell %bean %null)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bczp *]
        [%bccb %axil p.gen]
      ==

###Notes###

See the discussion of tiles in chapter 9.
