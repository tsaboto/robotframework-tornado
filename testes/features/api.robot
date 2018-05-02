*** Settings ***
Documentation  Teste da API criado com o tornad

Resource  ../keywords/keywords_api.robot


*** Test Cases ***

1. Cenário: Enviar nome do arquivo TipoExercicio e conteudo Abdominal para API via POST
    [Tags]    post_qrquivo_valido
    Dado que conect na API
    Quando informar o nome do arquivo "TipoExercicio", conteudo "Abdominal"
    Então é apresentado o status "200" e mensagem "Mensagem criada com sucesso"

2. Cenário: Enviar nome do arquivo sem conteudo
    [Tags]  post_arquivo_sem_coteudo
    Dado que conect na API
    Quando informar o nome do arquivo "TipoExercicio" sem conteudo
    Então é apresentado o status "400" e mensagem "Aquivo sem conteudo"

3. Cenário: Ler aquivo existente
    [Tags]  ler_arquivo_existente
    Dado que conect na API
    Quando eu informar o nome do arquivo "TipoExercicio"
    Então é apresentado o status "200" e mensagem "Abdominal"

4. Cenário: Ler arquivo inexistente
    [Tags]  ler_arquivo_inexistente
    Dado que conect na API
    Quando eu informar o nome do arquivo "NaoExistente"
    Então é apresentado o status "404" e mensagem "Arquivo não existente"