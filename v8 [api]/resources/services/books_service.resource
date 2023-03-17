*** Settings ***
Library  Collections
Library  JSONLibrary

*** Keywords ***
I get books list
  ${response} =  GET  ${API_HOST}/books
  Set Global Variable  ${RESPONSE}  ${response}

I should see a books list
  Dictionary Should Contain Key   ${RESPONSE.json()}  books
  ${is_list} =  Evaluate     isinstance(${RESPONSE.json()}[books], list)
  Should Be True  ${is_list} 

I should see response status code ${expected_status}
  Status Should Be  ${expected_status}  ${RESPONSE}

I should see an empty book list
  Should Be Empty  ${RESPONSE.json()}[books]

I post a new book with the ISBN ${isbn} 
  ${body} =           Load Json From File  resources/requests/create_book.json
  Set To Dictionary   ${body}  isbn=${isbn}
  &{header} =         Create Dictionary  x-session=${TOKEN}  Content-Type=application/json
  ${response} =       POST  ${API_HOST}/books  json=${body}  headers=&{header}
  Set Global Variable  ${RESPONSE}  ${response}

I should see the inserted ID in response body
  Set Global Variable  ${INSERTED_ID}  ${RESPONSE.json()}[id]
  Should Not Be Empty  ${INSERTED_ID}

I delete book${s} in ${books_list_or_book_id}
  IF  '${s}' == '${EMPTY}'
    ${formated_param_list} =  Set Variable    ${books_list_or_book_id}
  ELSE
    ${formated_param_list} =  Get comma separated list as string  list=${books_list_or_book_id}
  END

  &{header} =          Create Dictionary  x-session=${TOKEN}  Content-Type=application/json
  &{query_params} =    Create Dictionary  id=${formated_param_list}
  ${response} =        DELETE  ${API_HOST}/books  params=&{query_params}  headers=&{header}
  Set Global Variable  ${RESPONSE}  ${response}

I change the ${field} of the book with ID ${id} to ${new_value}
  &{payload} =   Create Dictionary  ${field}=${new_value}
  &{header} =    Create Dictionary  x-session=${TOKEN}  Content-Type=application/json
  ${response} =  PATCH  ${API_HOST}/books/${id}   headers=&{header}  json=&{payload}
  Set Global Variable  ${RESPONSE}  ${response}

I put some book by ${author} in database
  Log  ${author}
  &{fake_book} =  I get a fake book
  ${fake_book.author} =  ${author}
  I insert book into database  book=&{fake_book}

I search for ${something} in books
  &{query_params} =    Create Dictionary       search=${something}
  ${response} =        GET  ${API_HOST}/books  params=&{query_params}
  Set Global Variable  ${RESPONSE}             ${response}

I should see the book ${book_id} in books list response
  Log  ${book_id}
  Log Many  ${RESPONSE.json()}

I should see the book by ${author} in list
  Log  ${author}

I should not see the book by ${author} in list
  Log  ${author}

I should see ${expected_size} book${s} in books list response 
  Log Many  ${RESPONSE.json()}

I get the book ${book_id}  
  ${response} =        GET  ${API_HOST}/books/${book_id}
  Set Global Variable  ${RESPONSE}  ${response}

I should see the book &{fake_book} informations
  Log Many    &{fake_book}
  Log Many    ${RESPONSE.json()}

I choose the first book of search list
  ${first} =  Create Dictionary    info=${RESPONSE.json()}[books][0]
  Set Global Variable    ${BOOK}   ${first}


## MOVER PARA UTILS RESOURCE
Get comma separated list as string
  [Arguments]  @{list}
  ${comma_separated_list} =  Get From List  ${list}  0 
  Remove From List           ${list}        0
  FOR  ${item}  IN  @{list}
    ${comma_separated_list} =  Catenate  SEPARATOR=  ${comma_separated_list}  ,  ${item}
  END
  RETURN  ${comma_separated_list}
