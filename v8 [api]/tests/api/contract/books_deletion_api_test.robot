*** Settings ***
Documentation  Bookstore Demo
          ...  Books Deletion API Contract Testing
Library        RequestsLibrary
Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/dataprovider.resource
Resource       ../../../resources/services/auth_service.resource
Resource       ../../../resources/services/books_service.resource
Test Tags   api  books  deletion

*** Test Cases ***
Scenario: Remove book
  [Tags]  B014
  Given I am authenticated
    And I get a fake book
    And I insert &{fake_book} into database
   When I delete book in ${fake_book.id}
   Then I should see response status code 204
    And I should not see the book ${fake_book.id} in the database 

Scenario: Remove books
  [Tags]  B013
  Given I am authenticated
    And I get 3 fake books
    And I insert all @{FAKE_BOOK_LIST} into database
   When I delete books in @{FAKE_BOOK_LIST}
   Then I should see response status code 204
    And I should not see the books from @{FAKE_BOOK_LIST} in the database 
