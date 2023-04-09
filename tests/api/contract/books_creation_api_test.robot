*** Settings ***
Documentation  Books Creation API Contract Testing
Test Tags      api  books  creation

Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/dataprovider.resource
Resource       ../../../resources/services/auth_service.resource
Resource       ../../../resources/services/books_service.resource

*** Test Cases ***
Scenario: Create book
  [Tags]  B006
  Given I am authenticated
    And I get an fake ISBN
   When I post a new book with the fake ISBN
   Then I should see response status code 201
    And I should see the inserted ID in response body
    And I should see the inserted book in database
    And I should remove the inserted book from database
  
Scenario: Create book with repeated ISBN
  [Tags]  B007
  No Operation  

Scenario: Create book with invalid or omitted data
  [Tags]  B008
  No Operation  

Scenario: Try to create book not authenticated
  [Tags]  B009
  No Operation  

Scenario: Try to crate book without permission
  [Tags]  B010
  No Operation  
