*** Settings ***
Library   SeleniumLibrary
Resource  ../page_objects/home_page_object.resource

*** Keywords ***
I am on ${expected} web site
  Title Should Be  ${expected}

I search for a book by ${search_text}
  Input Text  ${BOOKS_SEARCH_BAR}  ${search_text} 
  Press Keys  ${BOOKS_SEARCH_BAR}  RETURN

I search for this out-of-stock book by ISBN
  Input Text  ${BOOKS_SEARCH_BAR}  ${OUT_OF_STOCK_BOOK}
  Press Keys  ${BOOKS_SEARCH_BAR}  RETURN

I search for this book by ISBN
  Input Text  ${BOOKS_SEARCH_BAR}  ${BOOK.isbn}
  Press Keys  ${BOOKS_SEARCH_BAR}  RETURN

I visit the book
  I search for this book by ISBN
  Wait Until Page Contains          ${BOOK.title}
  Push item to Stack                ${BOOK}
  