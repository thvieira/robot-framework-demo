*** Settings ***
Documentation  Database conection and queries.
Library        DatabaseLibrary
Resource       config.resource

*** Keywords ***
Open database connection
  Connect To Database  pymysql  ${DB_NAME}  ${DB_USER}  ${DB_PASS}  ${DB_HOST}  ${DB_PORT}

Close database connection
  Disconnect from database

I should see the inserted user active in to the database
  Open database connection
  Check If Exists In Database  SELECT email FROM users WHERE is_active = 1 AND email = '${FAKE_EMAIL}';
  [Teardown]                   Close database connection

I should delete the inserted user from database
  Open database connection
  Execute SQL String           DELETE FROM users WHERE email = '${FAKE_EMAIL}';
  [Teardown]                   Close database connection

I am a blocked user
  Open database connection
  ${resultset} =               Query                           SELECT email, senha FROM users WHERE is_active = 0;
  Set Test Variable            ${BLOCKED_USER}                 ${resultset}
  [Teardown]                   Close database connection

I have a book out of stock
  Open database connection
  @{resultset} =               Query                           SELECT isbn FROM books WHERE stock = 0;  
  Should Not Be Empty          item=@{resultset}               msg=None valid product finded in database.
  ${book_item} =               Set Variable                    @{resultset}[0]
  Set Test Variable            ${OUT_OF_STOCK_BOOK}            ${book_item}
  [Teardown]                   Close database connection