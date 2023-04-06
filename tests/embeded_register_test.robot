*** Settings ***
Documentation   Como cliente da loja virtual, desejo criar um 
          ...   cadastro no sistema para poder visualizar meus 
          ...   pedidos e lista de desejos.

Resource        ../resources/config.resource
Resource        ../resources/pages/home.resource
Resource        ../resources/pages/menu.resource
Resource        ../resources/pages/account.resource
Resource        ../resources/pages/register.resource

Test Tags       register  embeded  args
Test Setup      Open Browser   ${URL}  ${BROWSER}  
Test Teardown   Close Browser  

*** Test Cases ***
Scenario: Success sign in as Natural Person
    [Tags]  natural_person

    Given I am on Bookstore Demo web site
      And I go to log in or sign in page
     When I fill "Lorem ipsum" in name text field
      And I fill "lorem@ipsum.com" in e-mail text field
      And I fill "foo123" in pass text field
      And I fill "foo123" in confirm pass text field
      And I select "Pessoa Física" in business entity combo box
      And I accept the terms of use
      And I submit register form 
     Then I should see the "Lorem ipsum, teu cadastro foi realizado com sucesso!" message
      And I should see My Wish List
      And I should see My Orders
    
Scenario: Success sign in as Juridicial Person
    [Tags]  juridicial_person
    
    Given I am on Bookstore Demo web site
      And I go to log in or sign in page
     When I fill "Lorem ipsum LTDA" in name text field
      And I fill "contact@loremipsum.com" in e-mail text field
      And I fill "foo123" in pass text field
      And I fill "foo123" in confirm pass text field
      And I select "Pessoa Jurídica" in business entity combo box
      And I accept the terms of use
      And I submit register form 
     Then I should see the "Lorem ipsum LTDA, teu cadastro foi realizado com sucesso!" message
      And I should see My Invoices
      And I should see My Orders
