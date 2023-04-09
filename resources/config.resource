*** Settings ***
Documentation  Project global definitions.

*** Variables ***
${URL}      http://127.0.0.1:5173
${BROWSER}  chrome

${API_HOST}  http://127.0.0.1:5000  # http://tst.bookstore-demo.com/
${API_USER}  bookstore_admin
${API_PASS}  admin123

${DB_NAME}      bookstoredb
${DB_USER}      root
${DB_PASS}      Coragem@123
${DB_HOST}      localhost
${DB_PORT}      3306

${KAFKA_SERVER} =   127.0.0.1:9092


${APPIUM_SERVER}              http://127.0.0.1:4723/wd/hub
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${ANDROID_APP}                ${CURDIR}/apps/app-demo.apk
${ANDROID_APP_PACKAGE}        io.appium.android.apis
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   %{ANDROID_PLATFORM_VERSION=13}
${ANDROID_DEVICE}             Nexus_6_API_33