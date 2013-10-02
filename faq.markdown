---
layout: post
title: FAQ
---


##Where's the rest of the doc?##

Being written.

##Is Urbit a VM, an OS, a language, or a social network?##

Many of these things! Well, Urbit itself usually refers to a system of all of these things. At the highest level, there's the social network, which is a single broadcast network using the Ames protocol. This social network is where "ships", "piers" and "flags" are relevant (among other nautical terms). The network (probably called the Urbiverse) is accessibe by virtual computers mounted in piers running Arvo, somewthing which is very similar to an operating system (one that doesn't run on bare metal, but is hosted). Arvo is written in C and a language called "Hoon". Hoon is the native programming language of Urth, is spoken, and is static, typed, and functional. Hoon itself is built on the semantics of Nock, a maxwellian formally specified VM.

In short, Urbit is a static functional namespace, with a social network, an operating system, a programming language, and a formal virtual machine.

##What's a continuity breach?##

This occurs when something on ~doznec or ~zod has (essentially) gone awry, and all of Urth gets big-banged all over again. What does this mean for the Urbit user? Your piers won't work again, nor will your ships. Delete your piers (everything in URB_HOME except for `urbit.pill` and `zod/`) and then build a new pier and (if applicable) rebuild your destroyer.

###Why can't that stop happening?###

It will, total continuity is expected on October 4th, 2013. 



