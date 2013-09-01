---
layout: doc_chapter
title: Chapter 1 &#58; Crash course in Arvo
---


{{page.title}}
==============================

Welcome to Urbit!

First, build...

##1.1 Build instructions##

###Step 1: Get the Source###

Either:

1. Download the source from `https://github.com/urbit/urbit/archive/master.zip`.

2. `git clone https://github.com/urbit/urbit.git`. 

###Step 2: Set URBIT_HOME###

Add

    export URBIT_HOME=$DIR/urb

to your `.bash_profile` or `.bashrc` file, where `$DIR` is the
location of your urbit folder from Step 1 (the default is
`$home/urbit/urb`).

Then run `source ~/.bash_profile` or `source ~/.bashrc`.

Check that you've done this right with

    echo $URBIT_HOME

which should return `$DIR/urb`.

###Step 3: Dependencies###

Urbit depends on:

+ GNU Multiprecision
+ libsigsegv
+ openssl
+ libssl-dev (Linux only)
+ ncurses (Linux only)

The process for which will vary depending on your OS. Currently we support OSX,
Ubuntu and AWS Linux AMI. Intrepid ninjas may attempt ports to other OSes. If
you're not an intrepid ninja, don't worry, Urbit runs just fine on a VM
(https://www.virtualbox.org/).


**OS X:**

1. Install XCode: `https://developer.apple.com/xcode/`.

2. Install Homebrew. `ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"` 
should work.  (Can you use MacPorts? Yes you can. You can also resolve the dependencies 
by hand.:-)

3. `brew install gmp libsigsegv openssl`

**Ubuntu**

Run the following:

    sudo apt-get install libgmp3-dev libsigsegv-dev openssl libssl-dev libncurses5-dev


**AWS:**

Assuming a clean instance:

    sudo yum --enablerepo epel install gcc git gmp-devel openssl-devel ncurses-devel libsigsegv-devel

###Step 4: Make###

In your Urbit directory (`$DIR`), `make`.  Sometimes things are just easy.

###Step 5: Run Urbit###

Run `bin/vere -c $mypier`, where $mypier is a directory that doesn't yet exist.
All your state (an append-only log and a memory checkpoint) will live in this
directory.  Its name doesn't matter and is not visible internally.

A _pier_ is an Urbit virtual machine that hosts one or more Urbit identities,
or _ships_.  When you run `vere -c`, it automatically creates a 128-bit ship,
or `submarine`.  Your name (a hash of a randomly-generated public key) will
look like:

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

and, then, if the network gods are happy, your submarine will start pulling
down Arvo files:

    + /~zod/main/1/bin/ticket/hoon
    + /~zod/main/1/bin/reset/hoon
    + /~zod/main/1/bin/ye/hoon
    + /~zod/main/1/bin/ls/hoon

and the like.  You'll see a couple pages of this stuff.  Don't worry too much
about the details right now.  Finally, you'll get the Arvo shell prompt (which
is also a Hoon REPL):

    ~machec-binnev-dordeb-sogduc--dosmul-sarrum-faplec-nidted/try=> 

Next, you need to decide whether a mere submarine is enough for you right now.
This monicker is a mouthful.  You can stick with it (for now), but... you're
going to need a wider xterm.

Which might be fine!  However, please note that just by sending a simple email,
you can get a much better ship - a `destroyer`, with a nice short name like

    ~waclux-tomwyc

Just email urbit@urbit.org, with your submarine in the subject.  We'll send you
destroyers - not one, but _two_.  Yes, two!  Tell us something cool in the
body, and we'll send you even more.

If you have a destroyer, you need to configure it.  Otherwise, just stretch
that xterm wide and skip to section 1.2.

Your destroyers will arrive in the form of [ship ticket] pairs.  Let's say the
ship is `~waclux-tomwyc` and the ticket is 

    ~ribdyr-famtem-larrun-figtyd

(What are these strings, anyway?  Just random unsigned integers, rendered in
Hoon's syllabic base, `@p`.)

A new life awaits you on the off-world colonies!  To begin, just type at the
prompt:

    :begin ~waclux-tomwyc

and follow the directions.  When the script completes, hit return and you'll be
the `~waclux-tomwyc` you wanted to be.

##1.2 Controlling Arvo##

If all went well, you now have a nice short prompt:

    ~waclux-tomwyc/try=>

If all did not go well (send us another email), or you're just too impatient to
wait for your destroyer, you have a big long prompt.  Which is fine, really,
just ugly - and all these exercises will still work.

Let's try a few quick things to stretch your fingers.  Type these command lines
and you should see the matching results:

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

One, you used Arvo as a Hoon REPL to print the constant `"hello, world"`, which
is a fancy way to write the Nock noun 

    [104 101 108 108 111 44 32 119 111 114 108 100 0]

Two, you called the Hoon `add` function to see that two plus two is four.  Math
seems to work the same on the off-world colonies.

Three, you ran the Arvo application `:hello` with the argument `%world`, which
is just a fancy way to write the integer `431.316.168.567` (or, for
non-Germans, `431,316,168,567`).  You might recognize it better as
`0x64.6c72.6f77`, that is, the ASCII characters in LSB first order.

(Is Urbit German?  Sadly, no.  But all our atom formats are URL-safe, which dot
is and comma isn't.)

And you (4) used the Arvo application :cat to print the Hoon file

    /=main=/bin/hello/hoon

which, supposing your current date is

    ~2013.8.23..04.38.31..f259

(ie, August 23, 2013 at 4:38:31 GMT/leap-second 25 plus 0xf259/0x1000 seconds),
is equivalent to the global path

    /~waclux-tomlyc/main/~2013.8.23..04.38.31..f259/bin/hello/hoon

which anyone in Urbit can, _[given the right permissions]_, see and even use -
but we're getting ahead of ourselves.

In any case, what we've seen is that Arvo is a dangerous and powerful operating
system which if handled improperly can cause serious injury or loss of life.
We exaggerate.  Slightly.

The first thing you need to know is how to control this tool.  Try your arrow
keys - you'll see that Arvo has traditional Unix history editing.  Up and down,
left and right work, as do the simple emacs controls:

    ^A  go to beginning of line
    ^B  left arrow
    ^D  delete next character
    ^E  go to end of line
    ^F  right arrow
    ^K  kill to end of line
    ^L  clear the screen
    ^U  kill the whole line
    ^Y  yank (restore from kill ring)

Don't expect any other emacs (or even readline - this is not readline, it's
internal to Arvo) commands to work.

There are also some special control keys specific to Arvo.  It's a good idea to
learn these first so that you feel in, um, control.

First, we'll quit out of an infinite loop with ^C:

    ~waclux-tomlyc/try=> :infinite

When you hit return at the end of this line, Arvo will appear to hang.  Do not
be alarmed!  This is not a bug - it means that we've started running our
infinite loop before printing the next console prompt.  Simply hit ^C, and
you'll see 

    ! intr
    ~waclux-tomlyc/try=> :infinite

Hit ^U to delete the line and escape from infinity.  Arvo is a deterministic
OS; you interrupted it while processing an event that would never terminate.
It returns to the state it was in before you hit return - as if nothing had
ever happened.

You're probably used to using nondeterministic, preemptive OSes, in which the
difference between a waiting process and an executing event isn't apparent to
the user.  Since Arvo is not preemptive, it has two very different states:
waiting and working.

When Arvo is working, ^C cancels the event it's working on.  When Arvo is
waiting, ^C ends the current task, which is the task that's currently prompting
you - or showing the `[waiting...]` prompt, indicating that it's waiting for
something else other than keyboard input.

Try this by running

    ~waclux-tomlyc/try=> :begin

    Do you have a ship and a ticket? yes

Then hit ^C and you'll be back to the command prompt (which, unlike in Unix, is
not a task itself, but part of the OS).

We don't always want to kill the prompting task.  We often want to switch
between tasks, or between tasks and the command line.  Sort of like switching
between windows, except in a command line.  We do this with ^X.  Try

    ~waclux-tomlyc/try=> :begin

    Do you have a ship and a ticket? yes

But hit ^X instead of ^C.  You'll get a prompt again.  Use it:

    ~waclux-tomlyc/try=> :begin

    ~waclux-tomlyc/try=> :hello %world
    "hello, world."
    ~waclux-tomlyc/try=> 

Hit ^X again:

    ~waclux-tomlyc/try=> :begin

    ~waclux-tomlyc/try=> :hello %world
    "hello, world."
    Do you have a ship and a ticket? yes

And finally, hit ^C to kill the task.

Last, there's one more magic control key that changes your whole
reality.  This is ^W, which switches between the ships in a pier.
Do you have multiple ships in your pier?  Sure - you still have
your old submarine.  Hit ^W:

    ~machec-binnev-dordeb-sogduc--dosmul-sarrum-faplec-nidted/try=> 

Hit ^W again:

    ~waclux-tomlyc/try=>

##1.2 Paths and stuff##

What do we know?  Okay, so this is an OS.  It's a little like
Unix but different.  It can print expressions and run commands.
Commands start with a colon.  Let's try the simplest command:

    ~tasfyn-partyv/try=> :ls
    ! type-fail
    ! exit

Hey, that didn't work!  It didn't work for two reasons.  One,
Arvo command-line arguments are typed, and `:ls` expects a path.
Two, `:ls` needs a path - unlike in Unix, applications can't see
the current path or shell variables.  (This is because Arvo
doesn't have 57 different ways of configuring an app.)  So try

    ~tasfyn-partyv/try=> :ls /~tasfyn-partyv/try=
    con bin lib doc

This seems somewhat cumbersome - isn't there a way to refer to
the current path?  There is, though it doesn't look like Unix.

    ~tasfyn-partyv/try=> :ls %
    con bin lib doc

Let's look at these paths in a little more detail.  An Arvo path
is more or less the same thing as a Unix path, except that Unix
isn't a global revision-control store.  It has the general form

    /ship/desk/case/spur

where `ship` is your ship, `desk` is a project (repository,
branch, etc), `case` is a revision of that project (a change
number, a date or a label), and `spur` is a path within it.

By convention, the head of the spur is the `neck`, which is
always one of `bin`, `lib`, `con`, or `doc` - ie, a file is
either a function, a library, a configuration, or a document
(meaning any kind of data file).  The rest is the `pole`.


