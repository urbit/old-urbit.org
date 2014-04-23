---
layout: subpage
axis: doc-hoon
categories: buc twig
sort: 12
title: buczap
---


#buczap `$!` %bczp

##Syntax

`$!`, `buczap`, `[%bczp p=base]` is an synthetic internal twig that
produces the bunt (default value) for `[%axil p]`.

###Form

None, `buczap` is only used as a shorthand for macro expansion in ++open.

####Tall
None

####Wide
None

####Irregular
None

###Reduction
None

###Examples
None

##Semantics
%bczp is a ++twig.

###Definition

    ++  twig  
      $%  [%bczp p=base]
      ==
    ++  base  ?([%atom p=odor] %noun %cell %bean %null)

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%bczp *]
        [%bccb %axil p.gen]
      ==

##Notes
See the discussion of tiles in chapter 9.
