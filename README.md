# Jenkins no Tomcat com Docker
Este repositório fornece um Dockerfile que configura o Jenkins em um servidor **Tomcat**. A solução é executada em um contêiner Docker, tornando fácil e rápida a implantação do Jenkins para pipelines de CI/CD.
## Pré-requisitos
Antes de começar, certifique-se de ter os seguintes requisitos:
- [Docker](https://docs.docker.com/get-docker/) instalado e funcionando corretamente na sua máquina.
## Construindo a Imagem
Para construir a imagem Docker que contém o Jenkins rodando no Tomcat, siga os passos abaixo:
1. Navegue até o diretório onde o arquivo `Dockerfile` está localizado.
2. Execute o seguinte comando para construir a imagem:
    ```bash
    docker build -t jenkins-tomcat .
    ```
   Esse comando baixa a imagem base do Tomcat e, em seguida, baixa o arquivo **Jenkins WAR** mais recente para o diretório `webapps` do Tomcat, preparando o ambiente.
## Executando o Container
Após a construção da imagem, você pode iniciar o contêiner executando:
```bash
docker run -d -p 8080:8080 --name jenkins-container jenkins-tomcat
```
## Acessando o Jenkins
Depois de iniciar o contêiner, o Jenkins estará disponível no navegador. Para acessá-lo, basta abrir o seguinte endereço:
```bash
http://localhost:8080/jenkins
```
Aqui, você verá a interface de configuração inicial do Jenkins.
## Recuperando a Senha de Administrador
Ao acessar o Jenkins pela primeira vez, será solicitada uma **senha de administrador inicial**. Para recuperá-la, siga estas etapas:
1. Acesse o contêiner em execução usando o comando:
    ```bash
    docker exec -it jenkins-container /bin/bash
    ```
2. Uma vez dentro do contêiner, execute o comando abaixo para exibir a senha:
    ```bash
    cat /root/.jenkins/secrets/initialAdminPassword
    ```
3. Copie a senha exibida no terminal e cole-a na tela de configuração inicial do Jenkins.
### Porta 8080
O Jenkins está sendo executado na porta **8080** dentro do contêiner e mapeado para a porta **8080** do host. Certifique-se de que essa porta esteja disponível no seu sistema local antes de executar o contêiner.
### Criando Usuários Adicionais
Após o primeiro login com a senha de administrador, é recomendável **criar usuários adicionais** com privilégios menores para o gerenciamento diário do Jenkins. Isso melhora a segurança do ambiente.