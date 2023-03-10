*** Settings ***
Documentation  Bookstore Demo
          ...  Books Edition API Contract Testing
Library        RequestsLibrary
Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/dataprovider.resource
Resource       ../../../resources/services/auth_service.resource
Resource       ../../../resources/services/books_service.resource
Test Tags   api  books  edition

*** Test Cases ***
Scenario: Edit book
  [Tags]  B011
  Given I am authenticated
    And I get a fake book
    And I insert &{fake_book} into database
   When I change the price of the book with ID ${fake_book.id} to 10.00
   Then I should see response status code 200
    And I should see the price of book ID ${fake_book.id} with value 10.00 in database
	
Scenario: Edit book with invalid data
  [Tags]  B012
  No Operation  

Scenario: Edit non-existent book
  [Tags]  B013
  No Operation  
