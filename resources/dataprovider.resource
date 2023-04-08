*** Settings ***
Library         FakerLibrary

*** Keywords ***
I get a fake e-mail
  ${fake_email} =  FakerLibrary.Email
  Set Global Variable   ${FAKE_EMAIL}   ${fake_email} 

I get an fake ISBN
  ${fake_isbn} =       FakerLibrary.Isbn13
  Set Global Variable  ${FAKE_ISBN}   ${fake_isbn}

I get a fake book
  ${id} =         FakerLibrary.RandomInt
  ${isbn} =       FakerLibrary.Isbn13
  ${title} =      FakerLibrary.Text  max_nb_chars=32
  ${author} =     FakerLibrary.Name
  ${publisher} =  FakerLibrary.Company
  ${price} =      FakerLibrary.RandomNumber  digits=2

  &{fake_book} =  Create Dictionary  id=${id}  isbn=${isbn}  
                                ...  title=${title}  author=${author}  
                                ...  publisher=${publisher}  price=${price}
  
  Set Global Variable  &{FAKE_BOOK}   &{fake_book}
  RETURN               &{fake_book}

I get ${qtd} fake books
  @{fake_book_list} =  Create List  
  FOR  ${index}  IN RANGE  ${qtd}
    &{fake_book} =  I get a fake book
    Append To List  @{fake_book_list}   ${fake_book}
  END
  Set Global Variable  @{FAKE_BOOK_LIST}   @{fake_book_list}

I get a random name
  ${name} =            FakerLibrary.Name
  Set Global Variable  ${RANDOM_NAME}  ${name}

I get a random code
  ${code} =            FakerLibrary.Uuid4
  Set Global Variable  ${RANDOM_CODE}   ${code}

I get a random id
  ${id} =        FakerLibrary.RandomNumber  digits=4
  Set Global Variable  ${RANDOM_ID}  ${id}

I get a random datetime
  ${datetime} =  FakerLibrary.Date
  Set Global Variable  ${RANDOM_DATETIME}  ${datetime}
