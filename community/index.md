---
layout: page
title: Community
axis: root
sort: 2
---

The Urbit community continuously interacts on Urbit itself using `:chat`. Check out the [setup](/setup/) page for instructions on how to come join us. We're there to answer questions and discuss anything Urbit might bring up.

##Regular Weekly Urbit Chat

Wednesdays at 6PM PST (UTC-8) we get together on Urbit `:chat` to discuss what we have been building, answer questions, and check in. Logs are below.

<ul class="chat">
{% assign chats = site.axis.chat-log | reverse %}
{% for page in chats %}
<li>
<h4>{{ page.title }}</h4>
{{ page.content }}
Complete log <a href="http://chat.urbit.org/{{ page.log }}">here</a>.
</li>
{% endfor %}
</ul>

##Mailing List
Long form discussion and technical support can be found on our [mailing list](https://groups.google.com/forum/#!forum/urbit-dev).

##GitHub
Urbit is 100% open source. [Check it out](https://github.com/urbit/urbit).

##Futher reading / watching
A fair bit has been written about what Urbit is, was or could be. This is a only a subset, but could help to give you an idea of where we're coming from.

<ul>
<li><a href="http://vimeo.com/75312418">Urbit demo video ~2013.9.23</a></li>
{% for page in site.axis.further-reading %}
<li><a href="{{ page.url }}">{{ page.title }}</a></li>
{% endfor %}
</ul>

##Nock Interpreters

One great way to test your understanding of Nock is to write an interpreter. This has become a common practice in the community. If you write one, send it over!

###Python

+ `~rammul-sigfet` [https://github.com/eykd/nock](https://github.com/eykd/nock)
+ `~dolsun-hoptes` [https://github.com/jtauber/pynock/](https://github.com/jtauber/pynock/)
+ `~parsym-dortex` [https://github.com/calcu16/urbit/blob/master/extras/simulator.py](https://github.com/calcu16/urbit/blob/master/extras/simulator.py)

###Ruby

+ `~lopdev-dirlut` [~lopdev-dirlut](https://github.com/tjic/nock)
+ `davidbalbert` [https://github.com/davidbalbert/nock.rb](https://github.com/davidbalbert/nock.rb)

###JavaScript

+ `~nimtep-dibteb` [https://github.com/famousj/nock.js](https://github.com/famousj/nock.js)
+ `~rampyx-mirpec` [http://jsfiddle.net/anoxic/TXT5V/8/embedded/result/](http://jsfiddle.net/anoxic/TXT5V/8/embedded/result/)

###Haskell
+ `mmakowski` [https://github.com/mmakowski/hock](https://github.com/mmakowski/hock)
+ `mbrubeck` [https://github.com/mbrubeck/mynock](https://github.com/mbrubeck/mynock)
+ `~hobmed-hinrym` [https://github.com/mrdomino/hsnock](https://github.com/mrdomino/hsnock)

###Lisp

+ `~dilnem-nodfun` [https://github.com/cmm/nock](https://github.com/cmm/nock)

###C

+ `zass30` [https://github.com/zass30/Nock5KCSharp](https://github.com/zass30/Nock5KCSharp)

###Clojure

+ `~lapled-rammyn` [https://github.com/jordanlewis/nock-clj](https://github.com/jordanlewis/nock-clj)

###F

+ `~portem-ravdet` [https://github.com/martindevans/NockFSharp](https://github.com/martindevans/NockFSharp)

###Racket
+ `~wictuc-folrex` [https://github.com/philipcmonk/racketnock](https://github.com/philipcmonk/racketnock)

###Scala
+ `swaldman` [https://github.com/swaldman/nnnock](https://github.com/swaldman/nnnock)
