*** Settings ***
Documentation  Books Deletion API Contract Testing
Test Tags      api  books  deletion

Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/dataprovider.resource
Resource       ../../../resources/services/auth_service.resource
Resource       ../../../resources/services/books_service.resource

*** Test Cases ***
Scenario: Remove book
  [Tags]  B014
  Given I am authenticated
    And I get a fake book
    And I insert the fake book into database
   When I delete the fake book
   Then I should see response status code 204
    And I should not see the fake book in the database 

Scenario: Remove a books list
  [Tags]  B013
  Given I am authenticated
    And I get 3 fake books
    And I insert all @{FAKE_BOOK_LIST} into database
   When I delete the fake books
   Then I should see response status code 204
    And I should not see the books from @{FAKE_BOOK_LIST} in the database 
