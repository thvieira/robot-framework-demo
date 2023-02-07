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
