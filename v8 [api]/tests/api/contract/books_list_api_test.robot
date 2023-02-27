*** Settings ***
Documentation  Bookstore Demo
          ...  Books List API Contract Testing
Library        RequestsLibrary
Library        Collections
Resource       ../../../resources/config.resource
Resource       ../../../resources/services/books_service.resource
Test Tags   api  books  list

*** Test Cases ***
Scenario: List all books
  [Tags]   B001
  When I get books list
  Then I should see a books list
   And I should see response status code 200

Scenario: List books with filter (ISBN, título ou autor)
  [Tags]   B002
  No Operation  

Scenario: List books with filter no results
  [Tags]   B003
  Given I have none book in the database
   When I get books list
   Then I should see an empty book list
    And I should see response status code 204

Scenario: Find book by ID
  [Tags]   B004
  No Operation  

Scenario: Find book by non-existent ID
  [Tags]   B005
  No Operation  
