## Deploy Automatizado no Google Cloud

Agora que entendemos como cada passo do processo de deploy funciona, vamos automatizá-lo usando um **pipeline** com [GitHub Actions](https://github.com/features/actions?locale=pt-BR).

Automatizar tarefas repetitivas e demoradas é essencial. Isso aumenta a eficiência, a velocidade e a precisão dos processos de TI, permitindo que a equipe foque em outras tarefas mais importantes.

O processo que estamos automatizando é a implantação de um serviço ou aplicação na nuvem. A automação é fundamental nesse caso, pois ela:

- **Evita erros humanos:** O pipeline segue um fluxo predefinido, minimizando falhas.
  
- **Acelera o deploy:** Atualizações e correções são entregues de forma mais rápida e segura.
  
- **Aplica testes e validações:** Antes mesmo do deploy, podemos rodar testes no código que está sendo mesclado na branch principal.
  
Como vimos na prática de deploy manual, a automação nos permite aplicar os princípios de **Integração e Entrega Contínuas (CI/CD)**. A principal diferença é que, agora, o processo será contínuo: qualquer alteração no código irá desencadear automaticamente a execução do nosso pipeline.

### Compreendendo o Fluxo de Deploy

Iremos aplicar o fluxo ilustrado abaixo:

![Pipeline](/assets/pipeline.png)

- **Commit no Git (GitHub):** O processo começa quando fazemos um commit e o enviamos para o repositório no GitHub.

- **Git Actions (Observando o Repositório):** A seta pontilhada entre o GitHub e o Git Actions indica que o Git Actions está observando o repositório. Isso significa que ele está configurado para detectar automaticamente novas alterações (commits, pull requests etc.) no repositório. Quando uma alteração específica ocorre, como um novo commit na branch principal, o Git Actions é acionado.

- **Pipeline (Início da Execução)**: Uma vez acionado, o Git Actions inicia o pipeline que é composto por seis passos principais, que serão executados em sequência:
  
  - **Checkout Source Code:** A primeira etapa do pipeline é buscar o código-fonte mais recente do repositório no GitHub. Isso garante que o pipeline esteja trabalhando com a versão mais atual do projeto.

  - **Login no Google Cloud:** Nesta etapa, o pipeline se autentica na plataforma Google Cloud. Isso é necessário para que o pipeline possa interagir com os serviços do Google Cloud, como o Artifact Registry e o     Cloud Run. O Authenticator (Autenticador) no diagrama é o mecanismo usado para essa autenticação, que geralmente envolve credenciais ou chaves de serviço configuradas de forma segura.

  - **Configurar Docker para acessar o Google Cloud:** Após o login, o ambiente do Docker dentro do pipeline é configurado para poder se comunicar com o Google Cloud. Isso inclui a configuração das credenciais e     do endpoint do Artifact Registry, para que o Docker saiba onde enviar as imagens.

  - **Criar Docker Image:** Nesta etapa, o pipeline utiliza o Dockerfile presente no código-fonte para construir uma imagem Docker.

  - **Enviar Imagem para o Artifact Registry:** A imagem Docker recém-criada é enviada para o Artifact Registry.

  - **Fazer Deploy da Imagem criada no Cloud Run:** Esta é a etapa final do pipeline. A imagem que foi armazenada no Artifact Registry é utilizada para fazer um deploy no Cloud Run. A seta entre o Registry e         o Run reforça que o Cloud Run busca a imagem diretamente do Registry para executá-la.

## Configurando o Ambiente e o Pipeline

1. **Utilize o mesmo projeto e repositório criado anteriormente no Google Cloud:**
   
2. **Crie e prepare o repositório no GitHub:**

   Crie um repositório no GitHub. Em seguida, clone o repositório do projeto atual para sua máquina local e copie todos os arquivos para a pasta do novo repositório que você acabou de criar. Antes de enviar as      alterações para o GitHub, **exclua a pasta .github.** Isso é fundamental para que você possa aprender a criar o pipeline do zero no próximo passo. Após a exclusão, envie todas as alterações para o seu novo       repositório no GitHub.

3. **Configure o Workflow:**

   No menu superior do seu repositório no GitHub, clique em **Actions**.

   ![Actions](/assets/actions.png)

   Você verá alguns templates prontos que podem ser reutilizados. Como o processo envolve a construção de uma imagem Docker, vamos usar o template sugerido pelo GitHub Actions para este tipo de tarefa.

   ![Choose WorkFlow](/assets/workflow.png)

   Copie e cole as instruções do arquivo YML disponível neste repositório na pasta .github/workflows. Salve as alterações para criar o arquivo do seu pipeline.

   ![YML](/assets/yml.png)

   Algumas informações importantes sobre esse Workflow:

   - O pipeline será acionada toda vez que um novo push for feito na branch main.
     
     ```sh
     on:
       push:
         branches: [ "main" ]
     ```
   
   - Não é recomendado armazenar dados sensíveis, como credenciais, diretamente no código-fonte. Para isso, o GitHub Actions utiliza o conceito de secrets.

     A linha `environment: gcp-prod` indica que o pipeline será executado em um ambiente de produção chamado gcp-prod. O uso de environments permite gerenciar segredos e permissões de forma mais organizada e          segura.

    Vá até o menu **Actions** e verifique os logs. A primeira tentativa de deploy irá falhar, pois ainda não configuramos as credenciais necessárias.

    ![Deploy Failure](/assets/deploy_failure.png)

4. **Configurando o Ambiente:**

   No menu superior do GitHub, procure por **Settings > Environments** e crie um ambiente.

   ![Environment](/assets/environment.png)

   ![Adicionando Environment](/assets/add_environment.png)

   Dentro do ambiente recém-criado, crie um secret para configurar o projeto do Google Cloud.

   ![Adicionando Secrets](/assets/add_secrets.png)

   Nomeie o secret com o mesmo nome que está no arquivo YML do pipeline. No campo value, insira o ID do seu projeto do Google Cloud, que pode ser encontrado no seletor de projetos no console do Google Cloud.       Salve as alterações.

   ![Secret Project ID](/assets/secret_project_id.png)

   Agora, acesse o console do Google Cloud para criar uma credencial de acesso associada a uma conta de serviço. Certifique-se de que está com o projeto correto selecionado.

   No menu lateral procure por **IAM and Administrator > Service Accounts** e crie uma conta de serviço. É uma boa prática criar uma conta de serviço dedicada para interagir com os serviços do Google Cloud, em     vez de usar sua conta principal.

   ![Service Account](/assets/service_account.png)

   ![Create Service Account](/assets/create_service_account.png)

   Nos três pontos ao lado da Conta de Serviço, clique em **Manage Keys**. Crie uma chave do tipo JSON.

   ![Create New Key](/assets/create_new_key.png)

   ![Create Key JSON](/assets/create_key_JSON.png)

   O arquivo da chave será baixado em sua máquina. Abra-o, copie o conteúdo e cole-o no value de um novo secret para a credencial do Google Cloud no GitHub.

   ![Secret Credentials](/assets/secret_credentials.png)

   No final, seus secrets devem estar configurados. Por questões de segurança, o GitHub não exibe o valor dos secrets após a criação, então, se precisar alterá-lo, você terá que inserir o valor novamente.

   ![Secrets](/assets/secrets.png)

5. **Dê permissões à sua conta de serviço:**

   Se tentarmos realizar o deploy novamente, a tentativa falhará devido a um erro de permissão. Isso acontece porque precisamos conceder à conta de serviço as permissões necessárias para: ser usada, enviar a       imagem para o repositório e implantar a imagem no serviço do Cloud Run.

   No menu lateral do Google Cloud, procure por **IAM and Administrator > IAM** e adicione as permissões à conta de serviço que você criou.

    ![Allow Access](/assets/allow_access.png)

    ![Roles](/assets/roles.png)

   As permissões necessárias são:

   - **Artifact Registry Writer:** Permissão para enviar a imagem para o repositório do Artifact Registry.

   - **Cloud Run Administrator:** Permissão para implantar a imagem no serviço do Cloud Run.

   - **Service Account User:** Permissão para que a conta de serviço possa ser utilizada.

    O **Artifact Registry** é o sucessor do **Container Registry** no Google Cloud e o serviço mais novo para gerenciamento de artefatos. Embora o Container Registry ainda funcione, o Google recomenda a             migração para o Artifact Registry.

    A principal vantagem é que ele oferece um controle de permissões muito mais detalhado e seguro. Enquanto o Container Registry exigia acessos amplos, o Artifact Registry permite que você conceda permissões       mínimas e específicas para cada repositório, tornando a gestão mais simples e segura.

6. **Realize o Deploy**

   Execute o deploy novamente, acesse a aba **Actions**, selecione a última ação que falhou e clique em **Re-run all jobs**. Desta vez, o deploy será executado com sucesso!

   ![Successful Deploy](/assets/successful_deploy.png)

   Após o deploy, verifique a imagem no seu repositório Artifact Registry. O nome definido para a imagem é API.

   ![Repositório de Images](/assets/imagem_repository.png)

   Clique em API e confira as versões da imagem.

   Acesse o serviço pelo Cloud Run e clique na URL gerada.

   ![Serbiços](/assets/services.png)

   ![URL da API](/assets/api_url.png)

   https://api-827405736636.southamerica-east1.run.app/docs

   Pronto, a aplicação está acessível a todos!





   









