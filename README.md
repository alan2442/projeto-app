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

1 - Gere uma chave SSH com o seguinte comando:
```ssh-keygen -t ed25519 -C "github-actions@yourdomain" -f ~/.ssh/ci_cd -N ""```

2 - anote a sua chave pública e privada, digite o seguinte comando para encontra-las:

```cat ~/.ssh/ci_cd = ESTA É A CHAVE PRIVADA (NÃO COMPARTILHAR)```

```cat ~/.ssh/ci_cd.pub = ESTA É A CHAVE PÚBLICA (pode ser adicionada ao GitHub)```

3 - Entre no seu repositório projeto-app

4 - Vá em Settings → Secrets and variables → Actions e adicione:

| Nome         | Valor             
|----------------|----------------|
| DOCKER_USERNAME	         | seu usuário Docker Hub     
| DOCKER_PASSWORD          | token de acesso Docker Hub
| SSH_PRIVATE_KEY          | chave privada para acesso ao repositório projeto-manifests (para o push) 

!!!! foto das chaves criadas no git hub

5 - Adicione a chave pública ao repositório projeto-manifests:

6 - Entre no repositório e vá em Settings → Deploy keys → Add deploy key

7 - cole o conteudo da chave pública (ci_cd.pub)

!!!! foto do deploy key no repositorio projeto-manifests

8 - Vá no repositório projeto-app e entre no arquivo ci_cd.yaml que está na pasta workflows e cole escreve esse código dentro:

!!!! foto do workflow

## Etapa 3 - Criando o Deployment e o Service

1 - Entre no repositório projeto-manifests e crie dois arquivos: ```deployment.yaml e service.yaml  ```

2 - dentro de deployment.yaml digite:

!!!! foto do deployment

3 - dentro de service.yaml digite:

!!!! foto do service


