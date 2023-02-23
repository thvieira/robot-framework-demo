*** Settings ***
Documentation  Bookstore Demo
          ...  Books Creation API Contract Testing
Library        RequestsLibrary
Library        JSONLibrary
Resource       ../../../resources/config.resource
Test Tags      api  books  creation

*** Test Cases ***
Scenario: Create book
  [Tags]  B006
  ${body} =     Load Json From File   resources/requests/create_book.json
  ${respose} =  POST  ${BOOKSTORE_API}/books   json=${body}   expected_status=201
  Log  ${respose}

Scenario: Create book with repeated ISBN
  [Tags]  B007
  No Operation  

Scenario: Create book with invalid or omitted data
  [Tags]  B008
  No Operation  

Scenario: Try to crate book not authenticated
  [Tags]  B009
  No Operation  

Scenario: Try to crate book without permission
  [Tags]  B010
  No Operation  
