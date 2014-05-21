We're going to walk through the creation of [fizzbuzz](http://en.wikipedia.org/wiki/Fizz_buzz#Other_uses) in hoon. You can find the relevant source at `/~sarlug-picwep/pike=/jpt4/fizzbuzz/fzbz/hoon` in the Urbit namespace, or on GitHub [here](http://github.com/urbit.walkthroughs/lib/fzzbzz/hoon). 

It's recommended that you keep that file open for reference while reading this walkthrough. To get it in to your Urbit ship drop it in `/urb/$SHIP_NAME/try/bin/` where `$SHIP_NAME` is the name of your ship that looks like `talsur-todres`. To run the file you should be able to run something like:

    ~talsur-todres/try=> :fzbz [1 20]

at your Arvo prompt.

Traditionally, the FizzBuzz Problem tasks the programmer to implement
the following function:

    f(x)={fizz, x=0 (mod 3)
          buzz, x=0 (mod 5)
          fizzbuzz, x=0 (mod 15)
          x, otherwise}
    for 0 <= x <= n, some natural number.

In English, given a range of whole numbers from 0 to n, replace every number divisible by 3, 5, and 15 with "fizz", "buzz", and "fizzbuzz", respectively.

There are two parts to writing this for Urbit: constructing the logic of the program in Hoon and situating it so that it can be called from Arvo.  For the time being we're going to just stick to the Hoon logic. 

`fzbz.hoon` consists of two arms, `++fizz` and `++buzz`.

    ++  fizz

is the outer or main function, and contains a gate (`|=`):

    |= [a=@ b=@]

that expects two arguments (`[a=@ b=@]`), both of type `@` or atom (unsigned integers, including zero). Our FizzBuzz will be slightly more complicated than described above, since the set of numbers it ranges over won't necessarily have to start at zero.

The default product type of our `++fizz`:

    ^- tape

is a `tape` &mdash; a list of chars. Each char is odor `@tD`, a UTF-8 byte. Kethep (`^-`) casts the twig (everything from `?.` onward) to this specified default type (the [bunt](/doc/hoon/lan/rune/#buccab) of a `tape`).

The "If-Else-Then" (note this is the reverse of "If-Then-Else") rune, `?.`:

    ?.  (lte a b)

evaluates a loobean ("yes" or "no") expression. In this case `(lte a b)` checks if `a` is less than or equal to `b`. performing the *second* subsequent branch of code if true (aka `%.y`, yes or `&`).  This prevents nesting of the longer of the two cases. If `a` is greater than `b`, ++fizz yields the error message:

    "startpoint is greater than endpoint, please reconsider"

Note that this is not a printf or other kind of debugging side-effect, but a correctly typed product value. Use `~&` ([sigpam](/doc/hoon/lan/rune/#sigpam)) for your unsafe printing needs.

So long as `a` is not greater than `b`, flow to the heavier branch, a conventional "If-Then-Else" wutcol

    ?: =(a b)

which checks if `a` equals `b`. If so, evaluate, non-recursively,

    (buzz a)

that is, `++buzz` called with the value of `a` (that is, the value of `b` since they are equal).

Jumping to:

    ++ buzz

we find a gate

    |= a=@ ^- tape

accepting a single argument `a` of type `@` and producing a value with default type `tape`.

The nested wutcols flow, producing either "fizzbuzz", "fizz", or "buzz" depending on which of

    =((mod a 15) 0)

    =((mod a 5) 0)

    =((mod a 3) 0)

evaluates `&` (read "`=((mod a n) 0)`" as "zero tis a mod n").

Until the final branch, however, when `a` is transformed from an unsigned decimal (as opposed to binary, hex, etc.) integer into a tape via [`++scow`]():

    (scow %ud a)

`++buzz` is thus no more than set of endpoints to which might be called
to produce a certain output for a cetain input value.

Back to `++fizz`, the last line:

    :(welp (buzz a) " " $(a +(a)))

packs three operations into one. The structure it builds is a `welp` (tape concatenation), the first element of which is the product of a call to `++buzz` with a. The next is the tape " " (a space character). The last is whatever the expression is produced by:

    $(a +(a))

the recursive call to `++fizz`, with `a` (and only `a`) replaced by:

    +(a)

a incremented by 1.

The call trace of this recursive welp expression for `(fizz [3 7])` would look like

    :(welp (buzz 3) 
      " " 
        :(welp (buzz 4) 
          " " 
            :(welp (buzz 5) 
              " " 
                :(welp (buzz 6) " " (buzz 7)))))

necessitating the `:` before the (`welp ...`), which transforms a function accepting a fixed number of arguments into one accepting an arbitrary number, in this case three.

Thus concludes the Hoon logic. 