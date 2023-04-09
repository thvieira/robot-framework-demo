*** Settings ***
Documentation  Bookstore Demo
          ...  Stock E2E API Testing
Library        RequestsLibrary
Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/services/books_service.resource
Resource       ../../../resources/services/cart_service.resource
Test Tags      api  e2e  stock

*** Test Cases ***
Scenario: Product out of stock
  Given I get an out of stock book
    And I have an empty shopping cart
   When I search for ${OUT_OF_STOCK_BOOK.isbn} in books
    And I choose the first book of search list
    And I get the book ${BOOK.info.id}
    And I add ${BOOK} to the shopping cart 
   Then I should see the fail message "Product out of stock"
    And I should not see any product in my shopping cart
