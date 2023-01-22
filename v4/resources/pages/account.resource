*** Settings ***
Documentation  My Account Page Actions
Resource       ../page_objects/account_page_object.resource

*** Keywords ***
I should see My Orders
  Page Should Contain Link   ${MY_ORDERS_LINK}

I should see My Wish List
  Page Should Contain Link   ${WISH_LIST_LINK}
