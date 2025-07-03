# Define a imagem base. Imagem Python baseada em Alpine, que é ótima por ser leve
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Copiamos este arquivo primeiro para aproveitar o cache de camadas do Docker.
# As dependências não serão reinstaladas a cada mudança no código-fonte.
COPY requirements.txt .

# Instala as dependências listadas no requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os outros arquivos do seu projeto (como app.py, routers/, etc.) para o diretório /app no contêiner.
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
