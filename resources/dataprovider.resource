*** Settings ***
Library         FakerLibrary

*** Keywords ***
I generated a fake e-mail
  ${fake_email} =  FakerLibrary.Email
  Set Test Variable  ${FAKE_EMAIL}  ${fake_email}

I get an fake ISBN
  ${fake_isbn} =     FakerLibrary.Isbn13
  Set Test Variable  ${FAKE_ISBN}   ${fake_isbn}

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
  
  Set Test Variable  &{FAKE_BOOK}   &{fake_book}
  RETURN             &{fake_book}

I get ${qtd} fake books
  @{fake_book_list} =  Create List  
  FOR  ${index}  IN RANGE  ${qtd}
    &{fake_book} =   I get a fake book
    Append To List   @{fake_book_list}   ${fake_book}
  END
  Set Test Variable  @{FAKE_BOOK_LIST}   @{fake_book_list}

I get a random name
  ${name} =          FakerLibrary.Name
  Set Test Variable  ${RANDOM_NAME}      ${name}

I get a random code
  ${code} =          FakerLibrary.Uuid4
  Set Test Variable  ${RANDOM_CODE}      ${code}

I get a random id
  ${id} =            FakerLibrary.RandomNumber  digits=4
  Set Test Variable  ${RANDOM_ID}        ${id}

I get a random datetime
  ${datetime} =      FakerLibrary.Date
  Set Test Variable  ${RANDOM_DATETIME}  ${datetime}
