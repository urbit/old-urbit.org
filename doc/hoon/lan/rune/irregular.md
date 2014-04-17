---
layout: subpage
title: Rune - Irregular Forms
axis: doc-hoon
categories: lan overview
sort: 6
---

## Runes

Hoon is free of reserved words. Instead, we use digraph pairs such as `|=` and call them runes. 

Some runes have irregular forms as a single character for convenience, and these are listed here. For the complete index of runes, check out the [index](/doc/hoon/lan/rune/).

This library is a work in progress. Feedback and corrections are welcome. Pull requests are encouraged. The repo for this site lives [here](https://github.com/urbit/urbit.github.io). We would love your help in making this reference useful.

###[buccom](/doc/hoon/lan/rune/#buccom)#
    ,p           $,(p)

###[buctar](/doc/hoon/lan/rune/#buctar)#
    *p           $*(p)

###[buccab](/doc/hoon/lan/rune/#buccab)#
    _p           $_(p)

###[bucpat](/doc/hoon/lan/rune/#bucpat)#
    p@q          $@(p q)

###[wutzap](/doc/hoon/lan/rune/#wutzap)#
    !p           ?!(p)

###[wutpam](/doc/hoon/lan/rune/#wutpam)#
    &(list)      ?&(list)

###[wutbar](/doc/hoon/lan/rune/#wutbar)#
    |(list)      ?|(list)

###[kethep](/doc/hoon/lan/rune/#kethep)#
    `p`q         ^-(p q)

###[kettis](/doc/hoon/lan/rune/#kettis)#
    p=q          ^=(p q)

###[colsig](/doc/hoon/lan/rune/#colsig)#
    ~[list]      :~(list)

###[colhep](/doc/hoon/lan/rune/#colhep)#
    [p q]        :-(p)

###[coltar](/doc/hoon/lan/rune/#coltar)#
    [list]       :*(p)

###[colsig](/doc/hoon/lan/rune/#colsig)#
    %[list]      :%(p)

###[dotlus](/doc/hoon/lan/rune/#dotlus)#
    +(p)         .+(p)

###[dottis](/doc/hoon/lan/rune/#dottis)#
    =(p q)       .=(p)

###[tisgal](/doc/hoon/lan/rune/#tisgal)#
    p:q          =<(p q)

###[centis](/doc/hoon/lan/rune/#centis)#
    p(list)      %=(p list)

###[cenhep](/doc/hoon/lan/rune/#cenhep)#
    (p list)     %-(p)

###[censig](/doc/hoon/lan/rune/#censig)#
    ~(p q r)     %~(p q r)

###[haxgal](/doc/hoon/lan/rune/#haxgal)#
    >list<       #<(p)

###[haxgar](/doc/hoon/lan/rune/#haxgar)#
    <list>       #>(p)
    
###[semcol](/doc/hoon/lan/rune/#semcol)#
    :(p list)    ;:(p list)