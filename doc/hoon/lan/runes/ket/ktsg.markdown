---
layout: subpage
category: ket
title: ketsig
---

`^~`, `ketsig`, `[%ktsg p=twig]` is a natural hoon that
tries to execute `p` statically at compile time; if this fails,
`p` remains dynamic.

###Definition###

    ++  twig  
      $%  [%ktsg p=twig]
      ==

###Regular form (tall)###

    ^~  a

###Regular form (wide)###

    ^~(a)

###Compilation###
    
    ++  mint
      ?-    gen
          [%ktsg *]  
        =+  nef=$(gen p.gen)
        =+  moc=(mink [burn q.nef] |=(* ~))
        [p.nef ?:(?=(0 -.moc) [%1 p.moc] q.nef)]
      ==
    ++  burn
      =+  gil=*(set type)
      |-  ^-  *
      ?-    sut
          [%atom *]   0
          [%bull *]   ~|(%burn-bull !!)
          [%cell *]   [$(sut p.sut) $(sut q.sut)]
          [%core *]   [p.r.q.sut $(sut p.sut)]
          [%cube *]   p.sut
          [%face *]   $(sut repo)
          [%fork *]   $(sut p.sut)
          [%hold *]   ?:  (~(has in gil) sut)
                        ~_  (dunk %type)
                      ~|(%burn-loop !!)
                      $(sut repo, gil (~(put in gil) sut))
          %noun       0
          %void       ~|(%burn-void !!)
      ==

###Notes###

To fold constants with `^~`, we use the crudest possible tools.
We simply compute the best plausible constant noun that fits the
subject, and apply the formula of `p` to it.

One common problem with `^~` is that while compiling the arms of
a core, we do not have the battery of the core as a constant.
We simply put `0` in our subject instead.  The result is that
anything which uses the core crashes, and `^~` falls back to the
dynamic formula.  The usual workaround, which may be a good idea,
is to use two layers of reef and put tile arms in an inner core.

(This circularity could be defeated by some kind of iteration,
but it's not clear that we want the complexity right now.)
