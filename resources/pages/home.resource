*** Settings ***
Library         SeleniumLibrary

*** Keywords ***
I am on ${expected} web site
  Title Should Be  ${expected}