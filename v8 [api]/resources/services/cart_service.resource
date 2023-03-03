*** Settings ***
Library  Collections

*** Keywords ***
I add the product ${BOOK_ID} to the shopping cart ${CART_ID}
  ${payload} =         Create Dictionary  item=${BOOK_ID}
  ${response} =        POST  ${API_HOST}/cart/${CART_ID}  json=${payload}  expected_status=201
  Set Global Variable  ${RESPONSE}  ${response.json()}

I should see the fail message "${msg}"
  Should Be Equal  ${msg}  ${RESPONSE}[message]

I should not see any product in my shopping cart
  ${response} =    GET  ${API_HOST}/cart/${CART_ID}  expected_status=200
  Should Be Empty  ${response.json()}[items]
