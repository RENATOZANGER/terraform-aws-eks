# 🚀 Projeto de Infraestrutura: Cluster EKS com Terraform

Este projeto de Infraestrutura como Código (IaC) utiliza **Terraform** para provisionar um ambiente completo de Kubernetes na AWS usando o **Amazon Elastic Kubernetes Service (EKS)**, incluindo a configuração de rede (VPC, Subnets, Gateways) e a implantação de um aplicativo de exemplo.

## ✨ Destaques da Solução

* **Cluster EKS Gerenciado:** Provisionamento de um cluster EKS com seus recursos de IAM Role.
* **Infraestrutura de Rede Completa:** Criação de uma VPC dedicada com sub-redes públicas e privadas em múltiplas Zonas de Disponibilidade (AZs), utilizando NAT Gateways para acesso privado à internet.
* **AWS Load Balancer Controller:** Instalação e configuração do `aws-load-balancer-controller` via Helm para gerenciar Ingresses e provisionar Application Load Balancers (ALBs) e Network Load Balancers (NLBs) na AWS.
* **Aplicação de Exemplo:** Deploy de um aplicativo de exemplo (nginx) no cluster, exposto através de um Kubernetes Ingress gerenciado pelo ALB Controller.
* **Estado Remoto:** Configuração de backend S3 para gerenciamento seguro e colaborativo do estado do Terraform (`.tfstate`).

## ⚙️ Pré-requisitos

Para executar este projeto, você precisará ter instalado e configurado o seguinte:

1.  **AWS CLI:** Para autenticação e configuração de perfil.
2.  **Terraform:** Versão `~> 1.0` (ou superior, conforme `required_providers`).
3.  **kubectl:** Para interagir com o cluster Kubernetes após o provisionamento.
4.  **Conta AWS:** Configure o perfil para ser usado no `provider.tf`.

## 🚀 Como Usar o Módulo

Para consumir este módulo em um novo projeto Terraform, siga os passos a seguir: 

- Adicione o bloco `module` abaixo ao seu arquivo `main.tf`, substituindo o URL pelo repositório final onde o código está hospedado.

### Exemplo de Inclusão no seu `main.tf`

```terraform
module "eks_cluster" {
  source = "git::https://github.com/RENATOZANGER/terraform-aws-eks.git?ref=main"
  cidr_block   = "10.0.0.0/16"
  project_name = "cluster-eks-dev"
  tags         = {
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}
```

### 1. Backend S3

Este projeto utiliza um backend S3 para armazenar o estado do Terraform. 

Crie o arquivo `provider.tf` para configurar o provider AWS e o backend S3.(Exemplo no repositório, codigo comentado)

Crie o bucket e altere o nome do bucket, chave e região conforme necessário no bloco `backend` do arquivo `provider.tf`:

* **Bucket:** `nome-do-bucket-12345`
* **Key:** `dev/terraform.tfstate`
* **Região:** `us-east-1`


### 1. Inicialização

Execute o `init` para configurar o backend e baixar os *providers* necessários:
**(Opcional):** Se necessario usar o comando aws sso login para autenticar na AWS antes de iniciar o Terraform.

```bash
terraform init
```

### 2. Planejamento

Verifique o que o Terraform irá criar antes de aplicar as mudanças:

```bash
terraform plan
```

### 3. Aplicação

Aplique as configurações para provisionar a infraestrutura:

```bash
terraform apply -auto-approve
```

## 🔗 Acesso ao Cluster e Aplicação

Após a conclusão do terraform apply, o cluster EKS e a aplicação de exemplo estarão rodando.

### 1. Configurar kubectl
O Terraform configura o provider Kubernetes e Helm automaticamente, mas você precisará configurar seu kubectl localmente.

```bash
aws eks update-kubeconfig --name <Nome-do-seu-Cluster-EKS> --region <Sua-Região-AWS>
```

### 2. Usar o Contexto criado do kubectl

```bash
kubectl config use-context <Nome-do-context-criado>
```

### 3. Comandos Úteis
Listar os nós do cluster:
```bash
kubectl get node
```
listar pods no cluster
```bash
kubectl get po -A
```

listar daemonsets
```bash
kubectl get ds -A
```

obter os namespaces
```bash
kubectl get ns
```

listar o loadbalancer controller
```bash
kubectl get deployment -n kube-system aws-load-balancer-controller -oyaml
```

ver o logs do loadbalancer controller
```bash
kubectl logs -n kube-system deployment/aws-load-balancer-controller
```

exibir os ingress criados
```bash
kubectl get ingress -A
```

exibir detalhes do ingress
```bash
kubectl describe ingress -n default
```

Verifique o Ingress para obter o DNS do Load Balancer:

```bash
kubectl get ingress -n default
```
O DNS do Load Balancer será listado na coluna `ADDRESS`. Acesse esse endereço no navegador para ver a página padrão do Nginx.

## 🧹 Limpeza da Infraestrutura
```bash
kubectl delete ingress meu-app-ingress
kubectl delete service meu-app-service
kubectl delete deployment meu-app

terraform destroy -auto-approve
```
