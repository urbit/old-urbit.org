---
layout: subpage
title: Types
axis: doc-hoon
categories: lan
sort: 3
---

```
++  type  $|  ?(%noun %void)                            ::
          $%  [%atom p=term]                            ::
              [%bull p=twin q=type]                     ::
              [%cell p=type q=type]                     ::
              [%core p=type q=coil]                     ::
              [%cube p=* q=type]                        ::
              [%face p=term q=type]                     ::
              [%fork p=type q=type]                     ::
              [%hold p=(list ,[p=type q=twig])]         ::
          ==           
```
