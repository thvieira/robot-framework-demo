*** Settings ***
Library     SeleniumLibrary
Resource    ../page_objects/home_page.resource

*** Keywords ***
I am on ${expected} web site
  Title Should Be  ${expected}

I search for a book by ${search_text}
  Input Text  ${BOOKS_SEARCH_BAR}  ${search_text} 
  Press Keys  ${BOOKS_SEARCH_BAR}  RETURN
