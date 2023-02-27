*** Settings ***
Documentation  Bookstore Demo
          ...  Books Deletion API Contract Testing
Library        RequestsLibrary
Resource       ../../../resources/config.resource
Resource       ../../../resources/services/auth_service.resource
Resource       ../../../resources/services/books_service.resource
Test Tags   api  books  deletion

*** Test Cases ***
Scenario: Remove book
  [Tags]  B014
  Given I am authenticated
    And I have 1 book from database
   When I delete book in @{BOOKS_ID_LIST}
   Then I should see response status code 204
    And I should not see the book from @{BOOKS_ID_LIST} in the database 

Scenario: Remove books
  [Tags]  B013
  Given I am authenticated
    And I have 3 books from database
   When I delete books in @{BOOKS_ID_LIST}
   Then I should see response status code 204
    And I should not see the books from @{BOOKS_ID_LIST} in the database 
