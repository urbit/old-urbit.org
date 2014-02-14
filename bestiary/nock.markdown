---
layout: subpage
title: Nock Reference
---

##Nock Specification:##

```text
1  ::    A noun is an atom or a cell.
2  ::    An atom is a natural number.
3  ::    A cell is an ordered pair of nouns.
4  ::
5  ::    nock(a)          *a
6  ::    [a b c]          [a [b c]]
7  ::
8  ::    ?[a b]           0
9  ::    ?a               1
10 ::    +[a b]           +[a b]
11 ::    +a               1 + a
12 ::    =[a a]           0
13 ::    =[a b]           1
14 ::    =a               =a
15 ::
16 ::    /[1 a]           a
17 ::    /[2 a b]         a
18 ::    /[3 a b]         b
19 ::    /[(a + a) b]     /[2 /[a b]]
20 ::    /[(a + a + 1) b] /[3 /[a b]]
21 ::    /a               /a
22 ::
23 ::    *[a [b c] d]     [*[a b c] *[a d]]
24 ::
25 ::    *[a 0 b]         /[b a]
26 ::    *[a 1 b]         b
27 ::    *[a 2 b c]       *[*[a b] *[a c]]
28 ::    *[a 3 b]         ?*[a b]
29 ::    *[a 4 b]         +*[a b]
30 ::    *[a 5 b]         =*[a b]
31 ::
32 ::    *[a 6 b c d]     *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]
33 ::    *[a 7 b c]       *[a 2 b 1 c]
34 ::    *[a 8 b c]       *[a 7 [[7 [0 1] b] 0 1] c]
35 ::    *[a 9 b c]       *[a 7 c 2 [0 1] 0 b]
36 ::    *[a 10 [b c] d]  *[a 8 c 7 [0 3] d]
37 ::    *[a 10 b c]      *[a c]
38 ::
39 ::    *a               *a
```

---

##Structures##

```text
1  ::    A noun is an atom or a cell.
2  ::    An atom is a natural number.
3  ::    A cell is an ordered pair of nouns.
```
Nouns are the dumbest data model ever.  Nouns make JSON look like XML and XML
look like ASN.1.  It may also remind you of Lisp's S-expressions - you can
think of nouns as "S-expressions without the S."

To be exact, a noun _is_ an S-expression, except that classic S-expressions
have multiple atom types ("S" is for "symbol").  Since Nock is designed to be
used with a higher-level type system (such as Hoon's), it does not need
low-level types.  An atom is just an unsigned integer of any size.

For instance, it's common to represent strings (or even whole text files) as
atoms, arranging them LSB first - so "foo" becomes `0x6f6f66`.  How do we know
to print this as "foo", not `0x6f6f66`?  We need external information - such as
a Hoon type.  Similarly, other common atomic types - signed integers, floating
point, etc
- are all straightforward to map into atoms.

It's also important to note that, unlike Lisp, Nock cannot create cyclical data
structures.  It is normal and common for nouns in a Nock runtime system to have
acyclic structure - shared subtrees.  But there is no Nock computation that can
make a child point to its parent.  One consequence: Nock has no garbage
collector.  (Nor can dag structure be detected, as with Lisp `eq`.)

There is also no single syntax for nouns.  If you have nouns you have Nock; if
you have Nock you have Hoon; if you have Hoon, you can write whatever parser
you like.

---

##The Nock Function


```text
5  ::    nock(a)           *a
```
Nock is a pure (stateless) function from noun to noun.  In our pseudocode (and
only in our pseudocode) we express this with the prefix operator `*`.

Normally `a` in `nock(a)` is a cell `[s f]`, or as we say

```text
[subject formula]
```
Intuitively, the formula is your function and the subject is its argument.  We
call them something different because Hoon, or any other high-level language
built on Nock, will build its own function calling convention which *does not*
map directly to `*[subject formula]`.


---

##Bracket Grouping

```text
6  ::    [a b c]           [a [b c]]
```
Ie, brackets (in our pseudocode, as in Hoon) associate to the right.  For those
with Lisp experience, it's important to note that Nock and Hoon use tuples or
"improper lists" much more heavily than Lisp.  The list terminator, normally 0,
is never automatic.  So the Lisp list 

```text
(a b c)
```
becomes the Nock noun

```text
[a b c 0]
```
which is equivalent to

```text
[a [b [c 0]]]
```
Note that we can and do use unnecessary brackets anyway, for
emphasis.


---

##Axiomatic Functions

```text
8  ::    ?[a b]           0
9  ::    ?a               1
10 ::    +[a b]           +[a b]
11 ::    +a               1 + a
12 ::    =[a a]           0
13 ::    =[a b]           1
```
Here we define more axiomatic pseudocode functions, which we'll use in reductions further
down.  So far we have four built-in functions: `*` meaning Nock itself, `?`
testing whether a noun is a cell or an atom, `+` incrementing an atom, and `=`
testing for equality.  Again, no rocket science here.

We should note that in Nock and Hoon, `0` (pronounced "yes") is true, and `1`
("no") is false.  Why?  It's fresh, it's different, it's new.  And it's
annoying.  And it keeps you on your toes.  And it's also just intuitively
right.

---

##Noun Trees


```text
16 ::    /[1 a]           a
17 ::    /[2 a b]         a
18 ::    /[3 a b]         b
19 ::    /[(a + a) b]     /[2 /[a b]]
20 ::    /[(a + a + 1) b] /[3 /[a b]]
```
Slightly more interesting is our tree numbering.  Every noun is of course a
tree.  The `/`, or axis, operator imposes an address space on that tree,
mapping every nonzero atom to a tree position.

1 is the root.  The head of every node `n` is `2n`; the tail is `2n+1`.  Thus a
simple tree:

```text
     1
  2      3
4   5  6   7
         14 15
```
If the value of every leaf is its tree address, this tree is

```text
  [[4 5] [6 14 15]]
```

---

##Autocons

```text
23 ::    *[a [b c] d]      [*[a b c] *[a d]]
```

Since Nock of an atom just crashes, the practical domain of the Nock function
is always a cell.  Conventionally, the head of this cell is the "subject," the
tail is the "formula," and the result of Nocking it is the "product."
Basically, the subject is your data and the formula is your code.

We could write line 23 less formally:

```text
*[subject [formula-x formula-y]]
=>  [*[subject formula-x] *[subject formula-y]]
```
In other words, if you have two Nock formulas `x` and `y`, a formula that
computes the pair of them is just `[x y]`.  We can recognize this because no
atom is a valid formula, and every formula that _does not_ use line 19 has an
atomic head.

If you know Lisp, you can think of this feature as a sort of "implicit cons."
Where in Lisp you would write `(cons x y)`, in Nock you write `[x y]`.

---

##Axis Operator

```text
25 ::    *[a 0 b]         /[b a]
```

Line 25 is Nock's tree address or axis operator, using the tree addressing structure defined in lines 16 through 20. `*[a 0 b]` simply returns the value of the part of a at axis b.   

---

##Constant


```text
26 ::    *[a 1 b]          b
```
`1` is the constant operator.  It produces its argument without
reference to the subject. 

---

##Recursion

```text
27 ::    *[a 2 b c]        *[*[a b] *[a c]]
```
Line 22 brings us the essential magic of recursion.  `2` is the Nock operator.
If you can compute a subject and a formula, you can evaluate them in the
interpreter.  In most fundamental languages, like Lisp, `eval` is a curiosity.
But Nock has no `apply` - so all our work gets done with `2`.

---

##Cell, Increment, Equality


```text
28 ::    *[a 3 b]         ?*[a b]
29 ::    *[a 4 b]         +*[a b]
30 ::    *[a 5 b]         =*[a b]
```
In lines 23-25, we meet our axiomatic functions again:

For instance, if `x` is a formula that calculates some product, `[3 x]` would test whether the product is a cell. [4 x]` would increments the product (if atomic)`. [5 x]` would test whether the head and tail of the product were the same (if cellular).

---

##Nock 6, If, Then, Else

**`6` Reduction:**

```text

*[p 6 q r s]

32 ::    *[a 6 b c d]      *[a 2 [0 1] 2 [1 c d] [1 0] 2 [1 2 3] [1 0] 4 4 b]

*[p 2 [0 1] 2 [1 r s] [1 0] 2 [1 2 3] [1 0] 4 4 q]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[*[p 0 1] *[p 2 [1 r s] [1 0] 2 [1 2 3] [1 0] 4 4 q]]

25 ::    *[a 0 b]          /[b a]

*[p *[p 2 [1 r s] [1 0] 2 [1 2 3] [1 0] 4 4 q]]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[p *[*[p [1 r s]] *[p [1 0] 2 [1 2 3] [1 0] 4 4 q]]]

26 ::    *[a 1 b]          b

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[p *[[r s] [*[p 1 0] *[p 2 [1 2 3] [1 0] 4 4 q]]]]

26 ::    *[a 1 b]          b

*[p *[[r s] [0 *[p 2 [1 2 3] [1 0] 4 4 q]]]]

27 ::    *[a 2 b c]        *[*[a b] *[a c]]

*[p *[[r s] [0 *[*[p [1 2 3]] *[p [1 0] 4 4 q]]]]]

26 ::    *[a 1 b]          b

*[p *[[r s] [0 *[[2 3] *[p [1 0] 4 4 q]]]]]

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[p *[[r s] [0 *[[2 3] [*[p [1 0]] *[p 4 4 q]]]]]]

26 ::    *[a 1 b]          b

*[p *[[r s] [0 *[[2 3] [0 *[p 4 4 q]]]]]]

29 ::    *[a 4 b]          +*[a b]

*[p *[[r s] [0 *[[2 3] [0 ++*[p q]]]]]]
```

**`6` Reduced:**

```text
	32r ::   *[a 6 b c d]               *[a *[[c d] [0 *[[2 3] [0 ++*[a b]]]]]]
```
`6` is a primitive known to every programmer - good old "if."  If `b` evaluates
to `0`, we produce `c`; if `b` evaluates to `1`, we produce `d`; otherwise, we
crash. We could have defined "if" as a built-in function, like increment
by arbitrarily inventing another operator:

```text
::    $[0 b c]         b
::    $[1 b c]         c
```
Then we could restate `6` quite compactly:

```text
32c::    *[a 6 b c d]     *[a $[*[a b] c d]]
```

However, since we _can_ write `if` as a macro, albeit a funky macro, we do so
as to keep the Nock specification small.

In real life, of course, the Nock implementor knows that `6` is "if" and
implements it as such. It's worth noting that in practical, compiler-generated
Nock, we never do anything as funky as these `6` macro internals.  There's no
reason we couldn't build formulas at runtime, but we have no reason to and we
don't - except when actually metaprogramming.  As in most languages, normally
code is code and data is data.

---

##Nock 7, Composition


**`7` Reduction:**

```text

*[p 7 q r]

33 ::    *[a 7 b c]        *[a 2 b 1 c]

*[p 2 q 1 r]

27 ::    *[a 2 b c]        *[*[a b] *[a c]] 

*[*[p q] *[p 1 r]]

26:    *[a 1 b]          b
 
*[*[p q] r]
 
```

**`7` Reduced:**

```text
33r ::     *[a 7 b c]         *[*[a b] c]
```
`7` is an old mathematical friend, function composition.  It's
easy to see how this is built out of `2`.  The data to evaluate
is simply `b`, and the formula is `c` quoted.

title: nock 8, Push
---

**`8` Reduction:**

```text

*[p 8 q r] 

34 ::    *[a 8 b c]        *[a 7 [[7 [0 1] b] 0 1] c]

*[p 7 [[7 [0 1] q] 0 1] r]   

33r ::     *[a 7 b c]         *[*[a b] c]

*[*[p [7 [0 1] q] 0 1]] r]

23 ::    *[a [b c] d]      [*[a b c] *[a d]]

*[[*[p [7 [0 1] q]] *[p 0 1]] r]

25 ::    *[a 0 b]          /[b a]

*[[*[p [7 [0 1] q]] /[1 p]] r]

16 ::    /[1 a]            a

*[[*[p [7 [0 1] q]] p] r]

33r ::     *[a 7 b c]         *[*[a b] c]

*[[*[*[p 0 1]] q] p] r]

25 ::    *[a 0 b]          /[b a]

*[[*[/[1 p] q] p] r]

16 ::    /[1 a]            a

*[[*[p q] p] r]

```
**`8` Reduced:**

```text
34r ::     *[a 8 b c]        *[[*[a b] a] c]
```

`8` is similar to `7`, except that the subject for `c` is not simply the
product of `b`, but the ordered pair of the product of `b` and the original
subject. 

Why would we want to do this?  Imagine a higher-level language in which the
programmer declares a variable.  This language is likely to generate an `8`,
because the variable is computed against the present subject, and used in a
calculation which depends both on the original subject and the new variable.

---

##Nock 9, firearm

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

---

##Nock 10, Hint

**`10` Reduction:**

```text

*[p 10 [q r] s] 

36 :: *[a 10 [b c] d]   *[a 8 c 7 [0 3] d]

*[p 8 r 7 [0 3] d]

34r ::     *[a 8 b c]        [[*[a b] a] c]

*[[*[p r] p] 7 [0 2] s]

33r ::     *[a 7 b c]        *[*[a b] c]

*[*[[*[p r] p] 0 3] s]
```

**`10` reduced:**

```text
36r ::    *[a 10 [b c] d]   *[*[[*[a c] a] 0 3] d]

33 ::    *[a 10 b c]       *[a c]
```

If `b` is an atom and `c` is a formula, the formula `[10 b c]` appears to be
equivalent to `c`. Likewise if `[b c]` is a cell, `[10 [b c] d]` appears to be
equivalent to `d`.

`10` is actually a hint operator.  The `b` or `[b c]`is discarded information -
it is not used, formally, in the computation.  It may help the interpreter
compute the expression more efficiently, however.

Every Nock computes the same result - but not all at the same speed.  What
hints are supported?  What do they do?  Hints are a higher-level convention
which do not, and should not, appear in the Nock spec.  Some are defined in
Hoon.  Indeed, a naive Nock interpreter not optimized for Hoon will run Hoon
quite poorly.  When it gets the product, however, the product will be right.

(Why is the c in `[b c]` is computed?  Because `c` could crash.  A correct
Nock cannot simply ignore it, and treat both variants of `10` as equivalent.)

##Crash Defaults

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
not terminate.  It cannot recognize all in
