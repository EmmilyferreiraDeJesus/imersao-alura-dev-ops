<h1>
  <img src="https://cloud.google.com/_static/cloud/images/social-icon-google-cloud-1200-630.png" alt="Google Cloud Icon" width="100" style="vertical-align:middle; margin-right:10px;" />
  Alura Imersão DevOps com Google Cloud
</h1>

API desenvolvida com Python e FastAPI para gerenciar alunos, cursos e matrículas em uma instituição de ensino. 

O objetivo principal é explorar o uso do Docker para construir e executar aplicações em qualquer maquina localmente e fazer o deploy na nuvem utilizando o Google Cloud.

---

## ⚙️ Tecnologias utilizadas

- **Python 3.10**
- **FastApi**
- **SQLite**
- **Docker**
- **Google Cloud**
  - Cloud Run
  - Artifact Registry
  - SDK gcloud CLI

---

## 📂 Estrutura do projeto

- `app.py`: Ponto de entrada da aplicação FastAPI.
- `models.py`: Definição dos modelos do banco de dados (SQLAlchemy).
- `schemas.py`: Schemas de validação de dados (Pydantic).
- `database.py`: Configuração da conexão com o banco de dados SQLite.
- `routers/`: Contém os arquivos de rotas para cada entidade (alunos, cursos, matrículas).
- `requirements.txt`: Lista de dependências do projeto (bibliotecas Python).

**Observações:**

- O banco de dados SQLite (`escola.db`) será criado e gerenciado automaticamente na primeira execução.
- Para reiniciar o banco de dados (apagar todos os dados), basta excluir o arquivo `escola.db`.

---

## 🚀 Como Executar e Fazer o Deploy do Projeto

- [Execução local sem Docker](docs/README-NO-DOCKER.md)
- [Execução local com Docker](docs/README-DOCKER.md)
- [Execução local com Docker Compose](docs/README-DOCKER-COMPOSE.md)
- [Deploy Manual no Google Cloud](docs/README-DEPLOY-MANUAL-GOOGLECLOUD.md)
- [Deploy Automatizado no Google Cloud](docs/README-DEPLOY-AUTOMATIZADO-GOOGLECLOUD.md)






