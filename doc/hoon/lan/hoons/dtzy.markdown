---
layout: subpage
axis: doc-hoon
categories: dot rune
sort: 48
title: dotzey
---



#[dotzey, %dtzy](#dttr)

`dotzey`, `[%dtzy p=term q=@]` is a natural hoon that produces a non-cubed atomic constant of odor `p` and value `q`.

##Syntax

`dotzay`, `[%dtzy p=term q=@]` is a natural hoon that produces a non-cubed atomic constant of odor p and value q.

###Form

####Tall
None

####Wide
None

####Irregular
See chapter 6 for constant forms.

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%dtzy p=term q=@]
      ==

###Expansion

    ++  play
      ?-  gen
        [%dtzy *]  ?:(=(%f p.gen) ?>((lte q.gen 1) bean) [%atom p.gen])
      ==
    ++  mint
      ?-  gen
        [%dtzy *]  [(nice (play gen)) [%1 q.gen]]
      ==

##Notes
