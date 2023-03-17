*** Settings ***
Documentation  Bookstore Demo: Kafka Mail queue.
Library        KafkaLibrary
Library        RequestsLibrary
Library        JSONLibrary
Library        FakerLibrary
Library        ImapLibrary2
Library        String
Library        Collections

Resource       ../../resources/config.resource

Test Tags  kafka
Suite Teardown     Run Keyword And Ignore Error    Close

*** Variable ***
${KAFKA_SERVER}=   127.0.0.1:9092
${CLIENT_ID}=      Robot
${GROUP_ID}=       Robot
${TOPIC}=          mailQueue
#${TO} =           test_client@bookstoredemo.com
${TO} =            contato@editoracoragem.com.br

*** Test Cases ***
Scenario: Post message into the queue
  [Tags]  post

  # Gerar dados randômicos
  ${NAME} =  FakerLibrary.Name
  ${CODE} =  FakerLibrary.Uuid4

  # Invocar o serviço que posta uma mensagem na fila
  &{msg} =             Create Dictionary  name=${NAME}              recipientEmailAddress=${TO}      
                                     ...  category=passwordRecover  passwordRecoverCode=${CODE}     
  ${response} =        POST               ${API_HOST}/mail-queue    json=&{msg}                     expected_status=202

  # Conectar ao Kafka 
  Connect To Kafka     bootstrap_servers=${KAFKA_SERVER}    auto_offset_reset=latest    client_id=Robot       group_id=${GROUP_ID}

  # Se cadastrar como consumidor para escutar os eventos do tópico
  Connect Consumer     bootstrap_servers=${KAFKA_SERVER}    client_id=Consumer          group_id=${GROUP_ID}  enable_auto_commit=${TRUE}
  Subscribe Topic      ${TOPIC}

  # Ler a última mensagem da fila
  ${messages}=        Poll  max_records=${1}  timeout_ms=${500}

  # Acessar o conteúdo da mensagem e converter de bytes para JSON
  ${message_as_string} =   Decode Bytes To String  ${messages[0].value}  utf-8
  ${message_as_json} =     Convert String To Json  ${str}

  # Validando os campos esperados
  Should Not Be Empty  ${message_as_json}[id]
  Should Not Be Empty  ${message_as_json}[datetime]

  Should Be Equal      ${NAME}   ${message_as_json}[name]
  Should Be Equal      ${CODE}   ${message_as_json}[passwordRecoverCode]
  Should Be Equal      ${TO}     ${message_as_json}[recipientEmailAddress]
  
Scenario: Read from queue and send mail
  [Tags]  read

  # Gerar dados randômicos
  ${NAME} =  FakerLibrary.Name
  ${CODE} =  FakerLibrary.Uuid4
  ${ID} =    FakerLibrary.RandomNumber  digits=4
  ${DATETIME}  FakerLibrary.Date

  # Invocar o serviço que posta uma mensagem na fila
  &{msg} =             Create Dictionary  name=${NAME}              recipientEmailAddress=${TO}      
                                     ...  category=passwordRecover  passwordRecoverCode=${CODE}
                                     ...  id=${ID}                  datetime=${DATETIME}
  # Conectar ao Kafka
  Connect To Kafka    bootstrap_servers=${KAFKA_SERVER}    auto_offset_reset=latest    client_id=Robot    group_id=${GROUP_ID}

  # Se cadastrar como produtor para postar mensagens no tópico
  Connect Producer    bootstrap_servers=${KAFKA_SERVER}    client_id=Producer

  # Enviando a mensagem para o tópico
  ${message_as_string} =  Convert Json To String    ${msg}
  Send Text Message    ${TOPIC}    ${message_as_string}
  Flush

  # Validando o recebimento do e-mail
    Open Mailbox    host=imap.gmail.com    user=contato@editoracoragem.com.br    password=mascada123
    ${LATEST} =    Wait For Email    sender=contato@editoracoragem.com.br    timeout=300
    ${HTML} =    Get Email Body          ${LATEST}
    ${HTML} =    Open Link From Email    ${LATEST} 
    Should Contain    ${HTML}    Recuperar senha para
    Close Mailbox

*** Keyword ***
Send Text Message
    [Arguments]    ${topic}    ${message_text}
    ${bytes}    Encode String To Bytes    ${message_text}    UTF-8
    Send    ${topic}    value=${bytes}


## Start the ZooKeeper service
#$ bin/zookeeper-server-start.sh config/zookeeper.properties
## Start the Kafka broker service
#$ bin/kafka-server-start.sh config/server.properties
## Create a topic
#bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092
## Producer
#bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092
## Consumer
#bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092