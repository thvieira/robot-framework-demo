*** Settings ***
Library     SeleniumLibrary
Resource    ../page_objects/menu_page_object.resource

*** Keywords ***
I go to log in or sign in page
  Click Link     ${MY_ACCOUNT_BUTTON}