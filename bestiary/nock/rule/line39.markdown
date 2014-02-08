---
layout: subpage
category: nock
title: crash defaults
---

```text
    10 ::    +[a b]           +[a b]
    ...
    14 ::    =a               =a
    ...
    21 ::    /a               /a
    ...
    39 ::    *a               *a
```
    
The nock function is defined for every noun, but on many nouns it does nothing
useful.  For instance, if `a` is an atom, `*a` reduces to... `*a`.  In theory,
this means that Nock spins forever in an infinite loop.  In other words, Nock
produces no result - and in practice, your interpreter will stop.

(Another way to see this is that Nock has "crash-only" semantics.  There is no
exception mechanism.  The only way to catch Nock errors is to simulate Nock in
a higher-level virtual Nock - which, in fact, we do all the time.  A simulator
(or a practical low-level interpreter) can report, out of band, that Nock would
not terminate.  It cannot recognize all infinite loops, of course, but it can
catch the obvious ones - like `*42`.)
