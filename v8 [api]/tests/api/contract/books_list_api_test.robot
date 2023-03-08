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

Scenario: List books with filter by ISBN
  [Tags]   B002  ISBN
  Given I get a fake book
    And I insert book into database  book=&{fake_book}
   When I search for ${fake_book.isbn} in books
   Then I should see response status code 200
    And I should see the book ${fake_book.id} in ${RESPONSE.json()}
    And I should see the ${RESPONSE.json()} with size 1
  #[Teardown]  I should remove the book from database  id=${fake_book.id}

Scenario: List books with filter by author
  [Tags]   B002  author
  Given I put some book by Erico Verissimo in database
    And I put some book by Mario Benedetti in database
   When I search for Erico Verissimo in books
   Then I should see response status code 200
    And I should see the book by Erico Verissimo in list
    And I should not see the book by Mario Benedetti in list
  [Teardown]  I clear data from database 

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
