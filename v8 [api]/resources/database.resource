*** Settings ***
Documentation  Database conection and queries.
Library        DatabaseLibrary
Library        FakerLibrary
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
  Set Global Variable  ${blocked_user}   ${resultset}
  [Teardown]           Close database connection

I have a product out of stock
  Open database connection
  @{resultset} =  Query   SELECT isbn FROM books WHERE stock = 0;  
  Should Not Be Empty  item=@{resultset}  msg=None valid product finded in database.
  ${book_item} =   Set Variable    @{resultset}[0]
  Set Global Variable  ${isbn_of_book_out_of_estoque}  ${book_item}
  [Teardown]      Close database connection

I should see the inserted book in database
  [Arguments]  ${id}  ${isbn}
  Open database connection
  Check If Exists In Database  SELECT isbn FROM books WHERE id = '${id}' and isbn = '${isbn}';
  [Teardown]                    Close database connection

I should remove the book from database
  [Arguments]  ${id}
  Open database connection
  Execute SQL String            DELETE FROM books WHERE id = ${id};
  [Teardown]                    Close database connection

I should not see the removed book in the database 
  [Arguments]  ${id}
  Open database connection
  Check If Not Exists In Database  SELECT isbn FROM books WHERE id = '${id}';
  [Teardown]                    Close database connection

I insert book into database
  [Arguments]  ${book}
  Open database connection
  Execute SQL String  INSERT INTO books values ('${book.id}', '${book.isbn}', '${book.title}', '${book.author}', '${book.publisher}', '${book.price}')
  [Teardown]           Close database connection
