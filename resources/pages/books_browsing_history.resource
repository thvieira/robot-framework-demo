*** Settings ***
Library   SeleniumLibrary
Resource  ../page_objects/books_browsing_history_page_object.resource

*** Keywords ***
I should see the books browsing history
  Wait Until Page Contains          Resgate o livro que você estava buscando

I should see the last book I've visited
  ${visited_book} =                 Pop item from Stack
  Page Should Contain               ${visited_book.title}
  Element Should Contain            ${FIRST_ITEM}     ${visited_book.title}

I should see the penultimate book I've visited
  ${visited_book} =                 Pop item from Stack
  Page Should Contain               ${visited_book.title}
  Element Should Contain            ${SECOND_ITEM}    ${visited_book.title}

I should see the anti-penultimate book I've visited
  ${visited_book} =                 Pop item from Stack
  Page Should Contain               ${visited_book.title}
  Element Should Contain            ${THIRD_ITEM}     ${visited_book.title}
