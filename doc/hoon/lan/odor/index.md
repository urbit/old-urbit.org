---
layout: subpage
title: Odor
axis: doc-hoon
categories: lan overview
sort: 4
---

#Odor —

Since everything in Hoon is a natural number, we need some way of knowing what we indend those numbers to look like. That's what odors are for.

An odor is exactly what it looks like - an ASCII span.  This span is a taxonomy which grows more specific to the right.  For instance, `@t` for UTF-8 text, `@ta` for URL-safe ASCII text, `@tas` for a Hoon symbol; or `@u` for an unsigned integer, `@ux` for an unsigned integer formatted as hexadecimal.

The general principle of type enforcement is that atoms change freely either up or down the taxonomy, but not across.  For instance, you can treat a `@tas` as a `@t`, as in a strong type system; but you can also treat a `@t` as a `@tas`, or an `@` as anything.  However, passing a `@t` to a function that expects an `@ux` is a type error.

    @c              UTF-32 codepoint
    @d              date
      @da           absolute date
      @dr           relative date (ie, timespan)
    @f              yes or no (inverse boolean)
    @n              nil
    @p              phonemic base
    @r              IEEE floating-point
      @rd           double precision  (64 bits)
      @rh           half precision (16 bits)
      @rq           quad precision (128 bits)
      @rs           single precision (32 bits)
    @s              signed integer, sign bit low
      @sb           signed binary
      @sd           signed decimal
      @sv           signed base32
      @sw           signed base64
      @sx           signed hexadecimal
    @t              UTF-8 text (cord)
      @ta           ASCII text (span)
        @tas        ASCII symbol (term)
    @u              unsigned integer
      @ub           unsigned binary
      @ud           unsigned decimal
      @uv           unsigned base32
      @uw           unsigned base64
      @ux           unsigned hexadecimal

###Examples

    ~talsur-todres/try=> `@`'hoon'
    1.852.796.776
    ~talsur-todres/try=> `@ta`1.852.796.776
    ~.hoon

    ~waclux-tomwyc/try=> :type; 'u'
    'u'
    @ta

    ~waclux-tomwyc/try=> :type; 256 
    256
    @ud

    ~waclux-tomwyc/try=> :type; (add 'u' (mul 256 'd'))
    25.717
    @
    ~waclux-tomwyc/try=> `@ta`25.717
    ~.ud

##Size

Besides these prefixes, which indicate the rendering and/or meaning of atoms, the odor system has another orthogonal mechanism to restrict the size of atoms.  Like the prefix, this mechanism is weak - it is not enforced and trivially evaded.

An odor span contains two parts, both optional: a lowercase prefix and an uppercase suffix.  The suffix, if present, is a single character A-Z `c` which indicates an atom of size less than or equal to `n` bits, where `n` is `1 << (c - 'A')`. Thus, `@tD` is one UTF-8 byte (whatever that means); `@tN` is a kilobyte or less of UTF-8.

    A   1 bit
    B   2 bits
    C   4 bits
    D   1 byte
    E   2 bytes
    F   4 bytes
    G   8 bytes
    H   16 bytes
    I   32 bytes
    J   64 bytes
    K   128 bytes
    L   256 bytes
    M   512 bytes
    N   1K
    O   2K
    P   4K
    Q   8K
    R   16K
    S   32K
    T   64K
    U   128K
    V   256K
    W   512K
    X   1MB
    Y   2MB
    Z   4MB

You of course can build an atom larger than 4MB, though whether you should is another question entirely.  But the type system cannot express a size odor above 4MB.

