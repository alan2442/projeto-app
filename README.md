# Projeto 4 - CI/CD com o Github Actions

# Objetivo 
Automatizar o ciclo completo de desenvolvimento, build, deploy e execução de uma 
aplicação FastAPI simples, usando GitHub Actions para CI/CD, Docker Hub como registry, 
e ArgoCD para entrega contínua em Kubernetes local com Rancher Desktop. 

# Pré-requisitos 

• Conta no GitHub (repo público) 

• Conta no Docker Hub com token de acesso 

• Rancher Desktop com Kubernetes habilitado 

• kubectl configurado corretamente (kubectl get nodes) 

• ArgoCD instalado no cluster local 

• Git instalado 

• Python 3 e Docker instalados

## Etapa 1 - Criar a aplicação FastAPI
1 - Crie dois repositórios no seu git hub chamados de: projeto-app e projeto-manifests

2 - no repositório projeto-app crie os seguintes arquivos: 

```main.py, requeriments.txt e Dockerfile```

3 - Crie uma pasta chamada .github e dentro dela crie uma pasta chamada workflows

4 - Dentro da pasta workflows crie o arquivo ```ci-cd.yaml```

5 - dentro do arquivo main.py digite o seguinte código:

!!!! foto do codigo de main. py

6- dentro do arquivo requirements.txt digite: ```fastapi uvicorn```

7 - dentro do arquivo Dockerfile digite:

!!!! foto do arquivo dockerfile

8 - Teste localmente digite no bash os comandos:

```docker build -t projeto-app:latest . ```

```docker run -p 8000:8000 projeto-app```

## Etapa 2 - Criar o GitHub Actions(CI/CD)
1 - Entre no seu repositório projerto-app

2 - Vá em Settings → Secrets and variables → Actions e adicione:

| Nome         | Valor             
|----------------|----------------|
| DOCKER_USERNAME	         | seu usuário Docker Hub     
| DOCKER_PASSWORD          | token de acesso Docker Hub
| SSH_PRIVATE_KEY          | chave privada para acesso ao repositório projeto-manifests (para o push) 

