*** Settings ***
Documentation  Bookstore Demo
          ...  Stock E2E API Testing
Library        RequestsLibrary
Default Tags   api  stock

*** Test Cases ***
Scenario: Product out of stock
  No Operation    
