*** Settings ***
Library  SeleniumLibrary

Test Teardown  Close Browser  

*** Test Cases ***
Cenário: Previsão do tempo em Porto Alegre
    Open browser  browser=firefox    
    Go To         url=http://www.google.com.br
    Input Text    name=q      Previsão do tempo em Porto Alegre
    Press Keys    name=q      RETURN
    Wait Until Page Contains  Previsão do tempo para os próximos 15 dias em Porto Alegre
