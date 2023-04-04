*** Settings ***
Documentation  Bookstore Demo: Kafka Mail queue.

Resource       ../../resources/config.resource
Resource       ../../resources/email.resource
Resource       ../../resources/kafka.resource
Resource       ../../resources/dataprovider.resource
Resource       ../../resources/services/auth_service.resource
Resource       ../../resources/services/password_service.resource

Test Tags       kafka
Suite Teardown   Run Keyword And Ignore Error    Close

*** Variable ***
${TO}            contato@editoracoragem.com.br

${MAILBOX_HOST}  imap.gmail.com
${MAILBOX_USER}  contato@editoracoragem.com.br
${MAILBOX_PASS}  mascada123

*** Test Cases ***
Scenario: Post message into the queue
  [Tags]  post
  Given I get a random name
    And I get a random code
    And I am authenticated
   When I ask for password reset  ${RANDOM_NAME}  ${TO}  ${RANDOM_CODE}
    And I conect to Kafka as Consumer
    And I subscribe mailQueue topic 
   Then I should see response status code 202
    And I should see a new message on the queue
    And I should see the id field
    And I should see the datetime field
    And I should see the name field equals to ${RANDOM_NAME}
    And I should see the passwordRecoverCode field equals to ${RANDOM_CODE}
    And I should see the recipientEmailAddress field equals to ${TO}
  
Scenario: Read from queue and send mail
  [Tags]  read
  Given I get a random name
    And I get a random code
    And I get a random id
    And I get a random datetime
    And I get a dictionary with password recover data
    And I conect to Kafka as Producer
    And I send a message to mailQueue topic with content ${PASSWORD_RECOVER_DATA}
   When I open the mail box        host=${MAILBOX_HOST}    user=${MAILBOX_USER}    pass=${MAILBOX_PASS}
    And I wait for e-mail message  sender=${MAILBOX_USER}  subject=Recuperar senha para ${RANDOM_NAME}
   Then I should see "Recuperar senha para ${RANDOM_NAME}" in e-mail body
    And I should see "Anote teu codigo <strong>${RANDOM_CODE}</strong>" in e-mail body
    [Teardown]  I close the mail box

*** Keywords ***
I get a dictionary with password recover data
  &{data} =  Create Dictionary  id=${RANDOM_ID}              category=passwordRecover
                           ...  name=${RANDOM_NAME}          recipientEmailAddress=${TO}  
                           ...  datetime=${RANDOM_DATETIME}  passwordRecoverCode=${RANDOM_CODE}
  Set Global Variable           ${PASSWORD_RECOVER_DATA}     &{data}
