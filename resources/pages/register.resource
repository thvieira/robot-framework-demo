*** Settings ***
Library   SeleniumLibrary
Resource  ../page_objects/register_page_object.resource

*** Keywords ***
preencho o formulário com meus dados
  Input Text                 ${NAME_TEXT_FIELD}           Lorem ipsum
  Input Text                 ${MAIL_TEXT_FIELD}           lorem@ipsum.com
  Input Password             ${PASS_TEXT_FIELD}           foo123
  Input Password             ${CONFIRM_PASS_TEXT_FIELD}   foo123
  Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Física

aceito os termos de uso
  Select Checkbox            ${TERMS_OF_USE_CHECKBOX}

submeto os dados do formulário
  Submit Form                ${REGISTER_BUTTON}

devo receber uma mensagem de sucesso
  Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!
