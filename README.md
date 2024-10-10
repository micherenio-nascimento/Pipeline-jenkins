# Teste técnico ESIG

## Jenkins no Tomcat com Docker

Este repositório fornece um Dockerfile que configura o Jenkins em um servidor **Tomcat**. A solução é executada em um contêiner Docker, tornando fácil e rápida a implantação do Jenkins para pipelines de CI/CD.

## Pré-requisitos

Antes de começar, certifique-se de ter os seguintes requisitos:

- [Docker](https://docs.docker.com/get-docker/) instalado e funcionando corretamente na sua máquina.
- [Docker Compose](https://docs.docker.com/compose/install/) instalado para orquestração de múltiplos contêineres.

## Construindo a Imagem

Para construir a imagem Docker que contém o Jenkins rodando no Tomcat, siga os passos abaixo:

1. Navegue até o diretório onde o arquivo `Dockerfile` está localizado.
2. Execute o seguinte comando para construir a imagem:

    ```bash
    docker build -t jenkins-tomcat .
    ```

## Executando os Contêineres

Para simplificar a execução dos serviços, você pode usar o Docker Compose. O arquivo `docker-compose.yml` já está configurado para executar os serviços do Tomcat (com Jenkins) e do Prometheus. Para iniciar os contêineres, siga as etapas abaixo:

1. **Inicie os contêineres** usando o comando:

    ```bash
    docker-compose up -d
    ```

2. **Acesse o Jenkins** no navegador. O Jenkins estará disponível em:

    ```bash
    http://localhost:8080/jenkins
    ```

Aqui, você verá a interface de configuração inicial do Jenkins.

## Recuperando a Senha de Administrador

Ao acessar o Jenkins pela primeira vez, será solicitada uma **senha de administrador inicial**. Para recuperá-la, siga estas etapas:

1. Acesse o contêiner em execução usando o comando:

    ```bash
    docker exec -it tomcat-jenkins /bin/bash
    ```

2. Uma vez dentro do contêiner, execute o comando abaixo para exibir a senha:

    ```bash
    cat /root/.jenkins/secrets/initialAdminPassword
    ```

3. Copie a senha exibida no terminal e cole-a na tela de configuração inicial do Jenkins.

### Usando o Prometheus para Monitoramento

O Prometheus é uma ferramenta de monitoramento poderosa que permite coletar e armazenar métricas em tempo real. No contexto do Jenkins, o Prometheus pode ser utilizado para monitorar o desempenho do servidor Jenkins, a quantidade de builds realizados, o tempo de execução de jobs e outros dados importantes que ajudam a garantir a saúde e a eficiência do ambiente de CI/CD.

#### Por que usar o Prometheus?

- **Visibilidade**: Monitore a saúde do Jenkins e identifique problemas antes que eles afetem a entrega.
- **Alertas**: Configure alertas baseados em métricas para ser notificado sobre problemas, como builds que falham com frequência ou tempos de execução acima do normal.
- **Análise de Performance**: Analise o desempenho ao longo do tempo e identifique tendências que podem ajudar a otimizar o uso do Jenkins.

#### Acessando a Interface do Prometheus

Após iniciar os contêineres, você pode acessar a interface do Prometheus no navegador. O Prometheus estará disponível em:

```bash
http://localhost:9090
```

Aqui você poderá visualizar as métricas coletadas, executar consultas e configurar alertas conforme necessário.

### Porta 8080

O Jenkins está sendo executado na porta **8080** dentro do contêiner e mapeado para a porta **8080** do host. Certifique-se de que essa porta esteja disponível no seu sistema local antes de executar o contêiner.

### Criando Usuários Adicionais

Após o primeiro login com a senha de administrador, é recomendável **criar usuários adicionais** com privilégios menores para o gerenciamento diário do Jenkins. Isso melhora a segurança do ambiente.



## Acessando o Grafana

Após iniciar os contêineres, você pode acessar a interface do Grafana no navegador. O Grafana estará disponível em:

```
http://localhost:3000
```

### Login

Use as credenciais padrão:

- **Usuário**: `admin`
- **Senha**: `admin` (será solicitado que você mude a senha após o primeiro login).

## Adicionando o Prometheus como Fonte de Dados

### 1. Adicione uma nova fonte de dados:

- No painel principal do Grafana, clique em **"Configuration"** (ícone de engrenagem) no menu lateral.
- Selecione **"Data Sources"**.

### 2. Escolha o Prometheus:

- Clique em **"Add data source"**.
- Selecione **"Prometheus"** na lista de fontes de dados.

### 3. Configure a fonte de dados:

- No campo **URL**, insira:
  
```
http://prometheus:9090
```

- Clique em **"Save & Test"** para garantir que o Grafana consegue se conectar ao Prometheus.

## Criando Dashboards

### 1. Crie um novo dashboard:

- No painel principal do Grafana, clique em **"+"** no menu lateral e selecione **"Dashboard"**.

### 2. Adicione um painel:

- Clique em **"Add new panel"**.
- No editor de consultas, insira uma consulta Prometheus, como:

```
jenkins_job_builds_total
```

### 3. Configure o painel:

- Personalize o gráfico usando as opções de visualização.
- Clique em **"Apply"** para salvar o painel no dashboard.

Repita para adicionar mais painéis conforme necessário, usando diferentes consultas para monitorar métricas variadas do Jenkins.

## Exemplos de Consultas para o Grafana

- **Total de builds**:
  
```
jenkins_job_builds_total
```

- **Builds bem-sucedidos**:

```
count(jenkins_job_builds_total{result="SUCCESS"})
```

- **Builds falhados**:

```
count(jenkins_job_builds_total{result="FAILURE"})
```

- **Tempo médio de execução dos builds**:

```
avg(jenkins_job_build_duration_seconds)
```