*** Settings ***
Documentation

Library  SeleniumLibrary
Library         ../../resources/libraries/StackLibrary.py 

Resource        ../../resources/config.resource
Resource        ../../resources/database.resource
Resource        ../../resources/pages/home.resource
Resource        ../../resources/pages/menu.resource

Test Tags       stack
Test Setup      Open Browser  ${URL}  ${BROWSER} 
Test Teardown   Close Browser

*** Test Cases ***
Scenario: Last visited books
  Given I am on Bookstore Demo web site
    And I get a book from database
   When I visit the book
    And I return to the home page
    And I get another book from database
    And I visit the book
    And I return to the home page
    And I get another book from database
    And I visit the book
    And I return to the home page
   Then I should see the historic session
    And I should see the last book I've visited
    And I should see the penultimate book I've visited
    And I should see the anti-penultimate book I've visited

*** Keywords ***
I visit the book
  I search for this book by ISBN
  Wait Until Page Contains          ${BOOK.title}
  Push item to Stack                ${BOOK.title}
  
I return to the home page
  Wait Until Page Contains Element  link=Início
  Click Link  Início

I should see the historic session
  Page Should Contain               Resgate o livro que você estava buscando

I should see the last book I've visited
  ${visited_book} =                 Pop item from Stack
  Page Should Contain               ${visited_book}
  Element Should Contain            id=visited-area    ${visited_book}

I should see the penultimate book I've visited
  ${visited_book} =                 Pop item from Stack
  Page Should Contain               ${visited_book}
  Element Should Contain            id=visited-area    ${visited_book}

I should see the anti-penultimate book I've visited
  ${visited_book} =                 Pop item from Stack
  Page Should Contain               ${visited_book}
  Element Should Contain            id=visited-area    ${visited_book}
