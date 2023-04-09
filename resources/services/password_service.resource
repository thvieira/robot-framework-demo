*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  JSONLibrary

*** Variable ***
${MESSAGE_TYPE}   passwordRecover

*** Keywords ***
I ask for password reset
  &{header} =    Create Dictionary  x-session=${TOKEN}            Content-Type=application/json
  &{payload} =    Create Dictionary  name=${FAKE_NAME}            recipientEmailAddress=${TO}      
                                ...  category=${MESSAGE_TYPE}     passwordRecoverCode=${FAKE_CODE}     
  ${response} =   POST               ${API_HOST}/reset-password   json=&{payload}  headers=&{header}  expected_status=202
  Set Test Variable  ${RESPONSE}  ${response} 

I should see response status code ${expected_status}
  Status Should Be  ${expected_status}  ${RESPONSE}
