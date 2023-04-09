*** Settings ***
Documentation  Books Edition API Contract Testing
Test Tags      api  books  edition

Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/dataprovider.resource
Resource       ../../../resources/services/auth_service.resource
Resource       ../../../resources/services/books_service.resource

*** Test Cases ***
Scenario: Edit book
  [Tags]  B011
  Given I am authenticated
    And I get a fake book
    And I insert the fake book into database
   When I change the price of the fake book to 10.00
   Then I should see response status code 200
    And I should see the price of the fake book with value 10.00 in database
	
Scenario: Edit book with invalid data
  [Tags]  B012
  No Operation  

Scenario: Edit non-existent book
  [Tags]  B013
  No Operation  
