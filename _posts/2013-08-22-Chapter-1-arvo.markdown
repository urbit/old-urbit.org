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

+ gmp
+ libsigsegv
+ openssl
+ libssl-dev (Linux only)
+ ncurses (Linux only)

Currently we support OSX, Ubuntu and AWS Linux AMI. Intrepid
ninjas may attempt ports to other OSes. If you're not an intrepid
ninja, don't worry, try a VM (eg, VirtualBox).

**OS X:**

1. Install XCode: `https://developer.apple.com/xcode/`.

2. Install Homebrew. `ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"` 
should work.  (Can you use MacPorts? Yes you can. You can also resolve the dependencies 
by hand :-)

3. `sudo brew install gmp libsigsegv openssl`

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
    time: ~2013.9.1..03.57.11..4935
    ames: on localhost, UDP 63908.
    generating 2048-bit RSA pair...

and then it'll pause a little, 'cause this is slow... and then

    saving passcode in /Users/cyarvin/.urbit/~magsut-hopful.txt
    (for real security, write it down and delete the file...)

and, then, if the network gods are happy, your submarine will start pulling
down Arvo files:

    + /~waclux-tomwyc/main/1/bin/ticket/hoon
    + /~waclux-tomwyc/main/1/bin/reset/hoon
    + /~waclux-tomwyc/main/1/bin/ye/hoon
    + /~waclux-tomwyc/main/1/bin/ls/hoon

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

Your destroyers will arrive in the form of [ship ticket] pairs.  Let's say one
of your ships is `~waclux-tomwyc` and its ticket is 

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

    ~2013.9.1..04.38.31..f259

(ie, September 1, 2013 at 4:38:31 GMT/leap-second 25 plus
0xf259/0x1000 seconds), is equivalent to the global path

    /~waclux-tomwyc/main/~2013.8.23..04.38.31..f259/bin/hello/hoon

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

    ~waclux-tomwyc/try=> :infinite

When you hit return at the end of this line, Arvo will appear to hang.  Do not
be alarmed!  This is not a bug - it means that we've started running our
infinite loop before printing the next console prompt.  Simply hit ^C, and
you'll see 

    ! intr
    ~waclux-tomwyc/try=> :infinite

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

    ~waclux-tomwyc/try=> :begin

    Do you have a ship and a ticket? yes

Then hit ^C and you'll be back to the command prompt (which, unlike in Unix, is
not a task itself, but part of the OS).

We don't always want to kill the prompting task.  We often want to switch
between tasks, or between tasks and the command line.  Sort of like switching
between windows, except in a command line.  We do this with ^X.  Try

    ~waclux-tomwyc/try=> :begin

    Do you have a ship and a ticket? yes

But hit ^X instead of ^C.  You'll get a prompt again.  Use it:

    ~waclux-tomwyc/try=> :begin

    ~waclux-tomwyc/try=> :hello %world
    "hello, world."
    ~waclux-tomwyc/try=> 

Hit ^X again:

    ~waclux-tomwyc/try=> :begin

    ~waclux-tomwyc/try=> :hello %world
    "hello, world."
    Do you have a ship and a ticket? yes

And finally, hit ^C to kill the task.

There's one more magic control key that switches your whole
reality.  This is ^W, which switches between the ships in a pier.
Do you have multiple ships in your pier?  Sure - you still have
your old submarine.  Hit ^W:

    ~machec-binnev-dordeb-sogduc--dosmul-sarrum-faplec-nidted/try=> 

Hit ^W again:

    ~waclux-tomwyc/try=>

Finally, Arvo is a single-level store.  Since it's not the '70s
anymore and disk is cheap, everything you do is saved for ever.
(In fact, it's saved in two ways - as a memory image and an 
event log - so you, or the government if they haz your filez, 
can repeat every computation you've every performed.)

As in Unix, hitting ^D on an empty line ends the program:

    ~waclux-tomwyc/try=> 
    oxford:~/urbit; pwd
    /Users/cyarvin/urbit
    oxford:~/urbit; echo "hello, world"
    hello, world
    oxford:~/urbit; 

Then you can restart and be right back where you were - just
run `vere` without `-c`:

    oxford:~/urbit; bin/vere mypier
    vere: urbit home is /Users/cyarvin/urb
    loom: loaded 9MB
    time: ~2013.9.1..17.23.05..0cc1
    ames: on localhost, UDP 60342.
    http: live on 8080
    rest: checkpoint to event 383
    rest: old 0v1c.gkr1o, new 0v10.m4gdu
    ---------------- playback complete----------------
    waclux-tomwyc/try=> 

Use your arrow keys and you'll see your history is still there.
Arvo is indestructible and can be shut down however you like
without losing data.  Also, starting a new process while an old
one is still running will kill the old one safely.  And, to leave
a server running in the background, use `vere -d`.

But don't try to operate the same ship on two Unix hosts at the
same time.  This will confuse everyone, including yourself.

##1.2 Path magic##

What do we know?  Okay, so this is an OS.  It's a little like
Unix but different.  It can print expressions and run commands.
Commands start with a colon.  Let's try the simplest command:

    ~waclux-tomwyc/try=> :ls
    ! type-fail
    ! exit

Hey, that didn't work!  It didn't work for two reasons.  One,
Arvo command-line arguments are typed, and `:ls` expects a path.
Two, `:ls` needs that path - unlike in Unix, applications can't
see the current path or shell variables.  (This is because Arvo
doesn't have 57 different ways of configuring an app.)  So try

    ~waclux-tomwyc/try=> :ls /~waclux-tomwyc/try=
    con bin lib doc

This seems somewhat cumbersome - isn't there a way to refer to
the current path?  There is, though it doesn't look like Unix.

    ~waclux-tomwyc/try=> :ls %
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

As in Unix, the shell (`batz`) keeps a current path.  As in 
Unix, you can write paths in an absolute or relative syntax,
and as in Unix `/` is the path separator.  Everything else
is completely different.

Let's use the REPL to print out some paths.  First, here's
the current path or something like it:

    ~waclux-tomwyc/try=> /~waclux-tomwyc/try/~2013.9.1
    ['~waclux-tomwyc' %try '~2013.9.1' ~]

For complicated reasons related to the Hoon type system - which, 
for a higher-order functional type inference engine, is as stupid
as we could make it - this noun gets rendered as a tuple rather
than a path.  We can rectify this with a cast:

    ~waclux-tomwyc/try=> `path`/~waclux-tomwyc/try/~2013.9.1
    /~waclux-tomwyc/try/~2013.9.1

It's the same value, just printed differently.  Except for the
date, this is the same as your current path:

    ~waclux-tomwyc/try=> `path`%
    /~waclux-tomwyc/try/~2013.9.1..17.49.18..282e

The current date, of course, is always changing:

    ~waclux-tomwyc/try=> `path`%
    /~waclux-tomwyc/try/~2013.9.1..17.50.39..7e38

Just to remind ourselves that these are Hoon expressions:

    ~waclux-tomwyc/try=> `path`/(scot %p ->-)/try/(scot %da (add ~d7 -<-))
    /~waclux-tomwyc/try/~2013.9.8..17.55.03..b2ae

That's you next week.  It's black magic, don't worry about it.
Let's get back to relative paths.

A relative path is a function of the current path.  First, let's
make the current path interesting by moving to something deeper:

    ~waclux-tomwyc/try=> :cd /=main=/foo/bar/baz/bam
    ~waclux-tomwyc/main=/foo/bar/baz/bam> 

Hey, wait, we actually used a relative path here.  The simplest
kind of relative path matches the current path by replacing a
path component with `=`.  So we could just as well have said

    ~waclux-tomwyc/main=/foo/bar/baz/bam> -<+
    '~2013.9.1..21.38.34..7a08'
    ~waclux-tomwyc/main=/foo/bar/baz/bam> :cd /~waclux-tomwyc/main/[-<+]/foo/bar/baz/bam

Why is `-<+` the current date as text?  Look, we're trying to
learn Arvo without too much Hoon here.  Just accept that it is.
In this context, anyway.  Notice also that the prompt uses a
relative path when (as is usually the case) the current case 
is just the present time, so that we don't have to stare at

    ~waclux-tomwyc/main/~2013.9.1..21.38.34..7a08/foo/bar/baz/bam>

In any case, we can now use `=` to our heart's content.  Notice
that you don't need `/` to separate content from 

    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`/=
    /~waclux-tomwyc
    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`/==
    /~waclux-tomwyc/main
    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`/===
    /~waclux-tomwyc/main/~2013.9.1..21.46.46..b250
    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`/===zebra==
    /~waclux-tomwyc/main/~2013.9.1..21.47.45..9ec8/zebra/bar/baz

I guess you could do this on Unix.  With awk or something.  It's
apparently been some time since the Nixon administration - how
about a new OS?  Anyway, there's another way to edit paths - with
`%`, which we've seen before, from the end -

    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`%
    /~waclux-tomwyc/main/~2013.9.1..21.53.17..07f6/foo/bar/baz/bam
    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`%/frampton/comes/alive
    /~waclux-tomwyc/main/~2013.9.1..21.55.53..8c5f/foo/bar/baz/bam/frampton/comes/alive

Unix can back up with `..`.  We do the same with multiple `%`:

    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`%%
    /~waclux-tomwyc/main/~2013.9.1..22.22.51..34a1/foo/bar/baz
    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`%%%
    /~waclux-tomwyc/main/~2013.9.1..22.22.53..a332/foo/bar
    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`%%%%
    /~waclux-tomwyc/main/~2013.9.1..22.22.55..4909/foo
    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`%%%%/frampton/comes/alive
    /~waclux-tomwyc/main/~2013.9.1..22.23.02..9b05/foo/frampton/comes/alive

Finally, we can use `%` as a separator and edit both prefix and
suffix.  In this case, `=` is assumed up to the endpoint edit:

    ~waclux-tomwyc/main=/foo/bar/baz/bam> `path`/=zebra%%%%/frampton/comes/alive
    /~waclux-tomwyc/zebra/~2013.9.1..22.26.39..e76d/foo/frampton/comes/alive

Thus concludes our edition of Path School.  Let's go back to the
default desk (`try`, meant for experiments only):

    ~zod/main=/foo/bar/baz/bam> :cd /=try=
    ~zod/try=> 

To be fair, Unix has some cool features that Arvo is still
missing - such as globbing (expanding `*` and the like).  A
toddler can't really go to war against a middle-aged neckbeard.
But if Arvo is a toddler, hopefully it's a promising toddler.

##1.2 Actual editing##

But wait!  There seem to be a bunch of files in your ship.  How
did they get there?  Oh, right, installation automatically
checked them out of the server.  That's one way to get files.
We'll see more of this in a little bit.

Another way is to create them within Arvo itself.  We'll see this
in a moment, but it's worth noting its limitations - no one has
ported `vim` to Urbit yet, nor will for a long time.

The easiest way to get data in and out of Arvo is just to sync.
You'll find a complete copy of your ship's filesystem, as of the
current date, in your `$URBIT_HOME`.  For example:

    ~zod/try=> :cat %/bin/goodbye/hoon
    !:
    |=  *
    |=  [planet=tape ~]
    ^-  bowl
    :_  ~
    :_  ~
    :-  %$
    !>("hello, {planet}.")
    ~zod/try=>

Then either stop the server with ^D, or switch to another window:

    oxford:~/urbit; cat $URBIT_HOME/zod/try/bin/goodbye.hoon
    !:
    |=  *
    |=  [planet=tape ~]
    ^-  bowl
    :_  ~
    :_  ~
    :-  %$
    !>("hello, {planet}.")
    oxford:~/urbit; 

As you see, the dot-extension pattern in Unix gets converted to a
path slash in Urbit.  Otherwise, the mapping is straightforward.
Legal Urbit paths are a subset of Unix paths - for example,
uppercase characters are not allowed - 
