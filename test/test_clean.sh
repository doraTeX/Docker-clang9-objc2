#/bin/bash

CWD=$(dirname "$0")
cd "${CWD}"

( cd test/blocks
  rm -rf a.out *.d
)

( cd test/misc
  rm -rf a.out *.d
)

( cd test/GCD_ARC
  rm -rf a.out *.d *.app obj
)

( cd test/GUI
  rm -rf a.out *.d *.app obj
)

