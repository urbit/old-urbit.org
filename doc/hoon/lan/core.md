


Cores are Nock structures of the form [battery payload], or [code data]. The battery contains one or more formulas, or arms

battery

[arm-1 arm-2 arm-3 ...]

and the payload can contain any data.


##Core Forms##

  - Book
    A core whose payload is either a core, or a constant (cube, link). (See `|^`)
  
  - Reef
    A core whose payload is either a reef, or a constant (cube, link), i.e. a book of only constants.

  - Tray
    A core whose payload is of the form [sample context]. (See `|_`, `|/`,)

  - Trap
    A core whose battery contains a single arm, labeled %$, which is the empty name. (See `|.`, `|-`, `|?`)

  - Gate
    A core which is both a trap and a tray, whose battery is a single arm, and whose payload is of the form [sample context].
    (See `|=`, `|+`, `|*`)


##Variance##


Polymorphism in Hoon supports four kinds of variance: %gold (invariant), %lead
(bivariant), %zinc (covariant), and %iron (contravariant).

The question of variance arises when we want to test whether one core is
compatible with another.

For core A to nest within core B (any A can be used as a B), it seems clear
that A should have the same set of arms as B (with formulas at exactly the same
axes in the battery), and that any product of an A arm should nest within the
product of the corresponding B arm.

A simple rule might be that the payload of A must also nest within the payload
of B. Unfortunately, this doesn't work.

Suppose, for instance, one writes a sort gate, one of whose arguments is a
comparison gate producing a loobean. (This is generally a problem calling for
generic polymorphism, but assume the gate is sorting lists of a fixed type.)
The sort library cannot possibly have the same context as the application which
is using the sort library. So, the cores will be incompatible and the
invocation will fail.

This rule, which doesn't work in this case, is the rule for %gold (invariant)
cores. Every core is created %gold, and remains %gold from the perspective of
its own arms.

But the type of some arbitrary comparator, which is an argument to our sort
function, cannot possibly be %gold. Rather, we need an %iron (contravariant)
core. One can turn any %gold core into an %iron one with ^| (ketbar, %ktbr),
but the transformation is not reversible.

%iron

The rules for using an %iron core are that (a) the context is opaque (can
neither be read nor written), and (b) the sample is write-only. Why? Because
it's absolutely okay to use as your comparator a gate which accepts a more
general sample than you'll actually call it with. You can write a more
specialized noun into this sample - but if you read the default value and treat
it as more specialized, you have a type loophole.

%zinc

A %zinc (covariant) core is the opposite - the context remains opaque, the
sample is read-only. We don't use any %zinc at present, but this is only
because we haven't yet gotten into inheritance and other fancy OO patterns.
(Hoon 191 had inheritance, but it was removed as incompletely baked.) You make
a %gold core %zinc with ^& (ketpam, %ktpm).

%lead

Finally, the entire payload of a %lead (bivariant) core is immune to reading or
writing. So all that matters is the product of the arms. You make a lead core
with ^? (ketwut, %ktwt).


##Polymorphism##

One interesting question in any language is what happens when you pass a function an argument more specialized than its declaration.

Consider a function that takes a pair [a b] and produces [b a]. Any noun will obviously do for b and a. So the sample tile is [a=* b=*]. But suppose the caller knows something more about a and b. What happens? Let's give it a try:

~zod/try=> :type; (|=([a=* b=*] [b a]) %foo %bar)
[7.496.034 7.303.014]
[* *]

With |= (bartis, %brts), the normal way of building a gate, we lost all our type information. Sometimes this is fine. Sometimes it's exactly what we want. But here's something else we can do:

~zod/try=> :type; (|*([a=* b=*] [b a]) %foo %bar)
[%bar %foo]
[%bar %foo]

By using |* (bartar, %brtr), we seem to have produced the same noun, but not lost any type information. Interesting!

The difference is that while both |= and |* are polymorphic, |= uses geometric polymorphism and |* uses generic. Which should you choose?

There's a simple rule for this, which is that unless you are a wizard doing wizardly things, you should use |=. Generic polymorphism is a way to build and use tools like containers (lists, etc), which in other, inferior languages might simply be built in to the language semantics. Especially as a new Hoon programmer, you are probably not building heavy machinery of this kind, and should probably make do with the standard components.

But you will be using containers, etc. So there's no shortcut for understanding both systems.


