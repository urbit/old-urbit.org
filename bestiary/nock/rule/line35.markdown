---
layout: subpage
category: nock
title: nock 9, firearm
---


**`9` Reduction:**

```text
35 :: *[a 9 b c]        *[a 7 c [2 [0 1] [0 b]]]

*[a 7 c [2 [0 1] [0 b]]]

33r ::     *[a 7 b c]         *[*[a b] c]

*[*[a c] [2 [0 1] [0 b]]]

27 ::     *[a 2 b c]        *[*[a b] *[a c]]

*[*[*[a c] [0 1]] *[*[a c] [0 b]]]

25 ::     *[a 0 b]          /[b a]
```
**`9` Reduced:**    

```text
35r ::     *[a 9 b c]        *[*[a c] *[*[a c] 0 b]] 
```

`9` is a calling convention.  With `c`, we produce a noun which contains both
code and data - a _core_.  We use this core as the subject, and apply the
formula within it at slot `b`.

A _core_ is a construct which is behind any kind of interesting control flow in
Hoon.  Of course, the Nock programmer is not constrained to use the same
techniques as the Hoon compiler, but it is probably a good idea. 

In Hoon, all the flow structures from your old life as an Earth programmer
become cores.  Functions and/or closures are cores, objects are cores modules
are cores, even loops are cores.

The core is just a cell whose tail is data (possibly containing other cores)
and whose head is code (containing one or more formulas).  The tail is the
_payload_ and the head is the _battery_.  Hence your core is

```text
[battery payload]
```
To activate a core, pick a formula out of the battery, and use the entire core
(_not_ just the payload) as the subject.  

(A core formula is called an _arm_.  An arm is almost like an object-oriented
method, but not quite - a method would be an arm that produces a function on an
argument.  The arm is just a function of the core, ie, a computed attribute.)


