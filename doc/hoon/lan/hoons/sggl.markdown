---
layout: subpage
axis: doc-hoon
categories: sig rune
sort: 65
title: siggal
---



#[siggal, `~<`, %sggl](#sggl)

##Syntax

`~<`, `siggal`, `[%sggl p=$|(term [p=term q=twig]) q=twig]` is a
synthetic hoon that applies arbitrary hint `p` to the product of 
`q`.

###Form

####Tall

        `p=%foo`:
      
        ~<  %foo
        q

    `p=[p=%foo q=bar]`:

        ~<  %foo.bar
        q

####Wide

    ~<(%foo q)
    ~<(%foo.bar q)
    
####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
        [%sggl p=$|(term [p=term q=twig]) q=twig]   ::
      $%  [%sggl p=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%sggl *]
        [%tsgl [%sggr p.gen [~ 1]] q.gen]
      ==

##Notes

For some hints we'd rather just wake the hint engine up when the
computation is done.