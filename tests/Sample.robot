*** Settings ***
Library  ../resources/libraries/StackLibrary.py 
Test Tags  libs

*** Test Cases ***
Scenario: Stack
  Create Stack
  Stack should be empty
  Push item to Stack  The Wall
  Push item to Stack  El condor
  Stack should be not empty
  ${r} =  Pop item from Stack
  Log  ${r}
  Stack should be not empty
  Clear Stack
  Stack should be empty
  Pop item from Stack
