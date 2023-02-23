*** Settings ***
Documentation  Bookstore Demo
          ...  Books Edition API Contract Testing
Library        RequestsLibrary
Default Tags   api  books  edition

Suite Setup  Create Session  bookstore-demo  http://tst.bookstore-demo.com/

*** Test Cases ***
Scenario: Edit book
  [Tags]  B011
  No Operation  
	
Scenario: Edit book with invalid data
  [Tags]  B012
  No Operation  

Scenario: Edit non-existent book
  [Tags]  B013
  No Operation  
