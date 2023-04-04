*** Settings ***
Documentation  Simple example using AppiumLibrary
Library  AppiumLibrary
Resource  ../../resources/config.resource

Test Teardown  Close Application

*** Variables ***
${SEARCH_TEXT_FIELD}  txt_query_prefill
${SEARCH_BUTTON}      btn_start_search
${RESULTS_LIST}       android:id/search_src_text

*** Test Cases ***
Scenario: Search bar
  Given I open the app
   When I search for Martín Fierro
   Then I should see Martín Fierro in results screen

*** Keywords ***
I open the app
  Open Application  ${APPIUM_SERVER}               automationName=${ANDROID_AUTOMATION_NAME}
               ...  app=${ANDROID_APP}             platformVersion=${ANDROID_PLATFORM_VERSION}
               ...  deviceName=${ANDROID_DEVICE}   platformName=${ANDROID_PLATFORM_NAME}
               ...  appActivity=.app.SearchInvoke  appPackage=${ANDROID_APP_PACKAGE}  

I search for ${query}
  Input Text     ${SEARCH_TEXT_FIELD}  ${query}
  Click Element  ${SEARCH_BUTTON}

I should see ${expected} in results screen
  Wait Until Page Contains Element  ${RESULTS_LIST}
  Element Text Should Be            ${RESULTS_LIST}  ${expected}