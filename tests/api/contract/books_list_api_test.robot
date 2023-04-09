*** Settings ***
Documentation  Books List API Contract Testing
Test Tags      api  books  list

Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/dataprovider.resource
Resource       ../../../resources/services/books_service.resource

*** Test Cases ***
Scenario: List all books
  [Tags]  B001
  When I get books list
  Then I should see a books list
   And I should see response status code 200

Scenario: List books with filter by ISBN
  [Tags]  B002  ISBN
  Given I get a fake book
    And I insert the fake book into database
   When I search for the fake book by ISBN
   Then I should see response status code 200
    And I should see the fake book in books list response
    And I should see 1 book in books list response
   [Teardown]  I should remove the fake book from database

Scenario: List books with filter by author
  [Tags]   B002  author
  No Operation  

Scenario: List books with filter no results
  [Tags]   B003
  No Operation  

Scenario: Find book by ID
  [Tags]   B004
  Given I get a fake book
    And I insert the fake book into database
   When I get the fake book by ID
   Then I should see response status code 200
    And I should see the fake book informations
  [Teardown]  I should remove the fake book from database

Scenario: Find book by non-existent ID
  [Tags]   B005
  No Operation    
