*** Settings ***
Documentation  Bookstore Demo
          ...  Stock E2E API Testing
Library        RequestsLibrary
Default Tags   api  stock

Suite Setup  Create Session  bookstore-demo  http://tst.bookstore-demo.com/

*** Test Cases ***
Scenario: Product out of stock
  Given I have a product out of stock
  