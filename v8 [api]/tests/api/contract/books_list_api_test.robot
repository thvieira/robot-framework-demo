*** Settings ***
Documentation  Bookstore Demo
          ...  Books List API Contract Testing
Library        RequestsLibrary
Library        Collections
Resource       ../../../resources/config.resource
Test Tags   api  books  list

*** Test Cases ***
Scenario: List all books
  [Tags]   B001
  When I get books list
  Then I should see a books list
   And I should see response status code 200

Scenario: List books with filter (ISBN, título ou autor)
  [Tags]   B002
  Given I have a book A 
    And I have a different book B
   When I search "${A}" in books list
   Then I should see ${A}
    And I should not see ${B}

Scenario: List books with filter no results
  [Tags]   B003
  Given I have none book in the database
   When I get books list
   Then I should see an empty list
    And I should see response status code 204

Scenario: Find book by ID
  [Tags]   B004
 Given I have a book A 
  When I search "${A}" book details by ID
  Then I should see response status code 200
   And 

Scenario: Find book by non-existent ID
  [Tags]   B005
  No Operation  

*** Keywords ***
I get books list
  ${response} =  GET  ${BOOKSTORE_API}/books
  Set Global Variable  ${RESPONSE}  ${response}

I should see a books list
  Dictionary Should Contain Key   ${RESPONSE.json()}  books
  ${is_list} =  Evaluate     isinstance(${RESPONSE.json()}[books], list)
  Should Be True  ${is_list} 

I should see response status code ${expected_status}
  Status Should Be  ${expected_status}  ${RESPONSE}

I should see an empty list
    Should Be Empty  ${RESPONSE.json()}[books]