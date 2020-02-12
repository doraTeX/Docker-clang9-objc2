#/bin/bash

function clang-objc () {
  ${CC} $(gnustep-config --objc-flags) $(gnustep-config --objc-libs) -fobjc-arc -lobjc -ldispatch -lgnustep-base $*
}

function test_command () {
  echo \$ "$*"
  $*
  RESULT=$?
  if [ ${RESULT} -eq 0 ]; then
    echo -e "\n\e[37;42;1mSUCCEEDED\e[m\n"
  else
    echo -e "\n\e[37;41;1mFAILED\e[m\n"
  fi
  return ${RESULT}
}

( cd test/blocks
  rm -rf a.out
  test_command clang-objc blocktest.m \
  && test_command ./a.out
)

( cd test/misc
  rm -rf a.out
  test_command clang-objc misc.m \
  && test_command ./a.out
)

( cd test/GCD_ARC
  rm -rf a.out
  test_command clang-objc Fraction.m helloGCD_ARC_objc.m \
  && test_command ./a.out
)

( cd test/GCD_ARC
  test_command make clean \
  && test_command make \
  && test_command openapp ./FractionArcDemo.app
)

( cd test/GUI
  test_command make clean \
  && test_command make \
  && test_command openapp ./GUITest.app
)

