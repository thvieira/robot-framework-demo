*** Settings ***
Library        ImapLibrary2

*** Test Cases ***
I open the mail box
    Open Mailbox    host=imap.gmail.com     user=contato@editoracoragem.com.br    password=mascada123

I wait for e-mail message
    ${LATEST} =     Wait For Email          sender=contato@editoracoragem.com.br  subject=Recuperar senha para ${NAME}   poll_frequency=5  timeout=30

I should see "${expected_message}" in e-mail body
    ${HTML} =       Get Email Body          ${LATEST}
    Should Contain  ${HTML}    ${expected_message}