*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  JSONLibrary

*** Variable ***
${MESSAGE_TYPE}   passwordRecover

*** Keywords ***
I ask for password reset
  [Arguments]     ${name}  ${to}  ${code}
  &{header} =    Create Dictionary  x-session=${TOKEN}  Content-Type=application/json
  &{payload} =    Create Dictionary  name=${name}                 recipientEmailAddress=${to}      
                                ...  category=${MESSAGE_TYPE}     passwordRecoverCode=${code}     
  ${response} =   POST               ${API_HOST}/reset-password   json=&{payload}  headers=&{header}  expected_status=202
  Set Global Variable  ${RESPONSE}  ${response} 

I should see response status code ${expected_status}
  Status Should Be  ${expected_status}  ${RESPONSE}
