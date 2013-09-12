---
layout: doc_chapter
title: Chapter 1 &#58; Crash_course in Arvo
---


{{page.title}}
==============================

Welcome to Urbit!

#1.0  YO THIS IS UNFINISHED SHIT!#

All of the doc herein is cheerfully certified as incorrect,
incomplete, misleading and almost certainly misguided.  Do not
use!  Please return to your NSA-certified digital plantation.
If you found this site by accident, please keep it to yourself.
Clear your hard drive, wipe your search history... but always
trust content from Tlon, Tianming, Urban Republic.


#2.0 Security#

(Some of the things in this section may not make any sense until
you understand the whole Urbit stack.  Don't worry about it.)

Never leave security to the end of a project.  We've left
security to the end of Arvo.  Arvo has no security and must not
be trusted for anything at all.

That said, there are five basic security issues in Urbit.
Ordered by increasing difficulty:

+ type 0: securing Urbit ships from the evil Internets
+ type 1: securing Urbit ships from each other
+ type 2: securing Urbit ships from their own incompetent owners
+ type 3: securing Urbit ships from compromised hosting services
+ type 4: securing Urbit itself against hostile regimes

Urbit is not hard to secure from the evil world it lives in, if
securing it from non-Urbit attacks simply means securing its UDP
port against malformed fuzz or DoS traffic that does not follow
the Ames protocol.  If the input is formally correct, it is not a
type 1 attack, but a type 2 attack.  You see how we define
problems out of existence in this here bar.

Is it possible to pwn Arvo with malformed input?  Try it if you
like, ninja.  But consider what you're up against.  First of all,
normalizing arbitrary input into a well-typed data structure is
the first, most basic layer of protocol security.  Hoon's type
system is designed to solve this problem pretty much the way a
gun is designed to shoot bullets at things.  Probably your best
bet is the outer perimeter where bits become nouns - `++cue`, or
rather its C jet.  But it's not exactly a giant attack surface.

It's well known that a hacked computer is always in some sense a
"weird machine."  Since Arvo is precisely defined in Hoon, which
is precisely defined in Nock, which is precisely defined on a
T-shirt, it's hard work to make it turn weird.  Broadly, your
best bet is probably to attack the function-specific
optimizations ("jets") that `vere` uses to implement Nock both
efficiently and correctly.  

Jets are written in C, so there's something there.  On the other
hand, jets are not native methods and never make system calls.
So we could sandbox/contain the hell out them.  (I mean, not that
we do. We don't. But, we should probably should.)

The other thing about attacking jets, is that there are two
attacks only: you can make the jet compute the wrong result (A),
or you can (B) break through it to the OS.  Urbit (in theory, not
in practice) is pretty good at testing for class A errors.  A
class A error is quite unlikely to be a general compromise.  A
class B exploit is very likely to be a general compromise
(discounting the sandbox), but almost every class B exploit is
also a class A error.  So testing for semantic correctness will
generally find most exploits.

Then the crypto itself has to be secure, which means it has to be
combs for nano-nits by giga-geniuses with nano-combs.  The
present cryptosuite (A) is best regarded as a sign reading:
"Crypto Goes Here."  A can assumed to be crawling with nits of
every word size.  For example, it does not use a real symmetric
encryption function, but crap hand-rolled from a hash.  It could
be secure, but there are always turds without flies.

However, as a broader PKI architecture, Ames obeys the two
essential rules of crypto: no secret is secret forever, and no
algorithm is secure forever.  We can and will upgrade the
cryptosystem (probably to 25519/AES/SHA3) without rebooting the
universe.

Securing ships from each other is an application-layer problem,
not an OS-level problem.  Ships don't have any inherent power
over other ships.  Since you always know who you're talking to
and what you're doing, don't do anything bad on behalf of anyone
malicious.  What more could be said?

The exceptions are pseudo-applications built into Urbit, like the
revision control system itself (`clay`).  Right now, we assume
that everyone is a good neighbor, no one is here for anything but
silly reasons, and everyone can read everyone else's files.  But
in future, of course, we'll need ACLs.

(Urbit loathes nothing so much as the OAuth approach to network
service authentication.  Speaking as a network service - don't
hand me some crypto capability and ask me to prove what rights it
conveys.  Just tell me who you are, securely.  And I'll decide
what services you're entitled to receive.  Do you really need to
delegate authority to third parties who neither are, nor aren't,
you?  We're not on that digital plantation anymore, right?)

DoS defense between ships - a problem which, stated broadly
enough, includes spam - is not as hard as it sounds, because
Urbit is not an infinite-identity network.  When identities are
finite, blacklists/killfiles work, work well, and are easy.  We
don't have them yet because we don't need them yet.  We will, but
we don't expect to have to work hard at it.

Even if a spammer or other malefactor gets his slimy goblin paws
on a virgin cruiser or carrier, defining 2^16 or 2^24 destroyers,
blocking these entire blocks would obviously be a single
operation.   

Also, conveying capital ships to bad actors is a bad action of
its own.  It is in the interest of every Urbiter, big or little,
to attack this problem first at its most basic root: keeping
ships, especially cruisers or carriers, out of the hands of bad
actors.  This barrier cannot be perfect - but, especially at
first, it is the most important barrier.

But who is justice, anyway?  Who decides who's good or bad?
Blacklists are meant to be shared.  Who owns the global
blacklist?  Is there a global blacklist?  Or several competing
candidates for this near-Papal authority?  These are all social,
not technical, problems, that Urbit must solve in the long run to
succeed.  More on this at the type 4 layer.

Of course, DoS attacks of any sort must be ultimately delegated
with a "squelch upstream source" request to the hosting provider.
We have not even begun to address this protocol, which will by
definition only be needed if we succeed.

But type 2 security is by far the hardest problem.  We've punted
on this problem completely.  Or almost completely.

The only way to solve the type 2 problem is with strict privilege
rings whose definition is extremely precise and permanent.  Arvo
has three, coded as metals - `%lead`, `%gold` and `%iron`.  (To
confuse you, these same tokens mean something else totally
different in the Hoon type system.)

An Arvo task, to simplify broadly, is literally a function that
accepts an event and returns an effect.  Thus, we can define
privilege rings in terms of simple filters on these effects.

Lead privilege, always associated with a single foreign ship, is
the equivalent of the origin restriction in the browser.  Code is
treated as totally untrusted and evil.  It cannot have any
serious effects on your ship.  It can converse only only with its
own origin server.  This restriction is not implemented.  So
watch your back!

Iron privilege is normal operating privilege.  This concept is
not even defined.  So it could not possibly be implemented.  And
indeed, it isn't.

Gold privilege is root privilege with no restriction at all.
Right now, everything you do is `%gold`.  So watch your back!
Anything you run can steal any secret and send it anywhere.

When these privileges actually work, however, you'll set them on
the command line by prepending `!` to `:`, for every level of
privilege escalation - or `?`, for every level of de-escalation.
Default privilege is %iron for local applications and %lead for
network ones.  Thus, 

    ~waclux-tomwyc/try=> !:hello %world
    "hello, world."

upgrades `:hello` to root privilege, basically Arvo's `sudo`.
Privilege-restricted terminals will also exist at some point.

Finally, it should be obvious that type 3 security is a
completely unsolvable problem.  If you do not trust your host
for social, noncryptographic reasons, you do not trust your host
at all.  If you don't trust your restaurant not to poison your
dinner, choose another restaurant.  If you don't trust any 
restaurant not to poison your dinner, eat at home.  If you don't
trust anyone to host you, own and operate your own computer.

Most people eat at restaurants.  Most people, we think, will
prefer the safety, comfort and efficiency of cloud hosting.  On
the other hand, it might be argued that these people are fools
and sheep, whose their safety and freedom depends on the paranoia
of paranoid nutcases who self-host - and thus define a community
in which absolute privacy, though not forced on anyone, is
instantly available to anyone at any time - at the expense of
making a probably suboptimal economic choice.

In a well-designed secure network, privacy must be available to
everyone, but it need not be forced on everyone.  Or even turned
on by default.  Privacy always creates inconvenience, and most
users prefer convenience.  But the users who are willing to
accept a little inconvenience, in exchange for privacy, in the
same network, create a sort of herd immunity for everyone.

When I worry about Urbit and privacy, I worry that it will create
too much privacy, rather than too little.  Certainly several
services not too dissimilar to Urbit, such as Freenet, have
become hives of digital vice - at best.  

Only social and political methods, not technical tools, can fight
this filth.  One of the inspirations for Urbit's political design
is James C. Scott's classic political-science text, _Seeing Like
a State_.  Urbit is not in any sense a state, but its fabric has
the regularity that, according to Scott, is essential for the
construction of anything like a civilized society.  But of
course, a basically virtuous society, in which antisocial
behavior is not tolerated and easily excluded or destroyed, can
only be built from virtuous users.

Urbit has no central government and does not need one - except
possibly for type 4 reasons, which hopefully will never arise.
It is cryptographically designed, through the ship hierarchy, to
splinter rapidly into multiple highly governable spaces.  The
structure and nature of these carrier (2^24 destroyers) and
cruiser (2^16 destroyer) regimes is entirely unclear.  And the
cryptographic/routing hierarchy is not the only way to organize
distributed institutions; it is just one such way.

Hopefully most of these institutions will succeed, and few will
fail.  Escape, even from the ship hierarchy, is an essential
principle of Urbit.  For example, the state of a pier is simply
an initial kernel, an event log and a memory image, and the
image can be computed from the kernel and the log.  The only
semantic standards which bind these files are (a) Nock and (b)
the Hoon noun-to-atom reduction (++jam), ie, two pages of code.
Thus the piers should be portable at the hosting layer.

But they must also be portable at the Urbit layer.  One feature
missing in the alpha is the power of a destroyer to escape from
a malicious carrier or cruiser in its hierarchy.  Most of the
value of big ships is simply their hypothetical real estate, but
P2P routing could not function without the hierarchy or something
similar.  Complete exit rights at the destroyer level (a yacht
has no exit rights, because a yacht is essentially a user of a
destroyer, and shouldn't come weirdly unleashed from its owner)
require high-level exception lists not yet implemented.  The hope
is that once this mechanism exists, it will never be used - 
but if it keeps not existing, that will become a problem.

Urbit may also become a tool for political sedition.  This we
don't want.  One goal of the banner system is to control and
subdue illegal political content, such as hate speech on Twitter.
Another goal is to organize legal antigovernment communication
and organization, as in Occupy or the Tea Party.  Ideally, Urbit
would be as useful as possible for legal resistance, and as
useless as possible for illegal resistance.  But of course, as a
technology, it is what it is and probably falls short of both.

Urbit's fundamental approach to type 4 security is to comply as
enthusiastically as possible with the content regulations of your
own jurisdiction and/or community - whether these be political,
copyright, or other restrictions.  In the type 4 game, the only
offense is a good defense.  And enthusiastic compliance with all
sovereign authorities, de jure or de facto, is the best defense
of all - in almost every circumstance.

At a political level, the banner system is very helpful in this.
Most governments are quite comfortable with %blue and %orange
political content, but %red content may violate various laws in
fascist, nationalist or militarist regimes, and %black in
liberal, socialist or communist regimes.  Under a regime in which
one banner is partly or entirely illegal - even if it is entirely
illegal - this "dangerous" banner will find it in its own
interest to police _itself_, and use its own moderation
mechanisms to remain jurisdiction-safe.  Whatever the rules of
the jurisdiction, sensible or otherwise.

For example, in a jurisdiction where any and all communist speech
is illegal, all political speech should be suppressed by the 
%red banner itself, simply as a matter of communal strategy.  In
this hypothetical country, it is certainly sufficient provocation
for communists to flaunt their own ideology with a %red ship.
Not only is suppressing all other political speech the best
defense, it may be the best offense as well - for this is
essentially the design of a "color revolution."  Silence is
always unanimous, and power is a function of unanimity.

At a commercial level, Urbit is certainly not designed to be a
file-sharing network or anything of the sort.  My advice to
content producers, if Urbit ever becomes a thing - or worse yet,
achieves the world domination it neither seeks nor fears - is
that the right way to fight piracy is to abandon the dangerous
and anachronistic practice of sending the same non-watermarked
file to everyone.  Rather, require every serious content buyer to
post a creative bond.  If his files are found on a sharing
network, he gets a bill and the informer gets a reward.  This
will have a rapid, lethal effect on the "culture of sharing." But
for non-marked files, really nothing can be done.

Moreover, it is also antisocial to assist others in other
jurisdictions from evading local content restrictions, even if
these restrictions don't apply at all in your jurisdiction.  The
grievances you create do not dissipate because you are not
accessible to the remote governing authority; they pass up the
chain and become grievances between that authority and yours.
Of course, as with everything, there will be exceptions to this
rule that cannot possibly be defined in advance.

Finally, Urbit is not a digital currency, although Urbit ships
have the same basic allodial title model as Bitcoin.  Ships are
not virtual money - they are virtual real estate.  Like real
estate, they are designed to be expensive to transfer - a ship
can only be transferred 9 times before it loses all its value.
This lossage, plus of course poor divisibility, is intended
to prevent Urbit ships from being used as a Bitcoin substitute.
Rather, use Bitcoin itself (where local laws permit).  In theory, 
Urbit ships are well-suited for both hosting and mining Bitcoin,
although there is no such support at present.

