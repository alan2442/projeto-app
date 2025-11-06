# Imagem base do Python
FROM python:3.11-slim

#
WORKDIR /app

# Copia os arquivos
COPY . .

# Instala as dependencias
RUN pip install -r requirements.txt
RUN pip install fastapi uvicorn

# Expõe a porta padrão
EXPOSE 8080

# Comando para rodar FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]