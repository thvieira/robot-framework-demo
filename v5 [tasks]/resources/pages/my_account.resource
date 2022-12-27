*** Settings ***
Resource  ../page_objects/account_page_object.resource

*** Keywords ***
devo visualizar a opção de acessar meus pedidos
  Page Should Contain Link   ${MY_ORDERS_LINK}

devo visualizar a opção de acessar minha lista de desejos
  Page Should Contain Link   ${WISH_LIST_LINK}
