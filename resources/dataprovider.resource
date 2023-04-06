*** Settings ***
Library              FakerLibrary

*** Keywords ***
I generated a fake e-mail
  ${fake_email} =    FakerLibrary.Email
  Set Test Variable  ${fake_email} 