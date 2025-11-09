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

3 - Clique na sua foto de perfil e vá em Settings → Developer Settings → Personal acess tokens → Tokens(classic)

4 - clique em "Generate new token"

6 - Escolha um nome para o token e escolha os repositórios que deseja acesso(Ex: projeto-app e projeto-manifests)

7 - Escolhas as permissões "Contents" e "pull requests" e mude elas para Read and Write

8 - Logo após crie o token e guarde o codigo do token

3 - Entre no seu repositório projeto-app

4 - Vá em Settings → Secrets and variables → Actions e adicione:

| Nome         | Valor             
|----------------|----------------|
| DOCKER_USERNAME	         | seu usuário Docker Hub     
| DOCKER_PASSWORD          | token de acesso Docker Hub
| SSH_PRIVATE_KEY          | chave privada para acesso ao repositório projeto-manifests (para o push) 
| MANIFESTS_PAT            | token criado

!!!! foto das chaves criadas no git hub

5 - Adicione a chave pública ao repositório projeto-manifests:

6 - Entre no repositório e vá em Settings → Deploy keys → Add deploy key

7 - cole o conteudo da chave pública (ci_cd.pub)

!!!! foto do deploy key no repositorio projeto-manifests

8 - Vá no repositório projeto-app e entre no arquivo ci_cd.yaml que está na pasta workflows e escreva esse código dentro:

!!!! foto do workflow

## Etapa 3 - Criando o Deployment e o Service

1 - Entre no repositório projeto-manifests e crie dois arquivos: ```deployment.yaml e service.yaml  ```

2 - dentro de deployment.yaml digite:

!!!! foto do deployment

3 - dentro de service.yaml digite:

!!!! foto do service

## Etapa 4 - Criar o APP no argocd

1 - Encontre o cluster que você está utilizando e salve o link do server, digite o seguinte comando para encontrar:

```kubectl config view -o jsonpath='{range .clusters[*]}{.name}{" => "}{.cluster.server}{"\n"}{end}'```

2 - configure no arquivo kubeconfig as informações do cluster, definindo o endereço do servidor da API Kubernetes (API Server), coloque o nome do cluster e o link do server nesse código:

``` kubectl config set-cluster (nomeCluster) --server=(linkServer)```

3 - defina o contexto ativo no kubectl com o comando: 

```kubectl config use-context (nomeCLuster)```

4 - crie um túnel local(port-forward) entre a sua máquina e o serviço do Argo CD:

``` kubectl port-forward svc/argocd-server -n argocd 8081:443 ```

5 - Mantenha o port-forward e abra uma nova aba no terminal para pegar a senha do admin e copiar, utilize o seguinte código:

``` kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo ```

6 - Faça login no argoCD utilizando a senha copiada, digite:

``` argocd login localhost:8081 --username admin --password <SENHA> ``` 

7 - Você pode acessar o argoCD no navegador digitando: ```localhost:8081```

!!!! imagem da tela do argocd no navegador

8 - Adicione o seu cluster ao argocd:

```argocd cluster add nomeCluster```

9 - Adicione o repositório Git ao ArgoCD, altere esse código colocando seu nome do usuário github, seu token criado anteriormente e o seu repositório git:
```argocd repo add https://nomeusuario-GitHub:TOKEN@github.com/nomeusuario-GitHub/repositorio-manifests.git --username nomeusuario-GitHub --password TOKEN --name repositorio-manifests```

10 - Você pode visualizar os seus cluster adicionados com o comando:

```argocd cluster list```

11 - Copie e guarde o link do server do cluster adicionado e depois vá para o seu repositório projeto-manifests e copie o link do repositorio

12 - Coloque o link do server e o link do repositório nesse código e depois cole no bash para criar a aplicação chamada projeto-app:

```argocd app create projeto-app --repo (seuRepositorio) --path . --dest-server (linkServeridor) --dest-namespace default ```

13 - Veja os detalhes da aplicação com o comando:

```argocd app get (nomeApp) ```

14 - Sincronize a aplicação (aplicar os manifests no cluster):

``` argocd app sync (nomeApp) ```

15 - Encontre o serviço da sua aplicação, digite o seguinte comando para encontrar:

```kubectl get services -n default```

16 -  Depois de encontrar, crie um túnel local(port-forward) entre a sua máquina e o serviço do Argo CD:
kubectl port-forward svc/(nomeServiço) -n default 8080:80

17 - Entre no site digitando no navegador o endereço:

```localhost:8080```

!!!! imagem da aplicação funcionando



