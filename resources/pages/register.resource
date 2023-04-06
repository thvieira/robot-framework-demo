*** Settings ***
Library   SeleniumLibrary
Resource  ../page_objects/register_page_object.resource

*** Keywords ***
I fill register form 
  Input Text                 ${NAME_TEXT_FIELD}           Lorem ipsum
  Input Text                 ${MAIL_TEXT_FIELD}           lorem@ipsum.com
  Input Password             ${PASS_TEXT_FIELD}           foo123
  Input Password             ${CONFIRM_PASS_TEXT_FIELD}   foo123
  Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Física

I accept the terms of use
  Select Checkbox            ${TERMS_OF_USE_CHECKBOX}

I submit register form 
  Submit Form                ${REGISTER_BUTTON}

I should see a success message
  Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!
