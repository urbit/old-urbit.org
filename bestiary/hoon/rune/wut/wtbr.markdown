---
layout: subpage
category: wut
title: wutbar
---

`?|`, `wutbar`, `[%wtbr p=tusk]` is a synthetic hoon that
computes the "or" of the loobeans in `p`.

###Definition###

    ++  twig  
      $%  [%wtbr p=tusk]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

    ?|  i.p
        i.t.p
        i.t.t.p
    ==

###Regular form (wide)###

    ?|(i.p i.t.p i.t.t.p)

###Irregular form###

    |(i.p i.t.p i.t.t.p)

###Expansion###

<div class="codeblock">
  <code>++  open
      ^-  twig
      ?-    gen
          [%wtbr *]
        |-
        ?~(p.gen [<a href="/bestiary/hoon/rune/dot/dtzz/">%dtzz</a> %f 1] [<a href="/bestiary/hoon/rune/wut/wtcl/">%wtcl</a> i.p.gen [<a href="/bestiary/hoon/rune/dot/dtzz/">%dtzz</a> %f 0] $(p.gen t.p.gen)])
      ==
  </code>
</div>

###Notes###

Short-circuiting and type inference work as expected in `?|`.

