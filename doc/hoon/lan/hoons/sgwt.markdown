---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 70
title: sigwut
---



#[sigwut, `~?`, %sgwt](#sgwt)

##Syntax

`~?`, `sigwut`, `[%sgwt p=@ud q=twig r=twig s=twig]` is a
synthetic hoon with the same hint effect, printing `r`,
as `[%sgpm p r s]`, iff `q` produces yes.

###Form

####Tall

    Priority 0 (debug):

        ~&  q
        r

    Priority 1 (notice):

        ~&  >  q
        r

    Priority 2 (warning):

        ~&  >>  q
        r

    Priority 3 (alarm):

        ~&  >>>  q
        r

####Wide

    ~&(>> q r)


####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%sgwt p=@ud q=twig r=twig s=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%sgwt *]
        [%tsgl s.gen %wtdt q.gen [~ 1] %sgpm p.gen r.gen [~ 1]]
      ==

##Notes

We often want to print a value for debugging, but it's also easy
to be overwhelmed with unconditional printfs.ll lets the
interpreter discard the copy right away.