*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  JSONLibrary
Library  ../libraries/MyLibrary.py 

*** Keywords ***
I get books list
  ${response} =      GET          ${API_HOST}/books
  Set Test Variable  ${RESPONSE}  ${response}

I should see a books list
  Dictionary Should Contain Key  ${RESPONSE.json()}  books
  Should Be List                 objet=@{RESPONSE.json()}[books]
  #${is_list} =  Evaluate  isinstance(${RESPONSE.json()}[books], list)
  #Should Be True  ${is_list} 

I should see response status code ${expected_status}
  Status Should Be  ${expected_status}  ${RESPONSE}

I search for the fake book by ISBN
  I search for ${FAKE_BOOK.isbn} in books

I search for the out-of-stok book by ISBN
  I search for ${OUT_OF_STOCK_BOOK.isbn} in books

I search for ${something} in books
  &{query_params} =  Create Dictionary       search=${something}
  ${response} =      GET  ${API_HOST}/books  params=&{query_params}
  Set Test Variable  ${RESPONSE}             ${response}

I should see an empty book list
  Should Be Empty  ${RESPONSE.json()}[books]

I post a new book with the fake ISBN 
  ${body} =          Load Json From File  resources/payloads/create_book.json
  Set To Dictionary  ${body}  isbn=${FAKE_ISBN}
  &{header} =        Create Dictionary  x-session=${TOKEN}  Content-Type=application/json
  ${response} =      POST  ${API_HOST}/books  json=${body}  headers=&{header}
  Set Test Variable  ${RESPONSE}  ${response}

I should see the inserted ID in response body
  Set Test Variable    ${INSERTED_ID}  ${RESPONSE.json()}[id]
  Should Not Be Empty  ${INSERTED_ID}

I delete the fake book${s}
  IF  '${s}' == '${EMPTY}'
    ${formated_param_list} =  Set Variable    ${FAKE_BOOK.id}
  ELSE
    ${formated_param_list} =  Get comma separated list as string  list=@{FAKE_BOOK_LIST}
  END

  &{header} =        Create Dictionary  x-session=${TOKEN}  Content-Type=application/json
  &{query_params} =  Create Dictionary  id=${formated_param_list}
  ${response} =      DELETE  ${API_HOST}/books  params=&{query_params}  headers=&{header}
  Set Test Variable  ${RESPONSE}  ${response}

I change the ${field} of the fake book to ${new_value}
  &{payload} =   Create Dictionary  ${field}=${new_value}
  &{header} =    Create Dictionary  x-session=${TOKEN}  Content-Type=application/json
  ${response} =  PATCH  ${API_HOST}/books/${FAKE_BOOK.id}   headers=&{header}  json=&{payload}
  Set Test Variable  ${RESPONSE}  ${response}

I put some book by ${author} in database
  &{fake_book} =  I get a fake book
  ${fake_book.author} =  ${author}
  I insert book into database  book=&{fake_book}

I should see the fake in books list response
  Log  ${FAKE_BOOK.id}
  Log Many  ${RESPONSE.json()}

I should see the book by ${author} in list
  Log  ${author}

I should not see the book by ${author} in list
  Log  ${author}

I should see ${expected_size} book${s} in books list response 
  Log Many  ${RESPONSE.json()}

I get the fake book by ID
  ${response} =      GET  ${API_HOST}/books/${FAKE_BOOK.id}
  Set Test Variable  ${RESPONSE}  ${response}

I get the out-of-stok book
  ${response} =      GET  ${API_HOST}/books/${OUT_OF_STOCK_BOOK.id}
  Set Test Variable  ${RESPONSE}  ${response}

I should see the fake book informations
  Log Many    &{FAKE_BOOK}
  Log Many    ${RESPONSE.json()}

I choose the first book of search list
  ${first} =  Create Dictionary    info=${RESPONSE.json()}[books][0]
  Set Test Variable    ${BOOK}   ${first}


## MOVER PARA UTILS RESOURCE
# Get comma separated list as string
#   [Arguments]  @{list}
#   ${comma_separated_list} =  Get From List  ${list}  0 
#   Remove From List           ${list}        0
#   FOR  ${item}  IN  @{list}
#     ${comma_separated_list} =  Catenate  SEPARATOR=  ${comma_separated_list}  ,  ${item}
#   END
#   RETURN  ${comma_separated_list}
