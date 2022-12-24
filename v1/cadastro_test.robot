*** Settings ***
Documentation   Como cliente da loja virtual, desejo criar um 
          ...   cadastro no sistema para poder visualizar meus 
          ...   pedidos e lista de desejos.
Library         SeleniumLibrary

Test Setup      Open Browser  browser=firefox   url=http://127.0.0.1:5173
Test Teardown   Close Browser  

*** Variables ***
${MY_ACCOUNT_BUTTON}         Minha conta
${NAME_TEXT_FIELD}           id: register-name
${MAIL_TEXT_FIELD}           id: register-mail
${PASS_TEXT_FIELD}           id: register-pass
${REGISTER_PASS_TEXT_FIELD}  id: register-confirm-pass
${USER_TYPE_TEXT_FIELD}      id: register-user-type
${REGISTER_BUTTON}           name: register
${WISH_LIST_LINK}            /my-wish-list

*** Test Cases ***
Cenário: Cadastro com sucesso de Pessoa Física
    Given Click Link     ${MY_ACCOUNT_BUTTON}
    When Input Text      ${NAME_TEXT_FIELD}                  Lorem ipsum
     And Input Text      ${MAIL_TEXT_FIELD}                  lorem@ipsum.com
     And Input Password  ${PASS_TEXT_FIELD}                  12345
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}         12345
     And Select From List By Label  ${USER_TYPE_TEXT_FIELD}  Pessoa Física
     And Submit Form                ${REGISTER_BUTTON}
    Then Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!
     And Page Should Contain Link   ${WISH_LIST_LINK}
    
Cenário: Cadastro com sucesso de Pessoa Jurídica
    Given Click Link     ${MY_ACCOUNT_BUTTON} 
    When Input Text      ${NAME_TEXT_FIELD}                  Lorem ipsum
     And Input Text      ${MAIL_TEXT_FIELD}                  lorem@ipsum.com
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}         12345
     And Input Password  ${REGISTER_PASS_TEXT_FIELD}         12345
     And Select From List By Label  ${USER_TYPE_TEXT_FIELD}  Pessoa Jurídica
     And Submit Form                ${REGISTER_BUTTON}
    Then Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!
     And Page Should Contain Link   ${WISH_LIST_LINK}
    