*** Settings ***
Resource  ../page_objects/register_page.resource

*** Keywords ***
preencho o formulário com meus dados
  Input Text      ${NAME_TEXT_FIELD}           Lorem ipsum
  Input Text      ${MAIL_TEXT_FIELD}           lorem@ipsum.com
  Input Password  ${PASS_TEXT_FIELD}           12345
  Input Password  ${REGISTER_PASS_TEXT_FIELD}  12345
  Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Física

submeto os dados do formulário
  Submit Form     ${REGISTER_BUTTON}

devo receber uma mensagem de sucesso
  Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!
