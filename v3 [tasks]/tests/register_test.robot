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
      And I accept the terms of use
      And I submit register form 
     Then I should see a success message
      And I should see My Wish List
      And I should see My Orders
    
Scenario: Success sign in as Juridicial Person
    Given Click Link     ${MY_ACCOUNT_BUTTON}
    When Input Text      ${NAME_TEXT_FIELD}           Lorem ipsum LTDA
     And Input Text      ${MAIL_TEXT_FIELD}           contact@ipsum.com
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}  foo123
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}  foo123
     And Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Jurídica
     And Select Checkbox            ${TERMS_OF_USE_CHECKBOX}
     And Submit Form                ${REGISTER_BUTTON}
    Then Wait Until Page Contains   Lorem ipsum LTDA, teu cadastro foi realizado com sucesso!
     And Page Should Contain Link   ${WISH_LIST_LINK}

