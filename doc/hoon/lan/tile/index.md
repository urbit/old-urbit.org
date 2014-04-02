---
layout: subpage
title: Tiles
axis: doc-hoon
categories: lan overview
sort: 2
---

```text  
++  tile  $&  [p=tile q=tile]                           ::  ordered pair
          $%  [%axil p=base]                            ::  base type
              [%bark p=term q=tile]                     ::  name
              [%bush p=tile q=tile]                     ::  pair/tag
              [%fern p=[i=tile t=(list tile)]]          ::  plain selection
              [%herb p=twig]                            ::  function
              [%kelp p=[i=line t=(list line)]]          ::  tag selection
              [%leaf p=term q=@]                        ::  constant atom
              [%reed p=tile q=tile]                     ::  atom/cell
              [%weed p=twig]                            ::  example
          ==  
```          
