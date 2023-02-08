*** Settings ***
Documentation  Database conection and queries.
Library        DatabaseLibrary
Resource       config.resource

*** Keywords ***
Open database connection
  Connect To Database  pymysql  ${DB_NAME}  ${DB_USER}  ${DB_PASS}  ${DB_HOST}  ${DB_PORT}

Close database connection
  Disconnect from database

I should see the user "${user_email}" active in to the database
  Open database connection
  Check If Exists In Database   SELECT email FROM users WHERE is_active = 1 AND email = '${user_email}';
  [Teardown]                    Close database connection

I should delete the user "${user_email}" from database
  Open database connection
  Execute SQL String            DELETE FROM users WHERE email = '${user_email}';
  [Teardown]                    Close database connection

I am a blocked user
  Open database connection
  ${resultset} =       Query  SELECT email, senha FROM users WHERE is_active = 0;
  Set Global Variable  ${clocked_user}   ${resultset}
  [Teardown]           Close database connection

I have a product out of stock
  Open database connection
  @{resultset} =  Query   SELECT isbn FROM books WHERE stock = 0;  
  ${book_item} =   Set Variable    @{resultset}[0]
  Set Global Variable  ${isbn_of_book_out_of_estoque}  ${book_item}
  [Teardown]      Close database connection