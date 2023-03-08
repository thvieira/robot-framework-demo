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
  
  RETURN          &{fake_book}
  