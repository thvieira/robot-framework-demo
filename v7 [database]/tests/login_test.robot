*** Settings ***
Library   DatabaseLibrary
Resource  ../resources/database.resource

Test Setup     Open database connection
Test Teardown  Close database connection

*** Test Cases ***
Scenario: Blocked user
  No Operation  
