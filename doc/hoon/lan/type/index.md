---
layout: subpage
title: Type
axis: doc-hoon
categories: lan overview
sort: 2
---

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
