*** Settings ***
Library        ImapLibrary2

*** Variables ***
${POLL_FREQUENCY}  5
${TIMEOUT}         30

*** Keywords ***
I open the mail box
  Open Mailbox  host=${MAILBOX_HOST}  user=${MAILBOX_USER}  password=${MAILBOX_PASS}

I wait for e-mail message
  ${subject} =   Set Variable    Recuperar senha para ${FAKE_NAME}
  ${latest} =    Wait For Email  sender=${MAILBOX_USER}  subject=${subject}   poll_frequency=${POLL_FREQUENCY}  timeout=${TIMEOUT}
  Set Test Variable  ${LATEST_MAIL}        ${latest}

I should see "${expected_message}" in e-mail body
  ${html} =       Get Email Body  ${LATEST_MAIL}
  Should Contain  ${html}         ${expected_message}

I close the mail box
  Run Keyword And Ignore Error  Close Mailbox