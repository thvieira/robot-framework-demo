*** Settings ***
Library   DatabaseLibrary
Resource  ../resources/database.resource

Test Setup     Open database connection
Test Teardown  Close database connection

*** Test Cases ***
Testing database
  @{queryResults} =  Query   select * from mail_list
  Log Many           @{queryResults}
