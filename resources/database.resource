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

I get an out of stock book
  TRY
    Open database connection
    @{resultset} =     Query                 SELECT id, isbn FROM books WHERE stock = 0 LIMIT 1;   returnAsDict=True
    &{book_item} =     Set Variable          ${resultset}[0]
    Set Test Variable  ${OUT_OF_STOCK_BOOK}  ${book_item}
  EXCEPT
    Log   None valid product found in database.  level=WARN
    Skip  Insufficient data for testing.
  FINALLY
    Close database connection
  END

I have an empty shopping cart
  Set Test Variable    ${CART_ID}    XPTO

I should see the inserted fake book in database
  Open database connection
  Check If Exists In Database   SELECT isbn FROM books WHERE id = '${INSERTED_ID}' and isbn = '${FAKE_BOOK.isbn}';
  [Teardown]                    Close database connection

I should see the inserted book in database
  Open database connection
  Check If Exists In Database   SELECT isbn FROM books WHERE id = '${INSERTED_ID}';
  [Teardown]                    Close database connection

I should remove the fake book from database
  Open database connection
  Execute SQL String            DELETE FROM books WHERE id = '${FAKE_BOOK.id}';
  [Teardown]                    Close database connection

I should remove the inserted book from database
  Open database connection
  Execute SQL String            DELETE FROM books WHERE id = '${INSERTED_ID}';
  [Teardown]                    Close database connection

I should not see the fake book in the database 
  Open database connection
  Check If Not Exists In Database  SELECT isbn FROM books WHERE id = '${FAKE_BOOK.id}';
  [Teardown]                    Close database connection

I should see the ${field} of the fake book with value ${expected_value} in database
  Open database connection
  Check If Not Exists In Database  SELECT id FROM books WHERE id = '${FAKE_BOOK.id}' and ${field} = ${expected_value};
  [Teardown]                    Close database connection

I insert the fake book into database
  I insert &{FAKE_BOOK} into database

I insert ${book} into database
  Open database connection
  Execute SQL String            INSERT INTO books VALUES ('${book.id}', '${book.isbn}', '${book.title}', '${book.author}', '${book.publisher}', ${book.price}, 1);  
                 ...            sansTran=True
  [Teardown]                    Close database connection

I insert all fake books into database
  FOR  ${book}  IN  @{FAKE_BOOK_LIST}
    I insert ${book} into database
  END

I should not see the fake book list in the database 
  FOR  ${book}  IN  @{FAKE_BOOK_LIST}
    I should not see the book ${book.id} in the database
  END
