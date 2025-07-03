# Etapa 1: Escolher uma imagem base oficial do Python.
# Usar a tag 'slim' resulta em uma imagem menor, ideal para produção.
FROM python:3.13.4-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências.
# Copiamos este arquivo separadamente para aproveitar o cache de camadas do Docker.
# A instalação de dependências só será executada novamente se o requirements.txt mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# A flag --no-cache-dir reduz o tamanho final da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
EXPOSE 8000

# Etapa 7: Definir o comando para iniciar a aplicação com Uvicorn.
# O host '0.0.0.0' torna a API acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]