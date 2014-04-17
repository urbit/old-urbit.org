---
layout: subpage
title: Type
axis: doc-hoon
categories: lan overview
sort: 2
---

#++&nbsp;&nbsp;type —
Everything in Hoon is either a noun or void. `++type` formally defines subsets within the set of all nouns. Every noun has at least one type. A noun that's not within the set of all nouns is `%void` by definition.

###Summary

    ++  type  $|  ?(%noun %void)                            ::  set all or set none
              $%  [%atom p=term]                            ::  number and format
                  [%bull p=twin q=type]                     ::  wing synonym
                  [%cell p=type q=type]                     ::  ordered pair
                  [%core p=type q=coil]                     ::
                  [%cube p=* q=type]                        ::  constant
                  [%face p=term q=type]                     ::  name
                  [%fork p=type q=type]                     ::  union/branch
                  [%hold p=(list ,[p=type q=twig])]         ::  infinite genrator
              ==                                            ::

<h3 id="%atom">%atom</h3>
    [%atom p=term]                            ::  number and format
The set containing all atoms. 

####Examples
    ~waclux-tomwyc/try=> -:!>(42)
    [%atom p='ud']

<h3 id="%bull">%bull</h3>
    [%bull p=twin q=type]                     ::  wing synonym
The set containing all wings.

<h3 id="%cell">%cell</h3>
    [%cell p=type q=type]                     ::  ordered pair
The set containing all cells.

####Examples
    ~talsur-todres/try=> =a [a=1 b=2]
    ~talsur-todres/try=> -:!>(a)
    p=[%cell p=[%face p=%a q=[%atom p=%ud]] q=[%face p=%b q=[%atom p=%ud]]]

<h3 id="%core">%core</h3>
    [%core p=type q=coil]                     ::
The set containing all cores.

<h3 id="%cube">%cube</h3>
    [%cube p=* q=type]                        ::  constant
The set containing all constants.

####Examples
    ~talsur-todres/try=> =a %example
    ~talsur-todres/try=> -:!>(a)
    p=[%cube p=28.548.202.775.017.573 q=[%atom p=%tas]]

<h3 id="%face">%face</h3>
    [%face p=term q=type]                     ::  name
The set containing all labels.

####Examples
    ~talsur-todres/try=> =a [a=1 b=[c=3 d=4]]
    ~talsur-todres/try=> -:!>(+.a)
    p=[%face p=%b q=[%cell p=[%face p=%c q=[%atom p=%ud]] q=[%face p=%d q=[%atom p=%ud]]]]


<h3 id="%fork">%fork</h3>
    [%fork p=type q=type]                     ::  union/branch
The set containing all unions.

####Examples
    ~talsur-todres/try=> =a ?:(& %yes %no)
    ~talsur-todres/try=> -:!>(a)
    p=[%fork p=[%cube p=7.562.617 q=[%atom p=%tas]] q=[%cube p=28.526 q=[%atom p=%tas]]]

<h3 id="%hold">%hold</h3>
    [%hold p=(list ,[p=type q=twig])]         ::  infinite 
The set containing other sets.