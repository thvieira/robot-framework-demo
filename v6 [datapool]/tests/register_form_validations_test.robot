*** Settings ***
Documentation   Como cliente da loja virtual, devo ser induzido a
           ...  criar uma senha forte ao me cadastrar no sistema.
Library         SeleniumLibrary
Resource        ../resources/config.resource
Resource        ../resources/pages/home.resource
Resource        ../resources/pages/menu.resource
Resource        ../resources/pages/register.resource

Test Setup      Open Browser   ${URL}  ${BROWSER}  
Test Teardown   Close Browser  
Test Template   Fill register form with data

*** Test Cases ***                     NAME         E-MAIL         PASS    CONFIRM PASS  EXPECTED MESSAGE
Invalid e-mail failure                 Lorem ipsum  lipsum         foo123  foo123        Fail: invalid e-mail.
Name should not be empty               ${EMPTY}     eu@lipsum.com  foo123  foo123        Fail: name should not be empty.
Password should have 5 or more digits  Lorem ipsum  eu@lipsum.com  f123    f123          Fail: Password should have 5 or more digits.
Password should contain letters        Lorem ipsum  eu@lipsum.com  12345   12345         Fail: Password should contain letters.
Password should contain numbers        Lorem ipsum  eu@lipsum.com  foooo   foooo         Fail: Password should contain numbers.
Confirm password failure               Lorem ipsum  eu@lipsum.com  foo123  barr123       Fail: the confirm password doesn't match.

*** Keywords ***
Fill register form with data
  [Arguments]  ${name}  ${mail}  ${pass}  
          ...  ${confirm_pass}  ${expected_message}  

  Given I am on Bookstore Demo web site
    And I go to log in or sign in page
   When I fill "${name}" in name text field
    And I fill "${mail}" in e-mail text field
    And I fill "${pass}" in pass text field
    And I fill "${confirm_pass}" in confirm pass text field
    And I submit register form 
   Then I should see the "${expected_message}" message