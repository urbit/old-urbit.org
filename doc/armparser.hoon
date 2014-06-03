    !:
    ::  /=try=/bin/parseindex/hoon
    ::

    |=  *
    |=  [pax=path xap=path ~]
    ^-  bowl
    :_  ~  :_  ~
    :-  %ok
    %+  foal  xap
    =+  nl=`tape``(list ,@)`~[10]
    =+  lines=(turn (lore ((hard ,@) .^(%cx pax))) trip)
    %-  crip
    %+  roll  lines
    |=  [p=tape q=tape]
    =+  ^=  slusarm
        %+  rust  p
        ;~  sfix
          ;~  plug
            (star ace)
            lus  lus  ace  ace
            (plus ;~(pose low hep nud))
          ==
          (star (shim 32 126))
        ==
    =+  ^=  lusheparm
        %+  rust  p
        ;~  sfix  
            ;~  plug
                (star ace)
                lus  hep  ace  ace
                (plus ;~(pose low hep nud))
            ==
            (star (shim 32 126))
        ==
    ?~  lusheparm
      ?~  slusarm
        q
      ;:  weld  q              
          `tape`+>.slusarm  nl                      
      ==
    ;:  weld  q
        `tape`+>.lusheparm  nl
    ==
