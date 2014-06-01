    !:
    ::  /=try=/bin/doc/hoon
    ::

    |=  *
    |=  [pax=path ~]
    ^-  bowl
    :_  ~  :_  ~
    :-  %ok
    %+  foal  /=try=/web/docs/md
    =+  nl=`tape``(list ,@)`~[10]
    =+  lines=(turn (lore ((hard ,@) .^(%cx pax))) trip)
    %-  crip
    %+  roll  lines
    |=  [p=tape q=tape]
    =+  ^=  colline
        %+  rust  p
        ;~  plug
          (star ace)
          col  col  col
          (star (shim 32 126))
        ==
    =+  ^=  section
        ?.  (gth (lent p) 2)
          ~
        %+  rust
          (scag (sub (lent p) 2) p)
        ;~  plug
          col  col  (plus ace)
          (plus (shim 32 126))
        ==
    =+  ^=  arm
        %+  rust  p
        ;~  plug
          (star ace)
          lus  lus  ace  ace
          (plus ;~(pose low hep nud))
          (star (shim 32 126))
        ==
    ?~  arm
      ?~  section
        ?~  colline
          :(weld q "    " p nl)
        q
      ;:  weld
        q  nl  nl
        "#"  `tape`+>+>.section  nl  nl
      ==
    ;:  weld
      q  nl  nl  nl
      "---"  nl
      "<h2 id=\"++{+>+>+>-.arm}\">++&nbsp;&nbsp;{+>+>+>-.arm}</h2>"  nl  nl
      "###Summary"  nl  nl
      "    "  p  nl
    ==


