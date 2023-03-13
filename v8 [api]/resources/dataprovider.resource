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
