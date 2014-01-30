---
layout: post
category: doc
title: `dtzy`, `%dtzy`
---

###Synopsis###

`dotzey`, `[dtzy p=term q=@]` is a natural hoon that produces a
non-cubed atomic constant of odor `p` and value `q`.

###Definition###

    ++  twig  
      $%  [%dtzy p=term q=@]
      ==

###Irregular forms###

    See chapter 6 for constant forms.

###Compilation###
    
    ++  play
      ?-  gen
        [%dtzy *]  ?:(=(%f p.gen) ?>((lte q.gen 1) bean) [%atom p.gen])
      ==
    ++  mint
      ?-  gen
        [%dtzy *]  [(nice (play gen)) [%1 q.gen]]
      ==

