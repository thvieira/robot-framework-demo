*** Settings ***
Documentation   Como cliente da loja virtual da livraria Bookstore Demo, 
          ...   desejo saber quando um produto está fora de estoque.


Resource        ../resources/config.resource
Resource        ../resources/database.resource
Resource        ../resources/pages/home.resource
Resource        ../resources/pages/product.resource

Test Tags       products  stock  db
Test Setup      Open Browser  ${URL}  ${BROWSER} 
Test Teardown   Close Browser

*** Test Cases ***
Scenario: Product out of stock
  Given I have a book out of stock
    And I am on Bookstore Demo web site
   When I search for this book by ISBN
   Then I should see the "Produto indisponível" message
    And I should see the Add to Cart button disabled
    And I should see the Buy Now button disabled
