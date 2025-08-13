## Deploy Manual no Google Cloud

A aplicação agora está empacotada e pronta para rodar em qualquer ambiente, mas como disponibilizar isso para todo mundo poder acessar?

É para isso que vamos usar o **Google Cloud**, mais especificamente o Google Cloud Run que hospedará a aplicação. O **[Cloud Run](https://cloud.google.com/run/docs/overview/what-is-cloud-run?hl=pt-br)** é um serviço gerenciado pela Google. A melhor parte? Você só precisa subir uma imagem do seu container, e ele cuida do resto. Ele escala automaticamente para dar conta dos picos de tráfego e reduz a escala quando não há demanda, o que é ótimo para economizar recursos.

### Entendendo CI e CD

Vamos aplicar uma das práticas importantes do **[DevOps](https://www.alura.com.br/artigos/o-que-e-devops)**: o CD (Continuous Deployment), ou "Deploy Contínuo". Isso significa que, a cada atualização que fizermos na nossa branch principal, essa mudança será refletida no ambiente de produção.

**Atenção:** Embora o deploy seja continuo, o CI (Continuous Integration),  que envolve testes e validações de código, não será aplicada neste projeto. A mesclagem de código na branch principal não passará por testes automatizados antes de ser integrada.

Tudo isso será feito através de um **processo manual** que simula um pipeline de deploy para a aplicação.

Em **DevOps**, um **pipeline** é um processo automatizado que descreve os passos necessários para mover o código de desenvolvimento para a produção. Para fins didáticos, faremos esse processo de forma manual, onde cada passo é executado por uma pessoa. Isso nos permite entender o **Deploy Contínuo (CD)** na prática, executando o deploy manualmente a cada mudança na branch principal.

Aprender o processo de deploy manualmente é fundamental para o sucesso da automação. Ao fazê-lo, você entende cada etapa, identifica gargalos e aprende a resolver problemas. Essa experiência será a base para a criação futura de um pipeline automatizado.

## Pré-requisitos

1. **Instale o Google Cloud CLI**

   O **[Google Cloud CLI](https://cloud.google.com/sdk/docs/install?hl=pt-br#supported_python_versions)** é um conjunto de ferramentas para gerenciar os recursos do Google Cloud a partir da linha de comando do      seu terminal.

2. **Crie sua conta no Google Cloud**

   O **[Google Cloud](https://cloud.google.com/free?utm_source=PMAX&utm_medium=display&utm_campaign=FY25_H1&utm_content=latampaidmedia_br_smb_dr_rda_gcp_pmax_FY25_H1_cloudstyle-patterns-artboard1_luac0021001_1710136&utm_term=-&gad_source=1&gad_campaignid=22113798131&gclid=CjwKCAjwkbzEBhAVEiwA4V-yqq390KVvyKo8eH-A3ylnkzixQNLBtRn7PXgOEFSljwJQgiXOHAEjaBoCxnwQAvD_BwE&gclsrc=aw.ds&hl=pt_br)** oferece créditos gratuitos para novos usuários por um tempo.

3. **Crie um Projeto**

   Dentro do console do Google Cloud, abra o seletor de projetos e crie um.

   ![Página inicial do Google Cloud](/assets/home_google_cloud.png)
   ![Seletor de projetos](/assets/projects.png)

   Para usar os recursos e fazer deploys, precisamos sempre de um projeto associado a uma conta de faturamento.

   ![Novo projeto](/assets/new_project.png)

4. **Ative as APIS Cloud Run e Artifact Registry**

   No menu lateral, procure por **API e Serviços > Biblioteca**. É aqui que vamos encontrar todas as APIs da Google.

   ![Biblioteca Google Cloud](/assets/library_google.png)

   Pesquise por **Cloud Run** e **Artifact Registry** e verifique se ambas estão ativadas.

   ![API Cloud Run](/assets/cloud_run_api.png)
   ![API Artifact Registry](/assets/artifact_registry_api.png)

   É essencial que as duas APIs estejam ativadas para que nosso deploy funcione! Se não estiverem, ative-as.

5. **Crie um Repositório de Images**

   Pesquise por **Artifact Registry** na barra de pesquisa superior. Ele é o repositório de imagens Docker da própria Google. É onde nossas imagens ficarão salvas após o **build**.

    ![Repositório do Artifact Registry](/assets/artifact_registry_repository.png)

   Crie um repositório para imagens Docker com as seguintes configurações:

    -	**Format:** Docker

    -	**Mode:** Pattern

    -	**Location Type:** Region

    -	**Region:** southamerica-east1 (São Paulo)

    Você pode deixar as outras configurações no padrão, pois para este projeto simples não precisaremos delas.

## Execute os seguintes comandos gcloud no terminal

1. **Autentique-se e Configure o   Projeto**

   ```sh
    # Autenticar com a sua conta Google
    gcloud auth login

    # Definir qual projeto usar pelo ID (substitua 'PROJECT_ID')
    gcloud config set project PROJECT_ID
    ```

    Para confirmar o projeto configurado, você pode usar o comando `gcloud config get-value project`

2. **Realize o Deploy**

   O comando `gcloud run deploy` vai fazer tudo para a gente: identificar o seu Dockerfile, construir a imagem, enviá-la para o Artifact Registry e criar um serviço no Cloud Run.

    ```sh
    gcloud run deploy <nome-do-servico> --source . --image southamerica-east1-docker.pkg.dev/<seu-id-do-projeto>/<nome-do-repositorio-docker>/<nome-da-imagem> --region southamerica-east1 --allow-unauthenticated --port 8000
    ```
   
  Vamos entender o que cada parte faz:

  - `gcloud run deploy`: Este é o comando principal que você usa para implantar um serviço no Cloud Run.

  - `<nome-do-servico>`: Este é o nome que estamos dando ao novo serviço no Cloud Run. É o nome que vai aparecer no console e que será usado na URL.

  - `--source .`: Essa flag diz ao Cloud Run para criar a imagem de contêiner usando o código-fonte que está no diretório atual. Ele vai procurar por um Dockerfile e construir a imagem a partir dele.

  - `--image southamerica-east1-docker.pkg.dev/<seu-id-do-projeto>/<nome-do-repositorio-docker>/<nome-da-imagem>`: Essa flag  faz um trabalho duplo:
    
     - Primeiro, ela instrui o Google Cloud a **construir** a imagem do seu container e, em seguida, a **salvá-la** no repositório de imagens especificado por você (o Artifact Registry).

     - Depois de salva, a mesma *flag* informa ao Cloud Run onde a imagem está para que ele possa **buscá-la e executar** a aplicação.

  - `--region southamerica-east1`: Especifica que o serviço estará na região de São Paulo.

  - `--allow-unauthenticated`: Permite que qualquer pessoa acesse a URL, sem precisar de login.

  - `--port 8000`: Informa a porta que nosso container vai expor.

3. **Acesse o projeto**

   O Google Cloud Run vai gerar uma URL para a aplicação. No seu terminal, você vai ver algo parecido com isto:

   https://api-827405736636.southamerica-east1.run.app/docs

   Agora a aplicação está na nuvem e disponível para todo mundo!

   







