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

## Etapa 1
1 = Crie dois repositórios no seu git hub chamados de: projeto-app e projeto-manifests
2 - no repositório projeto-app crie os seguintes arquivos: 
```main.py, requeriments.txt e Dockerfile```
