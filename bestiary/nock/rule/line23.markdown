---
layout: subpage
category: nock
title: autocons
---

```text
23 ::    *[a [b c] d]      [*[a b c] *[a d]]
```

Um, what?

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



