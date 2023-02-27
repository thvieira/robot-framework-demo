*** Settings ***
Documentation  Bookstore Demo
          ...  Books Edition API Contract Testing
Library        RequestsLibrary
Test Tags   api  books  edition

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
