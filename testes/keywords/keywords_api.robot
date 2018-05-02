*** Settings ***
Documentation    Testes da API feita via tornado

Library             SeleniumLibrary
Library             DebugLibrary
Library             RequestsLibrary
Library             Collections


*** Variables ***

${host}   http://localhost:8888/content

*** Keywords ***

#1. Cenário
Dado que conect na API
    create session  api     ${host}

Quando informar o nome do arquivo "${nome_arquivo}", conteudo "${conteudo}"
    ${resp}=    post request  api    ${nome_arquivo}    ${conteudo}
    set test variable  ${resp}

Então é apresentado o status "${retorno_json}" e mensagem "${mensagem}"
    Log      ${resp.text}
    log      ${resp}
    Should Be Equal As Strings    ${resp.status_code}   ${retorno_json}
    should be equal as strings    ${resp.text}          ${mensagem}


#2. Cenário: Enviar nome do arquivo sem conteudo
Quando informar o nome do arquivo "${nome_arquivo}" sem conteudo
    ${resp}=    post request  api    ${nome_arquivo}
    Set Test Variable   ${resp}

#3. Cenário: Ler aquivo existente

Quando eu informar o nome do arquivo "${nome_arquivo}"
    ${resp}=    get request     api     ${nome_arquivo}
    set test variable  ${resp}

#4. Cenário: Ler arquivo inexistente
