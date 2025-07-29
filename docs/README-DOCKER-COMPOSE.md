## Execução Local com Docker Compose

O **Docker Compose** é uma ferramenta que nos ajuda a **automatizar processos** que seriam manuais e repetitivos, como construir e executar contêineres. Sua maior vantagem é permitir que a gente **suba e administre múltiplos contêineres de uma vez só.**

1. Inicie o Docker Engine:

2. Execute o Docker Compose:

   Use o Docker Compose que está neste repositório para construir a imagem.

   O Docker Compose utiliza um arquivo (geralmente chamado `docker-compose.yml`). Esse arquivo organiza todo o passo a passo para construir e rodar a aplicação.      Ele define quais imagens usar, quais portas mapear, como dar nomes aos seus contêineres e muito mais.

    ```sh
    docker compose up
    ```

    Para parar a aplicação, pressione Ctrl + C no terminal onde o container está rodando.

3. Acesse a Aplicação com a Documentação Interativa:

   Abra o navegador e acesse: http://127.0.0.1:8000/docs
