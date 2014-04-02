---
layout: subpage
category: buc
title: buccab
---

`$=`, `bucts`, is a tile hoon that produces a `%bark`:

    [%bark p=term q=tile] 

A %bark wraps a name around a tile. `a=*` parses as `[%bark %a %noun]`.

###Definition###

    ++  tile  $&  [p=tile q=tile]                           ::  ordered pair
              $%  [%bark p=term q=tile]                     ::  name
              ==

###Regular form (tall)###

    $=  p
    q

###Notes###

See the discussion of tiles in chapter 9.
