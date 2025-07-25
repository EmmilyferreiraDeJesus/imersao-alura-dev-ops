# Execução local sem Docker

1. **Crie um ambiente virtual:**

```sh
   # Linux/Mac
   python3 -m venv ./venv

   # Windows
   python -m venv ./venv      # Usa o Python padrão configurado no sistema
   py -3 -m venv ./venv       # Usa especificamente o Python 3, ideal se há várias versões instaladas

   ```

2. **Ative o ambiente virtual:**

```sh
   # Linux/Mac
   source venv/bin/activate

   # Windows
   venv\Scripts\activate
   ```

## ⚠️ Problema: "running scripts is disabled on this system"

Se ao tentar ativar o ambiente virtual no **Windows**, você receber a mensagem:

 - **ERRO:** "File ... cannot be loaded because running scripts is disabled on this system".

Isso acontece porque o PowerShell está com a execução de scripts desabilitada por questão de segurança.

### ✅ Solução

- **Abra o PowerShell como Administrador**
- Verifique a política de execução:

   ```sh
    Get-ExecutionPolicy
   ```

    Provavelmente, será **"Restricted"**, que é o padrão e impede a execução de scripts.

- Execute o seguinte comando:

   ```powershell
   Set-ExecutionPolicy RemoteSigned
    ```
    Pressione Y e depois Enter para confirmar.
   Tente ativar o ambiente virtual novamente.

##

3. **Instale as dependências:**

   ```sh
   pip install -r requirements.txt
   ```

4. **Execute a aplicação:**

   ```sh
   uvicorn app:app --reload
   ```

5. **Acesse a aplicação com a documentação interativa:**

   Abra o navegador e acesse: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

   Aqui você pode testar todos os endpoints da API de forma interativa.
