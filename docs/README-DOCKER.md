# Execução Local com Docker

Vamos usar o **[Docker](https://www.alura.com.br/artigos/comecando-com-docker?srsltid=AfmBOorVIPa1fr58GKb_bnSJjPM6xNu78YNvXmS4T-GbavXH2YhCJXKK)** para que a aplicação possa rodar em qualquer máquina. A grande vantagem do Docker é que ele permite **empacotar nossa aplicação em uma imagem**. Pense na imagem como uma uma **receita completa** que já inclui tudo o que a aplicação precisa para funcionar – mesmo que você não tenha essas dependências instaladas diretamente na sua máquina! A imagem cuida de configurar o ambiente dentro do contêiner, garantindo que a aplicação rode sem problemas. Essa imagem pode ser enviada para um **repositório compartilhado** (como o Docker Hub). Assim, qualquer pessoa que precise usar a aplicação só precisará **baixar essa imagem** na máquina para rodar, simplificando muito a distribuição e o uso!

1. **Inicie o Docker Engine:**

   Para usar o Docker, o Docker Daemon precisa estar rodando na sua máquina. O Docker CLI (o comando docker que você usa no terminal) é apenas o cliente, ele não consegue executar contêineres ou construir           imagens sozinho. É o Docker Engine (o daemon) que faz todo o trabalho. Se ele não estiver iniciado, o cliente Docker não conseguirá se conectar a ele.

   - **Windows/macOS:** O Docker Desktop é a forma mais fácil de ter o daemon do Docker rodando.
   - **Linux:** O Docker Engine é instalado como um serviço do sistema e fica rodando em segundo plano.

   Verifique se o Docker está em execução rodando qualquer comando no terminal:

    ```sh
    # por exemplo
    docker ps .
    ```
2. **Construa a Imagem do Contêiner:**

   Use o Dockerfile que está neste repositório para construir a imagem.

   O Dockerfile é essencial para trabalhar com Docker. Ele é responsável por definir como a imagem do contêiner deve ser construída.

    ```sh
    docker build -t school_api .
    ```

   Verifique se a imagem foi construída com sucesso.

    ```sh
    docker images
    ```

    - **Observação**: Você pode criar um arquivo `.dockerignore` para otimizar a criação da sua imagem Docker. Se você não especificar este arquivo no seu               projeto, tudo que estiver no diretório           será enviado para o daemon do Docker no momento da compilação. Arquivos como `node_modules`, ambientes virtuais             (`venv`) ou até mesmo caches podem ser ignorados durante a compilação, tornando a       imagem mais leve e eficiente.

3. **Execute o Contêiner:**

   Para que a aplicação rode e você possa acessá-la, precisamos "conectar" a porta de dentro do contêiner à uma porta do seu computador. Pense no contêiner como uma "caixa" isolada. Sua aplicação está na            porta 8000 dentro dessa caixa.

   O comando `-p 8000:8000` faz essa "ponte":

   - O primeiro `8000` é a porta no seu computador.

   - O segundo `8000` é a porta dentro do contêiner.

   Assim, quando você acessar a url no seu navegador, o Docker redireciona para a aplicação dentro da "caixa".

   ```sh
    docker run -p 8000:8000 school_api
   ```

   Para parar a aplicação, pressione Ctrl + C no terminal onde o container está rodando.

5. **Acesse a Aplicação com a Documentação Interativa:**

   Abra o navegador e acesse: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
   
