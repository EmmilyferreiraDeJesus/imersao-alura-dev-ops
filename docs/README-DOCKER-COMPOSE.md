## Execução Local com Docker Compose

O **Docker Compose** é uma ferramenta que nos ajuda a **automatizar processos** que seriam manuais e repetitivos, como construir e executar contêineres a partir de imagens Docker. Sua maior vantagem é permitir que a gente **suba e administre múltiplos contêineres de uma vez só.**

Muitas aplicações precisam de vários componentes para funcionar, como um banco de dados, um servidor de backend e um frontend. Cada um desses componentes pode rodar em seu próprio contêiner. Imagina ter que subir cada um deles, mapear portas, e configurá-los separadamente? O Docker Compose resolve isso, permitindo que você configure tudo em um único arquivo e inicie todos os serviços com um só comando.

1. **Inicie o Docker Engine:**

2. **Execute o Docker Compose:**

   Use o Docker Compose que está neste repositório para construir a imagem.

   O Docker Compose utiliza um arquivo (geralmente chamado `docker-compose.yml`). Esse arquivo organiza todo o passo a passo para construir e rodar a aplicação,          definindo quais imagens usar, quais portas mapear, como nomear seus contêineres e muito mais.

    ```sh
    docker compose up
    ```

    Para parar a aplicação, pressione Ctrl + C no terminal onde o container está rodando.

3. **Acesse a Aplicação com a Documentação Interativa:**

   Abra o navegador e acesse: http://127.0.0.1:8000/docs
