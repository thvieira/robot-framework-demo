*** Settings ***
Documentation  Product Page Actions

*** Keywords ***
I should see the "${message}" message
  Wait Until Page Contains   ${message}

I should see the Add to Cart button disabled
  No Operation  

I should see the Buy Now button disabled
  No Operation  