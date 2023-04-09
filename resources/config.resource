*** Settings ***
Documentation  Project global definitions.

*** Variables ***
${URL}           http://localhost:5173
${BROWSER}       firefox

${API_HOST}      http://localhost:5000
${API_USER}      bookstore_admin
${API_PASS}      admin123

${DB_NAME}       bookstoredb
${DB_USER}       root
${DB_PASS}       Coragem@123
${DB_HOST}       localhost
${DB_PORT}       3306

${KAFKA_SERVER}  127.0.0.1:9092

${MAILBOX_HOST}  imap.gmail.com
${MAILBOX_USER}  test_client_bookstore_demo@gmail.com
${MAILBOX_PASS}  SenhaDaCaixaDeEmails

${APPIUM_SERVER}              http://127.0.0.1:4723/wd/hub
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${ANDROID_APP}                ${CURDIR}/apps/app-demo.apk
${ANDROID_APP_PACKAGE}        io.appium.android.apis
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   %{ANDROID_PLATFORM_VERSION=13}
${ANDROID_DEVICE}             Nexus_6_API_33