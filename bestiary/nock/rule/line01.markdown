---
layout: subpage
category: nock
title: structures
---

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
