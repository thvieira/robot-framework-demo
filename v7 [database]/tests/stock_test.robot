*** Settings ***
Library         SeleniumLibrary
Resource        ../resources/config.resource
Resource        ../resources/database.resource
Resource        ../resources/pages/home.resource
Resource        ../resources/pages/product.resource

Test Setup      Open Browser  ${URL}  ${BROWSER} 
Test Teardown   Close Browser

*** Test Cases ***
Scenario: Product out of stock
  [Tags]  go
  Given I have a product out of stock
    And I am on Bookstore Demo web site
   When I search for a book by ${isbn_of_book_out_of_estoque}
   Then I should see the "Produto indisponível" message
    And I should see the Add to Cart button disabled
    And I should see the Buy Now button disabled
