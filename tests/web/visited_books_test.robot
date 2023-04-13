*** Settings ***
Documentation

Library         SeleniumLibrary
Library         ../../resources/libraries/StackLibrary.py 

Resource        ../../resources/config.resource
Resource        ../../resources/database.resource
Resource        ../../resources/pages/home.resource
Resource        ../../resources/pages/menu.resource
Resource        ../../resources/pages/books_browsing_history.resource

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
   Then I should see the books browsing history
    And I should see the last book I've visited
    And I should see the penultimate book I've visited
    And I should see the anti-penultimate book I've visited
