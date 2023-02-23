*** Settings ***
Library         SeleniumLibrary
Resource        ../resources/config.resource
Resource        ../resources/pages/home.resource
Resource        ../resources/pages/menu.resource

Test Setup      Open Browser  ${URL}  ${BROWSER} 
Test Teardown   Close Browser

*** Test Cases ***
Scenario: Blocked user
  Givan I am a blocked user
    And I am on Bookstore Demo web site
    And I go to log in or sign in page
   When I fill "" in the login username text field
    And I fill "" in the login password text field
    And I click Entrar button
   Then I should see the "${message}" message
