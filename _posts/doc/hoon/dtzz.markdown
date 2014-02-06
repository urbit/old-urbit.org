---
layout: post
category: doc
title: `dtzz`, `%dtzz`
---

###Synopsis###

`dotzaz`, `[%dtzz p=term q=*]` is a natural hoon that produces an
cubed noun constant of value `q` and odor `p`, if `q` is an atom.

###Definition###

    ++  twig  
      $%  [%dtzz p=term q=*]
      ==

###Irregular forms###

    See chapter 6 for constant forms.

###Compilation###
    
    ++  play
      ?-  gen
        [%dtzz *]  [%cube q.gen ?:(.?(q.gen) %noun [%atom p.gen])]
      ==
    ++  mint
      ?-  gen
        [%dtzz *]  [(nice (play gen)) [%1 q.gen]]
      ==

