*** Settings ***
Library  Collections

*** Keywords ***
I add ${book} to the shopping cart
  ${payload} =         Create Dictionary  item=${book.info.id}
  ${response} =        POST  ${API_HOST}/cart/${CART_ID}  json=${payload}  expected_status=201
  Set Global Variable  ${RESPONSE}  ${response.json()}

I should see the fail message "${expected_message}"
  Should Be Equal  ${expected_message}  ${RESPONSE}[message]

I should not see any product in my shopping cart
  ${response} =    GET  ${API_HOST}/cart/${CART_ID}  expected_status=200
  Should Be Empty  ${response.json()}[items]
