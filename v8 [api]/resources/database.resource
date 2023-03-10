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

I get an out of stock book
  Open database connection
  @{resultset} =  Query   SELECT isbn FROM books WHERE stock = 0;  
  Should Not Be Empty  item=@{resultset}  msg=None valid product found in database.
  ${book_item} =   Set Variable    @{resultset}[0]
  Set Global Variable  ${OUT_OF_STOCK_BOOK.isbn}  ${book_item}
  [Teardown]      Close database connection

I have an empty shopping cart
  Set Global Variable    ${CART_ID}    XPTO

I should see the inserted book in database
  [Arguments]  ${id}  ${isbn}
  Open database connection
  Check If Exists In Database  SELECT isbn FROM books WHERE id = '${id}' and isbn = '${isbn}';
  [Teardown]                    Close database connection

I should remove the book from database
  [Arguments]  ${id}
  Open database connection
  Execute SQL String            DELETE FROM books WHERE id = '${id}';
  [Teardown]                    Close database connection

I should not see the book ${id} in the database 
  Open database connection
  Check If Not Exists In Database  SELECT isbn FROM books WHERE id = '${id}';
  [Teardown]                    Close database connection

I should see the ${field} of book ID ${id} with value ${expected_value} in database
  Open database connection
  Check If Not Exists In Database  SELECT id FROM books WHERE id = '${id}' and ${field} = ${expected_value};
  [Teardown]                    Close database connection

I insert ${book} into database
  Open database connection
  Execute SQL String            INSERT INTO books VALUES ('${book.id}', '${book.isbn}', '${book.title}', '${book.author}', '${book.publisher}', ${book.price}, 1);
  [Teardown]                    Close database connection

I insert all ${books_list} into database
  FOR  ${book}  IN  @{books_list}
    I insert ${book} into database
  END

I should not see the book${s} from ${books_id} in the database 
  FOR  ${book_id}  IN  @{books_id}
    I should not see the book ${book_id} in the database
  END
