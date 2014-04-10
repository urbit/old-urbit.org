---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 18
title: barket
---


#[barket, `|^`, %brkt](#brkt)

##Syntax

`|^`, `barket`, `[%brkt p=twig q=(map term foot)]` is a synthetic hoon
that produces a `%gold` book with arms `q`, plus `p` as `%$`, and 
kicks it.

###Form

`p` is a twig
`q` is a map
`p.n.q` is a term
`q.n.q` is a twig

####Tall
  
    |^  p
      ++  p.n.q
        q.n.q
    --

####Wide
None

####Irregular
None

###Reduction

    =<  $
    |%
    ++  p.n.q
      q.n.q
    ++  $
      p
    --

###Examples

In ++mint, |^ creates a book whose `$` arm compiles twigs to Nock, and whose other arms contain useful expressions for that compilation.

##Semantics

`%brkt` is a twig.

###Definition###

    ++  twig  
      $%  [%brkt p=twig q=(map term foot)]
      ==


    ++  map  |*  [a=_,* b=_,*]                              ::  associative array
             $|(~ [n=[p=a q=b] l=(map a b) r=(map a b)])    ::
 
    ++  term  ,@tas                                         ::

    ++  foot  $%  [%ash p=twig]                             ::
                  [%elm p=twig]                             ::
              ==                                            ::


###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brkt *]
        [%tsgr [%brcn (~(put by q.gen) %$ [%ash p.gen])] [%cnzy %$]]
      ==

###Notes###

See the bestiary of cores in Chapter 11.

`|^` is kind of pointless and may be deprecated in future releases.
