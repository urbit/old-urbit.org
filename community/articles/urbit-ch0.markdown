---
layout: post
categories: articles
author: atax1a
axis: further-reading
sort: 4
title: Urbit Is &#58; Chapter 0
date: 2013-12-13 17:23
---

#Introduction#

Greetings from the off-world colonies! I'm your guide and scribe,
`atax1a`, a character from a book that hasn't been written yet. Every
great book has a Chapter 0, though, and you are reading mine.

I am often asked...
#What Is Urbit?#

Urbit could be a way of sharing your data in a way that makes it live
forever.  Maybe it's a Facebook of memories, 140 Twitters of words, or
an Instagram for when you're a grandpa. Maybe you send Urbit an email.
You can hit it with your web browser right now, but that's a bit rough
around the edges. (Given time, it could even be that BBS or MUD that
you wanted, but could never have...) It could be anything --- right
now, we use it as a glorified chat program, but one that never loses
messages. Well, almost never.  Sometimes we have to reboot the
Universe, and everything we haven't backed up is lost.

You may be getting the idea that Urbit is hard to define precisely. It is,
because it isn't finished yet. In reality, Urbit is just a labyrinth
of code, written as a book, running on a virtual machine (possibly
running on another virtual machine, and so on), built out of physical
parts, and it's read and written )and edited( by human mammals on a
planet called Earth. (The Urbit computer follows a "Hears, knows,
does" model, which I can explain later.) A lot of Earthlings call it
an art project, which isn't far off. Sometime it's Dada, other times
it's baroque, but it always has a precise scientific backing in the
form of *Nock*, which are the fundamental axioms (rules) of the
Urbiverse. Nock is all numbers, tho, and it's tiring.

Urbit is also a programming language. We call that *Hoon*, for reasons
I'm still not quite clear on. It takes Nock's numbers and puts symbols
on them. They're kinda weird symbols, and most "real" programmers I
know (and work with) take one look at something like

    |=(x=@ ?:((lth x 2) 1 (add $(x (dec x)) $(x (sub x 2)))))

and go pale around the gills. Myself, I grew up speaking a language
called `perl`, which has an even bigger love-affair with special
characters, so reading this doesn't faze me (Hoon uses its special
characters judiciously, so please don't think of `perl` unless you like
that sort of thing).

An earlier version of Urbit (when Hoon was still called Watt) was
rejected from a real scientific conference because the judges felt
vaguely insulted by the nonstandard language. The Urbit you're looking
at now has had a few years to cool down and mature, and right now it's
so cool at the core that it's well below -400 Fahrenheit. Thankfully,
there is an entire planet built up around its icy core, and on the
surface of that planet, it's a balmy 25 degrees Celsius, and the water
is like glass.

Urbit is currently only usable by a hyperliterate set of people ---
it's immersed in the culture of the word, and it's struggling for a
glimpse of air, the sound of music, and a taste of freedom.  Really,
though, it's easy to teach yourself, if you work through it with a
dedicated mind. Having a friend along for the ride is definitely
recommended. People with prior programming experience are welcome, but
be warned: your existing biases and expectations are wrong. We'll try
and be gentle about breaking them.

#Why should I care? (the buried lede)#

In the end, Urbit is a single global computer. Think "Cyberspace" from
_Neuromancer_, or "The Metaverse" from _Snow Crash_. If you're really
early, think of Haflinger's worm from _The Shockwave Rider_. But don't
think of it as the Internet --- the internet is a single global
_network_, and it only follows two rules: you can act like a UNIX
machine when prompted, and you speak TCP/IP. Anyone can see what
you're saying, and most people can understand it. There are gaps in
the network, too: _The Great Firewall Of China_, anyone? "Encryption",
or as I might call it, _privacy_, is an afterthought, and people who
Never Say Anything can read a lot of supposedly "private" things, just
by doing the right math. *Urbit isn't like that*. It enables secure,
private, computing, in a way that nobody else can, because it is
"semantically isolated" --- the meaning of the Urbit program is
independent of the outside world (in this case, the Internet).

Urbit works like an Internet should. If you know someone's address,
you can send them a message. It will either reliably be delivered, or
get rejected. Likewise with requesting something: if you ask for
tomorrow's newspaper headline _today_, Urbit will gladly give it to
you...  tomorrow. Your ship just waits for it to come in, and when it
does, everything proceeds like normal. "HTTP 404 Not Found"? What the
`!^&#` does THAT mean?

##Who ARE you people?##

We're dreamers, but the dream escaped and is slowly consuming the real
world. We're programmers with a sense of humor and an overload of
whimsy. At the end of the day, though, we're just people just like
you. People who want to change the world.  Everyone wants to change
the world, right?

##And what is with all of the weird words?##

Urbit is a piece of technology. Unfortunately, technology is hard to
explain, and it gets harder when the words we use to explain it are
misunderstood.  If you're used to speaking about your computers in
terms of a Unix (or Windows) workstation, it's a bit of a leap to
think in terms of Urbit ships in a pier.

In short, we use weird words to force a change in how our technology
is perceived. Without that, readers are likely to gloss over important
details, thinking that they understand more than they really do. It's
why we redefine everything, change the pronunciation of the symbols
you're used to, and even have our own number system. Count with me,
and feel free to scribble in the margins:

    ~zod 0   (also 'yes')                 if i were rewriting this
    ~nec 1   (no)                            i would put 'can' b4
    ~bud 2   [the rest of the numberz        'change meaning…'
    ~wes 3        change meaning
    ~sev 4    according to context]
    ~per 5   ---
    ~sut 6   <but that's 0kay>
    ~let 7   
    ~ful 8   
    ~pen 9   ¡you can figure it out!

Saying them out loud helps. You and your friend can agree on the
pronunciation.

#Introductions#

You can get in touch with me on Urbit, of course. Join up to `:chat`
and use `=` to see who's in the room. On the old internet, I go by
many names, but on this one I try to stick with `~hatteb-mitlyd`.
