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

I have ${qtd} book${s} from database
  @{inserted_id_list} =  Create List  
  FOR  ${index}  IN RANGE  ${qtd}
    &{fake_book} =  I get a fake book
    I insert book into database  book=&{fake_book}
    Append To List  ${inserted_id_list}  ${fake_book.id}
  END
  Set Global Variable  @{BOOKS_ID_LIST}   @{inserted_id_list}

I delete book${s} in ${books_id}
  ${formated_param_list} =  Get From List  ${books_id}  0 
  Remove From List  ${books_id}   0

  FOR  ${book_id}  IN  @{books_id}
    ${formated_param_list} =  Catenate  SEPARATOR=  ${formated_param_list}  ,  ${book_id}
  END

  ${response} =  DELETE  ${API_HOST}/books  params=id=${formated_param_list}
  Set Global Variable  ${RESPONSE}  ${response}

I should not see the book${s} from ${books_id} in the database 
  FOR  ${book_id}  IN  @{books_id}
    I should not see the removed book in the database   id=${book_id}
  END
