*** Settings ***
LIbrary  RequestsLibrary

*** Keywords ***
I am authenticated
  ${auth_payload} =   Create Dictionary  username=${API_USER}  password=${API_PASS}
  ${auth_response} =  POST  ${API_HOST}/auth  json=${auth_payload}  expected_status=200
  Set Test Variable   ${TOKEN}  ${auth_response.json()}[token]  
  