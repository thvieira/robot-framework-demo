*** Settings ***
Library        ImapLibrary2

*** Variables ***
${POLL_FREQUENCY}  5
${TIMEOUT}         30

*** Keywords ***
I open the mail box
  [Arguments]   ${host}       ${user}       ${pass}
  Open Mailbox  host=${host}  user=${user}  password=${pass}

I wait for e-mail message
  [Arguments]         ${sender}       ${subject}
  ${latest} =    Wait For Email  sender=${sender}  subject=${subject}   poll_frequency=${POLL_FREQUENCY}  timeout=${TIMEOUT}
  Set Global Variable  ${LATEST_MAIL}        ${latest}

I should see "${expected_message}" in e-mail body
  ${html} =       Get Email Body  ${LATEST_MAIL}
  Should Contain  ${html}         ${expected_message}

I close the mail box
  Run Keyword And Ignore Error  Close Mailbox