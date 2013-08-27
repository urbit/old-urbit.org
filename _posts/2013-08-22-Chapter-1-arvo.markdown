---
layout: doc_chapter
title: Chapter 1 &#58; Crash course in Arvo
---


{{page.title}}
==============================

Welcome to Urbit!

First, build.

##1.1 Build instructions##

###Step 1: Get the Source###

Download the zip of the latest Urbit source from https://github.com/urbit/urbit/archive/master.zip and unzip it. Move the file, which should be called urbit-master to the directory of your choice (`$DIR`).


(You can also get the source by using git clone. We'll assume that if you want to use git, you already know how to use git.)

###Step 2: Set URBIT_HOME###
The next thing you have to do is add

	export URBIT_HOME=$DIR/urb

your `.bash_profile` or `.bashrc` file, where `$DIR` is the location of urbit-master from Step 1 (the default is `$home/urbit/urb`).

Then run `source ~/.bash_profile` or `source ~/.bashrc`

Check that you've done this right with

	echo URBIT_HOME

which should return `$DIR/urb`.

###Step 3: Dependencies###

Urbit depends on the following:

+ readline library
+ GNU Multiprecision
+ bison
+ libsigsegv
+ openssl
+ libssl-dev (Linux only)
+ ncurses (Linux only)


The process for which will vary depending on your OS. Currently we support OSX, Ubuntu and AWS Linux AMI. Intrepid ninjas may attempt ports to other OS's. If you're an intrepid ninja, let us know, successful ports will result in prizes. If you're not an intrepid ninja, don't worry, Urbit runs just fine on a VM (https://www.virtualbox.org/).


**OS X:**

1. Install XCode (if you haven't already). You should be able to get it here: https://developer.apple.com/xcode/
2. Install Homebrew. Look at www.brew.sh for instructions. (Can you use MacPorts? Yes, and you can also build the dependencies by hand.)
3. At the terminal run the following for Homebrew: 

	`brew install readline gmp bison libsigsegv openssl`


**Ubuntu**

At the Terminal, run the following:

	sudo apt-get install libreadline-dev libgmp3-dev bison libsigsegv-dev openssl libssl-dev libncurses5-dev


**AWS:**






###Step 4: Make###

In your Urbit directory (`$DIR`) run `make OS=osx` for OSX or `make OS=linux` for Linux. 


###Step 5: Run Urbit###

Run `bin/vere -c $pier`, where $pier is a directory that
doesn't yet exist.  All your state (an append-only log and a
memory checkpoint) will live in this directory.  Its name doesn't
matter and is not visible internally.

A _pier_ is an Urbit virtual machine that hosts one or more Urbit
identities, or _ships_.  When you run `vere -c`, it automatically
creates a 128-bit ship, or `submarine`.  Your name (a hash of a
randomly-generated public key) will look like:

	~machec-binnev-dordeb-sogduc--dosmul-sarrum-faplec-nidted

First you'll see a string of messages like:

	vere: urbit home is /Users/cyarvin/Documents/src/u3/urb
	loom: mapped 1024MB
	time: ~2013.8.23..03.57.11..4935
	ames: on localhost, UDP 63908.
	generating 2048-bit RSA pair...

and then it'll pause a little, 'cause this is slow... and then

	saving passcode in /Users/cyarvin/.urbit/~magsut-hopful.txt
	(for real security, write it down and delete the file...)

and, then, if the network gods are happy, your submarine will 
start pulling down Arvo files:


		+ /~zod/main/1/bin/ticket/hoon
		+ /~zod/main/1/bin/reset/hoon
		+ /~zod/main/1/bin/ye/hoon
		+ /~zod/main/1/bin/ls/hoon

You'll see a couple pages of this stuff.  Don't worry too much
about the details right now.  Finally, you'll get the Arvo shell
prompt (which is also a Hoon REPL):

	~machec-binnev-dordeb-sogduc--dosmul-sarrum-faplec-nidted/try=> 

Next, you need to decide whether a mere submarine is enough for
you right now.  This monicker is a mouthful.  You can stick with
it (for now), but... you're going to need a wider xterm.

Which might be fine!  However, please note that just by sending
a simple email, you can get a much better ship - a `destroyer`,
with a nice short name like

	~waclux-tomwyc

Just email urbit@urbit.org, with your submarine in the subject.
We'll send you destroyers - not one, but _two_.  Yes, two!  Tell
us something cool in the body, and we'll send you even more.

If you have a destroyer, you need to configure it.  Otherwise,
just stretch that xterm wide and skip to section 1.2.

Your destroyers will arrive in the form of a [ship ticket] pair.
Let's say the ship is `~waclux-tomwyc` and the ticket is 

	~ribdyr-famtem-larrun-figtyd

(What are this strings, anyway?  Just random unsigned integers,
rendered in Hoon's syllabic base, `@p`.)

A new life awaits you on the off-world colonies!  To begin, just 
type at the prompt:

	:begin ~waclux-tomwyc

and follow the directions.

##1.2 Life in Arvo##

If all went well, you now have a nice short prompt:

	~waclux-tomwyc/try=>

If all did not go well (send us another email), or you're just
too impatient to wait for your destroyer, you have a big long
prompt.  Which is fine, really, just ugly - and all these
exercises will still work.

Let's try a few quick things to stretch your fingers.  Type
these command lines and you should 

	~waclux-tomwyc/try=> "hello, world"
	"hello, world"

	~waclux-tomwyc/try=> (add 2 2)
	4

	~waclux-tomwyc/try=> :hello %world
	"hello, world."

	~waclux-tomwyc/try=> :cat /=main=/bin/hello/hoon
	::
	::  /=main=/bin/hello/hoon
	::
	|=  *
	|=  [planet=@ta ~]
	^-  bowl
	:_  ~  :_  ~
	:-  %%
	!>("hello, {(trip planet)}.")

What did you just do?  

One, you used Arvo as a Hoon REPL to print the constant `"hello,
world"`, which is a fancy way to write the Nock noun 

	[104 101 108 108 111 44 32 119 111 114 108 100 0]

Two, you called the Hoon `add` function to see that two plus two
is four.  Math seems to work the same on the off-world colonies.

Three, you ran the Arvo application `:hello` with the argument
`%world`, which is just a fancy way to write the integer
`431.316.168.567` (or, for non-Germans, `431,316,168,567`).  You
might recognize it better as `0x64.6c72.6f77`, that is, the ASCII
characters in LSB first order.

(Is Urbit German?  Sadly, no.  But all our atom formats are
URL-safe, which dot is and comma isn't.)

And you (4) used the Arvo application :cat to print the Hoon
file

	/=main=/bin/hello/hoon

which, supposing your current date is

	~2013.8.23..04.38.31..f259

(ie, August 23, 2013 at 4:38:31 GMT plus 0xf259/0x1000 seconds),
is equivalent to the global path

	/~waclux-tomlyc/main/~2013.8.23..04.38.31..f259/bin/hello/hoon

which anyone in Urbit can, _[given the right permissions]_, see
and even use - but we're getting ahead of ourselves.

In any case, what we've seen is that Arvo is a dangerous and
powerful operating system which if handled improperly can cause
serious injury or loss of life.  We exaggerate.  Slightly.

The first thing you need to know is how to control this tool.
Try your arrow keys - you'll see that Arvo has traditional Unix
history editing.  Up and down, left and right work, as do the
simple emacs controls:

	^A  go to beginning of line
	^B  left arrow
	^D  delete next character
	^E  go to end of line
	^F  right arrow
	^K  kill to end of line
	^L  clear the screen
	^U  kill the whole line
	^Y  yank (restore from kill ring)

Don't expect any other emacs (or even readline - this is not
readline, it's internal to Arvo) commands to work.

There are also some special control keys specific to Arvo.  It's
a good idea to learn these first so that you feel in, um, control.

First, we'll quit out of an infinite loop with ^C:

	~tasfyn-partyv/try=> :infinite

When you hit return at the end of this line, Arvo will appear to
hang.  Do not be alarmed!  This is not a bug - it means that
we've started running our infinite loop before printing the
next console prompt.  Simply hit ^C, and you'll see 

	! intr
	~tasfyn-partyv/try=> :infinite

Hit ^U to delete the line and escape from infinity.  Arvo is a
deterministic OS; you interrupted it while processing an event
that would never terminate.  It returns to the state it was in
before you hit return - as if nothing had ever happened.

You're probably used to using nondeterministic, preemptive OSes,
in which the difference between a waiting process and an
executing event isn't apparent to the user.  Since Arvo is not
preemptive, it has two very different 

