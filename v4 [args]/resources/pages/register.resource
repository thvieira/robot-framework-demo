*** Settings ***
Documentation  Register Page Actions
Resource       ../page_objects/register_page_object.resource

*** Keywords ***
I submit register form 
  Submit Form     ${REGISTER_BUTTON}

I accept the terms of use
  Select Checkbox            ${TERMS_OF_USE_CHECKBOX}

##############################
##   Posicional arguments   ##
##############################
I fill register form 
  [Arguments]     ${name}  ${mail}  ${pass}
          ...     ${confirm_pass}   ${business_entity}
  Input Text      ${NAME_TEXT_FIELD}           ${name}
  Input Text      ${MAIL_TEXT_FIELD}           ${mail}
  Input Password  ${PASS_TEXT_FIELD}           ${pass}
  Input Password  ${CONFIRM_PASS_TEXT_FIELD}   ${confirm_pass}
  Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  ${business_entity}

I should see a success message
  [Arguments]  ${message}
  Wait Until Page Contains   ${message}

###########################
##   Embeded arguments   ##
###########################
I fill "${name}" in name text field
  Input Text      ${NAME_TEXT_FIELD}           ${name}

I fill "${mail}" in e-mail text field
  Input Text      ${MAIL_TEXT_FIELD}           ${mail}

I fill "${pass}" in pass text field
  Input Text      ${PASS_TEXT_FIELD}           ${pass}

I fill "${confirm_pass}" in confirm pass text field
  Input Text      ${CONFIRM_PASS_TEXT_FIELD}   ${confirm_pass}

I select "${business_entity}" in business entity combo box
  Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  ${business_entity}

I should see the "${message}" message
  [Documentation]  Esta palavra-chave aguardará por que a  
              ...  mensagem esperada seja exibida na tela por  
              ...  até 10 segundos. Caso contrário, o teste 
              ...  falhará por timeout.
  Wait Until Page Contains   text=${message}  timeout=10
