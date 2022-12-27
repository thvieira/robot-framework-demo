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
    Given Click Link     ${MY_ACCOUNT_BUTTON}
    When Input Text      ${NAME_TEXT_FIELD}                  Lorem ipsum
     And Input Text      ${MAIL_TEXT_FIELD}                  lorem@ipsum.com
     And Input Password  ${PASS_TEXT_FIELD}                  12345
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}         12345
     And Select From List By Label  ${USER_TYPE_TEXT_FIELD}  Pessoa Física
     And Submit Form                ${REGISTER_BUTTON}
    Then Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!
     And Page Should Contain Link   ${WISH_LIST_LINK}
    
Scenario: Success sign in as Juridicial Person
    Given Click Link     ${MY_ACCOUNT_BUTTON} 
    When Input Text      ${NAME_TEXT_FIELD}                  Lorem ipsum
     And Input Text      ${MAIL_TEXT_FIELD}                  lorem@ipsum.com
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}         12345
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}         12345
     And Select From List By Label  ${USER_TYPE_TEXT_FIELD}  Pessoa Jurídica
     And Submit Form                ${REGISTER_BUTTON}
    Then Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!
     And Page Should Contain Link   ${WISH_LIST_LINK}
    