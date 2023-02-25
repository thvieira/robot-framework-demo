*** Settings ***
Documentation  Bookstore Demo
          ...  Books Creation API Contract Testing
Library        RequestsLibrary
Library        FakerLibrary
Library        JSONLibrary
Library        Collections
Resource       ../../../resources/config.resource
Test Tags      api  books  creation

*** Test Cases ***
Scenario: Create book
  [Tags]  B006
  Given I am authenticated
    And I generate an ISBN
   When I post a new book with the ISBN ${FAKE_ISBN}
   Then I should see response status code 201
    And I should see the inserted ID 
    And I should see the inserted book in database
  
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


*** Keywords ***
I am authenticated
  ${auth_payload} =   Create Dictionary  username=${API_USER}  password=${API_PASS}
  ${auth_response} =  POST  ${API_HOST}/auth  json=${auth_payload}  expected_status=200
  Set Global Variable  ${token}  ${auth_response.json()}[token]  
  
I generate an ISBN
  ${fake_isbn} =       FakerLibrary.Isbn13
  Set Global Variable  ${FAKE_ISBN}   ${fake_isbn}

I post a new book with the ISBN ${isbn} 
  ${body} =           Load Json From File  resources/requests/create_book.json
  Set To Dictionary   ${body}  isbn=${isbn}
  &{header} =         Create Dictionary  x-session=${token}  Content-Type=application/json
  ${response} =       POST  ${API_HOST}/books  json=${body}  headers=&{header}
  Set Global Variable  ${RESPONSE}  ${response}

I should see response status code ${expected_status}
  Status Should Be  ${expected_status}  ${RESPONSE}

I should see the inserted ID 
  ${inserted_id} =    Set Variable  ${RESPONSE.json()}[id]
  Should Not Be Empty  ${inserted_id}

I should see the inserted book in database
  ${inserted_id} =    Set Variable  ${RESPONSE.json()}[id]
  Check If Exists In Database  SELECT isbn FROM books WHERE id = '${inserted_id}' and isbn = '${FAKE_ISBN}';
