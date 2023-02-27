*** Settings ***
Documentation  Bookstore Demo
          ...  Books Creation API Contract Testing
Library        RequestsLibrary
Library        FakerLibrary
Library        JSONLibrary
Library        Collections
Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/dataprovider.resource
Resource       ../../../resources/services/auth_service.resource
Resource       ../../../resources/services/books_service.resource
Test Tags      api  books  creation

*** Test Cases ***
Scenario: Create book
  [Tags]  B006
  Given I am authenticated
    And I generate an ISBN
   When I post a new book with the ISBN ${FAKE_ISBN}
   Then I should see response status code 201
    And I should see the inserted ID 
    And I should see the inserted book in database  id= ${INSERTED_ID}  isbn=${FAKE_ISBN}
    And I should remove the book from database  id=${INSERTED_ID}
  
Scenario: Create book with repeated ISBN
  [Tags]  B007
#  Given I am authenticated
#    And I 
#   When I post a new book with the ISBN ${FAKE_ISBN}
#   Then I should see response status code 409

Scenario: Create book with invalid or omitted data
  [Tags]  B008
  No Operation  

Scenario: Try to crate book not authenticated
  [Tags]  B009
  No Operation  

Scenario: Try to crate book without permission
  [Tags]  B010
  No Operation  
