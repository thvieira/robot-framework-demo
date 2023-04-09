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

*** Test Cases ***
Scenario: Post message into the queue
  [Tags]  post
  Given I get a fake name
    And I get a fake code
    And I am authenticated
   When I ask for password reset
    And I conect to Kafka as Consumer
    And I subscribe mailQueue topic 
   Then I should see response status code 202
    And I should see a new message on the queue
    And I should see the id field
    And I should see the datetime field
    And I should see the name field equals to fake name
    And I should see the passwordRecoverCode field equals to fake ode
    And I should see the recipientEmailAddress field equals to ${TO}
  
Scenario: Read from queue and send mail
  [Tags]  read
  Given I get a fake name
    And I get a fake code
    And I get a fake id
    And I get a fake datetime
    And I get a dictionary with password recover data
    And I conect to Kafka as Producer
    And I send a message to mailQueue topic with password recover data
   When I open the mail box
    And I wait for e-mail message
    And I should see the fake code in e-mail body
    [Teardown]  I close the mail box

*** Keywords ***
I get a dictionary with password recover data
  &{data} =  Create Dictionary  id=${FAKE_ID}              category=passwordRecover
                           ...  name=${FAKE_NAME}          recipientEmailAddress=${TO}  
                           ...  datetime=${FAKE_DATETIME}  passwordRecoverCode=${FAKE_CODE}
  Set Test Variable             ${PASSWORD_RECOVER_DATA}   &{data}
