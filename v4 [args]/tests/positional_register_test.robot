*** Settings ***
Documentation   Como cliente da loja virtual, desejo criar um 
          ...   cadastro no sistema para poder visualizar meus 
          ...   pedidos e lista de desejos.
Library         SeleniumLibrary
Resource        ../resources/config.resource
Resource        ../resources/pages/home.resource
Resource        ../resources/pages/menu.resource
Resource        ../resources/pages/account.resource
Resource        ../resources/pages/register.resource

Test Setup      Open Browser   ${URL}  ${BROWSER}  
Test Teardown   Close Browser  

*** Test Cases ***
Scenario: Success sign in as Natural Person
    Given I am on Bookstore Demo web site
      And I go to log in or sign in page
     When I fill register form  
          ...  name=Lorem ipsum  mail=lorem@ipsum.com  pass=12345
          ...  confirm_pass=12345  business_entity=Pessoa Física 
      And I submit register form 
     Then I should see a success message  message=Lorem ipsum, teu cadastro foi realizado com sucesso!
      And I should see My Wish List
      And I should see My Orders
    
Scenario: Success sign in as Juridicial Person
    Given I am on Bookstore Demo web site
      And I go to log in or sign in page
     When I fill register form      
          ...  name=Lorem ipsum LTDA  mail=contact@ipsum.com  pass=12345
          ...  confirm_pass=12345  business_entity=Pessoa Jurídica 
      And I submit register form 
     Then I should see a success message  message=Lorem ipsum LTDA, teu cadastro foi realizado com sucesso!
      And I should see My Wish List
      And I should see My Orders

