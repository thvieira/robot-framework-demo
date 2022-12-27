*** Settings ***
Documentation  Register Page Actions
Resource       ../page_objects/register_page_object.resource

*** Keywords ***
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
