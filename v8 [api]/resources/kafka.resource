*** Settings ***
Documentation  Bookstore Demo: Kafka resources.
Library        KafkaLibrary
Library        String

*** Variable ***
${ENCODING} =  UTF-8
${GROUP_ID} =  Robot

*** Keywords ***
I conect to Kafka as Consumer
  Connect To Kafka     bootstrap_servers=${KAFKA_SERVER}    auto_offset_reset=latest    client_id=RobotConsumer     group_id=${GROUP_ID}
  Connect Consumer     bootstrap_servers=${KAFKA_SERVER}    client_id=RobotConsumer     group_id=${GROUP_ID}  enable_auto_commit=${TRUE}

I conect to Kafka as Producer
  Connect To Kafka     bootstrap_servers=${KAFKA_SERVER}    auto_offset_reset=latest    client_id=RobotConsumer     group_id=${GROUP_ID}
  Connect Producer     bootstrap_servers=${KAFKA_SERVER}    client_id=RobotProducer     group_id=${GROUP_ID}

I subscribe ${topic} topic 
  Subscribe Topic   ${topic}

I should see a new message on the queue
  ${messages} =            Poll  max_records=${1}  timeout_ms=${500}
  ${message_as_string} =   Decode Bytes To String  ${messages[0].value}  ${ENCODING}
  ${message_as_json} =     Convert String To Json  ${message_as_string}
  Set Global Variable      ${KAFKA_LAST_MESSAGE}   ${message_as_json}
  
I should see the ${field_name} field
  Should Not Be Empty  ${KAFKA_LAST_MESSAGE}[id]

I should see the ${field_name} field equals to ${expected_value}
  Should Be Equal      ${message_as_json}[${field_name}]  ${expected_value}

I send a message to ${topic} topic 
  [Arguments]             ${message_content}
  ${message_as_string} =  Convert Json To String    ${message_content}
  ${bytes} =              Encode String To Bytes    ${message_text}    ${ENCODING}
  Send                    ${topic}            value=${bytes}
  Flush
