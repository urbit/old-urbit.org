--- 
layout: post 
categories: articles
axis: further-reading
sort: 2
author: jcb 
title: Martian Computing
date: 2014-02-16 15:00 
---

*This is condensed slightly edited from an early post on Urbit, the original
version, which should be read by everyone, can be found
[here](http://moronlab.blogspot.com/2010/01/urbit-functional-programming-from.html)*


Few of us have been to Mars. But science fiction has filled in many of the
gaps. We know that the Martian civilization is immensely old. Its software
technology, therefore, must be similarly antique. Obviously nothing like it
exists on earth - though those of us who remember VMS might be deceived.

Whether we remember VMS or not, some of us are unhappy with the state of Earth
software. Therefore it behooves us to consider an alternative. Since we have
not yet established communications with the Martians (who retreated into
tunnels as their planet froze), we cannot just FTP their code. We could,
however, try to write it.

What is Martian code actually like? There are two possibilities.

One: since Earth code is fifty years old, and Martian code is fifty million
years old, Martian code has been evolving into a big ball of mud for a million
times longer than Earth software. (And two million times longer than
Windows.)

This hypothesis strikes me as possible, but implausible. Since the big ball of
mud expands indefinitely, Martian code would therefore be so large and horrible
that, despite its underground installed base, the server room bulged into space
like a termite mound, intercepting low-flying asteroids and stinking up the
solar system all the way to Pluto. Our latest space telescopes would surely
have detected this abominable structure - if not, in fact, collided with it.

Two: therefore, at some point in Martian history, some abject fsck of a Martian
code-monkey must have said: fsck this entire fscking ball of mud. For lo, its
defects cannot be summarized; for they exceed the global supply of bullet
points; for numerous as the fishes in the sea, like the fishes in the sea they
fsck, making more little fscking fishes. For lo, it is fscked, and a big ball
of mud. And there is only one thing to do with it: obliterate the trunk, fire
the developers, and hire a whole new fscking army of Martian code-monkeys to
rewrite the entire fscking thing.

This is such an obvious and essential response to the big ball of mud pattern
that, despite the fact that we know nothing about Mars, we can deduce that it
must have happened on Mars. Probably several times. Probably several hundred.
For each of these attempts but the last, of course, the result was either (a)
abject failure, (b) another big ball of mud, or (c) both.

But the last, by definition, succeeded. This is the crucial inference we can
draw about Mars: since the Martians had 50 million years to try, in the end
they must have succeeded. The result: Martian code, as we know it today. Not
enormous and horrible - tiny and diamond-perfect. Moreover, because it is tiny
and diamond-perfect, it is perfectly stable and never changes or decays. It
neither is a big ball of mud, nor tends to become one. It has achieved its
final, permanent and excellent state.

For instance (and just for instance - this is by no means a guarantee of
perfection), Martian code is entirely Maxwellian: computationally defined by a
small set of axioms. In other words, it is formally specified - always and
everywhere. Nothing else could be perfect.

Of course, Martian code is also Martian. So completely incompatible with Earth
code. Note, however, that Mars had to go through this same transition - they
had to throw away their old Windows for Mars (tm), and adopt this new, tiny,
diamond-perfect kernel.

But can Earth code cooperate productively with this alien intruder? It sure
can. All it takes is glue - and Earth code is no stranger to glue. If there's
one thing Earth doesn't need, it's a new glue language. There is certainly no
difficulty in gluing Mars code to Earth code. From the Earth perspective,
Martian software is just another strange, mutually incompatible doohickey.
Welcome aboard! Alas, our mudball is already ornamented with many such curios.
They stick quite well.

Moreover, Martian code is so perfect that it cannot be contaminated, even in
this sticky environment. The general structure of cross-planet computation is
that Earth always calls Mars; Mars never calls Earth. The latter would be quite
impossible, since Earth code is non-Maxwellian. There is only one way for a
Maxwellian computer to run non-Maxwellian code: in a Maxwellian emulator. Any
direct invocation is an implementation error by definition. Thus, Mars remains
completely pure and Martian, even while glued firmly to Earth.

Unfortunately, Urbit is not in contact with Mars and cannot download their
tiny, diamond-perfect, 49-million-year-old kernel. Therefore, we have had no
alternative but to construct our own. It is not entirely done yet, and even the
done parts are probably nowhere near the quality of real Martian software.
Getting them there will require an actual collective effort, in the traditional
open-source manner.

As with any dangerous new technology, it's fortunate that Urbit is not yet
fully armed and operational. It's our plan to introduce Martian computing
gradually, to avoid producing serious social unrest. He who controls the spice
controls the universe. While Martian code is not in any real position to
dominate the universe, it cannot be described as Martian with a straight face,
unless clearly designed to dominate the world. After all, it's already
dominating Mars!

Any ersatz, Earth-produced Martian code is truly Martian in character only if
it is obviously and self-evidently immune to any extension or improvement.
Simplicity inflation is a chronic industry disease; Martian software must be
far beyond simple. It can only be described as stupid in its majestic
triviality. Or, of course, moronic.

Does it need to be this clean and simple? Yes. It does. This is perhaps my most
significant objection to "other peoples' languages." They all want to be clean
and simple. Everyone does. But their idea of clean and simple: terminating
bacterial growth. My idea of clean and simple: terminating atomic motion.

If this problem can be solved at all, which is not at all clear, it can be
solved only at cryogenic temperatures.

In case this metaphor is too weird for you, let me make it concrete. Normally,
when normal people release normal software, they count by fractions, and they
count up. Thus, they can keep extending and revising their systems
incrementally. This is generally considered a good thing. It generally is.

In some cases, however, specifications needs to be permanently frozen. This
requirement is generally found in the context of standards. Some standards are
extensible or versionable, but some are not. ASCII, for instance, is
perma-frozen. So is IPv4 (its relationship to IPv6 is little more than nominal
- if they were really the same protocol, they'd have the same ethertype).
Moreover, many standards render themselves incompatible in practice through
excessive enthusiasm for extensibility. They may not be perma-frozen, but they
probably should be.

The true, Martian way to perma-freeze a system is what I call Kelvin
versioning. In Kelvin versioning, releases count down by integer degrees
Kelvin. At absolute zero, the system can no longer be changed. At 1K, one more
modification is possible. And so on. For instance, [Nock](/bestiary/nock) is at
5K. It might change, though it probably won't. Certainly any change would be
extremely painful. [Hoon](/) is at 164K, roughly the boiling point of Xenon.
[Arvo](/), and thus Urbit has a whole, has an overall temperature of 544K,
an excellent temperature at which to grill a steak. 
