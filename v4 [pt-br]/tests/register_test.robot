Language: PT-br

*** Configurações ***
Documentação    Como cliente da loja virtual, desejo criar um 
          ...   cadastro no sistema para poder visualizar meus 
          ...   pedidos e lista de desejos.
Biblioteca      SeleniumLibrary
Recurso        ../resources/config.resource
Recurso        ../resources/page_objects/menu_page.resource
Recurso        ../resources/page_objects/account_page.resource
Recurso        ../resources/page_objects/register_page.resource

Inicialização de Teste      Open Browser   ${URL}  ${BROWSER}  
Finalização de Teste        Close Browser  

*** Casos de Teste ***
Cenário: Cadastro com sucesso de Pessoa Física
    Dado que estou na página da loja virtual
       E acessei a área de cadastro
  Quando preencho o formulário com meus dados
       E submeto os dados do formulário
   Então devo receber uma mensagem de sucesso
       E devo visualizar a opção de acessar meus pedidos
       E devo visualizar a opção de acessar minha lista de desejos
    
Cenário: Cadastro com sucesso de Pessoa Jurídica
  Given Click Link     ${MY_ACCOUNT_BUTTON}
   When Input Text      ${NAME_TEXT_FIELD}           Lorem ipsum LTDA
    And Input Text      ${MAIL_TEXT_FIELD}           contact@ipsum.com
    And Input Password  ${REGISTER_PASS_TEXT_FIELD}  12345
    And Input Password  ${REGISTER_PASS_TEXT_FIELD}  12345
    And Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Jurídica
    And Submit Form                ${REGISTER_BUTTON}
   Then Wait Until Page Contains   Lorem ipsum LTDA, teu cadastro foi realizado com sucesso!
    And Page Should Contain Link   ${WISH_LIST_LINK}
    
*** Palavras-Chave ***
que estou na página da loja virtual
  Title Should Be  Bookstore Demo

acessei a área de cadastro
  Click Link     ${MY_ACCOUNT_BUTTON}

preencho o formulário com meus dados
  Input Text      ${NAME_TEXT_FIELD}           Lorem ipsum
  Input Text      ${MAIL_TEXT_FIELD}           lorem@ipsum.com
  Input Password  ${PASS_TEXT_FIELD}           12345
  Input Password  ${REGISTER_PASS_TEXT_FIELD}  12345
  Select From List By Label  ${BUSINESS_ENTITY_COMBOBOX}  Pessoa Física

submeto os dados do formulário
  Submit Form     ${REGISTER_BUTTON}

devo receber uma mensagem de sucesso
  Wait Until Page Contains   Lorem ipsum, teu cadastro foi realizado com sucesso!

devo visualizar a opção de acessar meus pedidos
  Page Should Contain Link   ${MY_ORDERS_LINK}

devo visualizar a opção de acessar minha lista de desejos
  Page Should Contain Link   ${WISH_LIST_LINK}
