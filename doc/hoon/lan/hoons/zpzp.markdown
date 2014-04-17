---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 111
title: zapzap
---



#[zapzap %zpzp](#zpzp)

##Syntax

    ++  twig  
      $%  [%zpzp p=~]
      ==

###Form

####Tall

    None

####Wide

    !!

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%zpzp p=~]
      ==

###Expansion

    ++  mint
      ?-  gen
        [%zpzp *]  [%void [%0 0]]
      ==

##Notes

Crashing in Hoon is the normal way to respond to an error.