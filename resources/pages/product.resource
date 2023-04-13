*** Settings ***
Library   SeleniumLibrary
Resource  ../page_objects/product_page_object.resource

*** Keywords ***
I should see the "${message}" message
  Wait Until Page Contains   ${message}

I should see the Add to Cart button disabled
  Element Should Be Disabled  ${ADD_TO_CART_BUTTON}

I should see the Buy Now button disabled
  Element Should Be Disabled   ${BUY_NOW_BUTTON}
