---
layout: subpage
category: buc
title: bucwut
---

`$?`, `bucwut`, is a tile hoon that produces a `%fern`:

    [%fern p=[i=tile t=(list tile)]]  

A non-empty list of cases; its icon is naturally a %fork. The programmer is responsible for ensuring that the cases are actually orthogonal (unlike with the structured forks, %bush, %kelp and %reed). A good general practice is to use ferns only with leaves (see below).


###Definition###

  ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
            $%  [%fern p=[i=tile t=(list tile)]]          ::  plain selection
            ==

###Regular form (tall)###

    $?  %foo
        %bar
    ==

###Irregular form (wide)###

    ?(p q)

###Notes###

See the discussion of tiles in chapter 9.
