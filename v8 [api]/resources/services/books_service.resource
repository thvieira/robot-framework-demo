*** Settings ***
Library  Collections
Resource  ../database.resource
Resource  ../dataprovider.resource

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
  &{header} =         Create Dictionary  x-session=${token}  Content-Type=application/json
  ${response} =       POST  ${API_HOST}/books  json=${body}  headers=&{header}
  Set Global Variable  ${RESPONSE}  ${response}

I should see the inserted ID 
  Set Global Variable  ${INSERTED_ID}  ${RESPONSE.json()}[id]
  Should Not Be Empty  ${INSERTED_ID}

I delete book${s} in ${books_id}
  ${formated_param_list} =  Get From List  ${books_id}  0 
  Remove From List  ${books_id}   0

  FOR  ${book_id}  IN  @{books_id}
    ${formated_param_list} =  Catenate  SEPARATOR=  ${formated_param_list}  ,  ${book_id}
  END

  &{header} =    Create Dictionary  x-session=${token}  Content-Type=application/json
  ${response} =  DELETE  ${API_HOST}/books  params=id=${formated_param_list}  headers=&{header}
  Set Global Variable  ${RESPONSE}  ${response}

I change the ${field} of the book with ID ${id} to ${new_value}
  &{payload} =   Create Dictionary    ${field}=${new_value}
  &{header} =    Create Dictionary  x-session=${token}  Content-Type=application/json
  ${response} =  PATCH  ${API_HOST}/books/${id}   headers=&{header}  json=&{payload}
  Set Global Variable  ${RESPONSE}  ${response}

I search for ${something} in books
  ${response} =   GET  ${API_HOST}/books  params=search=${something}
  Set Global Variable  ${BOOK_ID}        ${response.json()}