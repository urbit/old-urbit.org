---
layout: subpage
title: Operator 9
---

```text
9r ::     *[a 9 b c]        *[*[a c] *[*[a c] 0 b]] 
```


**`9` Reduction:**

```text

*[p 9 q r]

35 :: *[a 9 b c]        *[a 7 c [2 [0 1] [0 b]]]

*[p 7 r [2 [0 1] [0 q]]]

33r ::     *[a 7 b c]         *[*[a b] c]

*[*[p r] [2 [0 1] [0 q]]]

27 ::     *[a 2 b c]        *[*[a b] *[a c]]

*[*[*[p r] [0 1]] *[*[p r] [0 q]]]

25 ::     *[a 0 b]          /[b a]

*[*[p r] *[*[p r] 0 q]] 

```
**`9` Reduced:**    

```text
35r ::     *[a 9 b c]        *[*[a c] *[*[a c] 0 b]] 
```


We'll discuss what Nock 9 does in the next chapter, when we introduce how to
use _cores_, which are subjects containing both code and data.  If you have a
really fine instinctive sense of Nock, you might understand what `9` is for.

Succinctly, we use Nock 9 to call a formulas held inside of the subject itself,
and apply them to the subject. If you've been wondering how to write Nock
expressions that loop, this is how.
