*** Settings ***
Documentation  Stock E2E API Testing
Test Tags      api  e2e  stock

Resource       ../../../resources/config.resource
Resource       ../../../resources/database.resource
Resource       ../../../resources/services/books_service.resource
Resource       ../../../resources/services/cart_service.resource

*** Test Cases ***
Scenario: Product out of stock
  Given I get an out of stock book
    And I have an empty shopping cart
   When I search for the out-of-stok book by ISBN
    And I choose the first book of search list
    And I get the out-of-stok book
    And I add the out-of-stock book to the shopping cart 
   Then I should see the fail message "Product out of stock"
    And I should not see any product in my shopping cart
