*** Settings ***
Documentation  Bookstore Demo
          ...  Books Deletion API Contract Testing
Library        RequestsLibrary
Default Tags   api  books  deletion

Suite Setup  Create Session  bookstore-demo  http://tst.bookstore-demo.com/

*** Test Cases ***
Scenario: Remove books
  [Tags]  B014
  No Operation  

Scenario: Remove non-existent book
  [Tags]  B013
  No Operation  
