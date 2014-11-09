---
layout: post
categories: articles
axis: further-reading
sort: 0
author: jcb
title: Continuity Breach
date: 2014-11-09 09:59
---

A continuity breach occurs when the entire Urbit network gets recreated- this will not happen in real life! All ships and piers prior to the breach will no longer work with the new network.

What does this mean for the Urbit user? If your ships have spontaneously stopped working and you built your ships and piers before the date in the lower left-hand corner of this site, (the Urbit date format is ~year.month.day), run the following commands from your urbit directory:

1. `git pull origin master` to get the up to date source
2. `make clean; make` to build
3. Back up your pier directory, `$mypier`.
4. `rm -rf $mypier` to wipe your pier.
5. `bin/vere -c $mypier` to build a new pier.
6. `:begin` and relaunch your destroyers.
7. `:chat to chat`.

Email `urbit@urbit.org` if you have any questions or would like assistance. 
