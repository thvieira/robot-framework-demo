*** Settings ***
Documentation  Home Actions

*** Keywords ***
#I am on Bookstore Demo web site
#  Title Should Be  Bookstore Demo

I am on ${expected} web site
  Title Should Be  ${expected}