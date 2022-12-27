*** Settings ***
Documentation   Como cliente da loja virtual, desejo criar um 
          ...   cadastro no sistema para poder visualizar meus 
          ...   pedidos e lista de desejos.
Library         SeleniumLibrary
Resource        ../resources/config.resource
Resource        ../resources/page_objects/menu_page_object.resource
Resource        ../resources/page_objects/account_page_object.resource
Resource        ../resources/page_objects/register_page_object.resource

Test Setup      Open Browser   ${URL}  ${BROWSER}  
Test Teardown   Close Browser  

*** Test Cases ***
Scenario: Success sign in as Natural Person
    Given I am on Bookstore Demo web site
      And I go to log in or sign in page
     When I fill register form 
      And I submit register form 
     Then I should see a success message
      And I should see My Wish List
    
Scenario: Success sign in as Juridicial Person
    Given Click Link     ${MY_ACCOUNT_BUTTON}
    When Input Text      ${NAME_TEXT_FIELD}           Lorem ipsum LTDA
     And Input Text      ${MAIL_TEXT_FIELD}           contact@ipsum.com
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}  12345
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}  12345
     And Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Jurídica
     And Submit Form                ${REGISTER_BUTTON}
    Then Wait Until Page Contains   Lorem ipsum LTDA, teu cadastro foi realizado com sucesso!
     And Page Should Contain Link   ${WISH_LIST_LINK}
    
*** Keywords ***
I am on Bookstore Demo web site
  Title Should Be  Bookstore Demo

I go to log in or sign in page
  Click Link     ${MY_ACCOUNT_BUTTON}

I fill register form 
  Input Text      ${NAME_TEXT_FIELD}           Lorem ipsum
  Input Text      ${MAIL_TEXT_FIELD}           lorem@ipsum.com
  Input Password  ${PASS_TEXT_FIELD}           12345
  Input Password  ${REGISTER_PASS_TEXT_FIELD}  12345
  Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Física

I submit register form 
  Submit Form     ${REGISTER_BUTTON}

I should see a success message
  Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!

I should see My Orders
  Page Should Contain Link   ${MY_ORDERS_LINK}

I should see My Wish List
  Page Should Contain Link   ${WISH_LIST_LINK}
