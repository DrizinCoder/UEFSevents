# Sistema de Gerenciamento de Eventos

Um sistema completo para gerenciamento e visualização de eventos, desenvolvido com Django e containerizado com Docker.

## 📋 Requisitos do Sistema

### 1. Autenticação e Segurança
- Apenas usuários registrados podem cadastrar, editar e excluir os próprios eventos
- Outros usuários precisam estar logados para acessar as informações dos eventos já cadastrados
- Usuários podem ser do tipo **Consumidor** e **Organizador**
- Usuários do tipo organizadores de eventos podem ser do tipo pessoa física ou jurídica:
  - Se jurídica, recebe um **selo azul** caso tenha enviado à plataforma documentação comprovando que é o organizador do evento ou dono do espaço

### 2. Sistema de Denúncia
- Em caso de muitas denúncias, o local ou organização devem ser banidos do aplicativo

### 3. Gestão de Eventos
- Usuários comuns podem visualizar todos os eventos cadastrados em um "calendário"
- Eventos devem ser categorizados e os usuários podem filtrá-los por categoria
- Opção para visualização de eventos próximos
- Detalhes para cada evento, exibindo informações como data, hora, localização, descrição e hiperlinks para mais detalhes
- Apenas usuários autenticados podem cadastrar novos eventos

### 4. Sistema de Notificação
- Criação/Atualização de evento de interesse do usuário naquela região
- Quando o evento estiver próximo (1 dia antes, 2h antes)

### 5. FAQ e Interatividade
- Sistema de perguntas e respostas
- Upvotes/downvotes para destacar perguntas relevantes
- Notificações para os usuários quando suas perguntas forem respondidas

### 6. Configurações do APP
- Modo escuro/claro
- Notificação on/off

## 🏗️ Arquitetura do Software

### Módulos e Funções

#### **Migrations**
- Migrações do banco de dados

#### **Serializers**
- **Users**: Conversão com validação de tipo de usuário
- **Events**: Conversão de eventos, espaços, endereços e imagens
- **FAQ**: Conversão com verificação se a pergunta existe, e com predefinição de data

#### **Apps**
- Apps do módulo

#### **Admin**
- Visão do admin do site

#### **Views**
- **Users**: CRUD, setar filtros, autenticação, verificação se é ativo
- **Events**: CRUD, setar filtros
- **FAQ**: CRUD, setar filtros

#### **Forms**
- **Events**: Formulário HTML para imagens, eventos, endereços e espaços

#### **Filters**
- **Events**: Filtros em cima dos atributos de imagens, eventos, endereços e espaços existentes (ex: categoria, rua, acessibilidade)
- **FAQ**: Filtros em cima dos atributos de perguntas, respostas e reclamações (ex: data)

#### **Models**
- **Users**: Usuário, tipos de usuário, cadastros, imagem, documentação
- **Events**: Evento, endereço, espaço e imagem
- **FAQ**: Perguntas, respostas, reclamações

#### **UEFSevents**
- **urls**: Contém links do site, paths
- **settings**: Contém templates, frameworks, apps

## 🐳 Guia de Instalação com Docker

### Pré-requisitos
- Docker
- Docker Compose

### 1. Comandos para Buildar o Projeto

Esses comandos devem ser executados **uma única vez** ou sempre que fizerem alterações no `Dockerfile` ou nas dependências do projeto (`requirements.txt`).

```bash
# Acesse a pasta raiz do projeto
cd caminho/para/seu/projeto

# Verifique se o Docker está funcionando corretamente
docker --version
docker compose version

# Builda as imagens dos containers
docker compose build
```

### 2. Comandos para Rodar os Containers

```bash
# Subir os containers e deixar rodando no terminal
docker compose up

# Ou rodar em segundo plano (modo detached)
docker compose up -d
```

### 3. Comandos Pós-Deploy

Execute estes comandos **dentro do container Django**:

```bash
# Acessar o container do Django
docker exec -it django-docker bash

# Aplicar migrações do banco de dados
python manage.py migrate

# Criar um superusuário
python manage.py createsuperuser
```

### 4. Comandos para Parar e Limpar os Containers

```bash
# Parar os containers (sem apagar os dados)
docker compose down

# Parar e remover os volumes (apaga os dados do banco)
docker compose down -v
```

## 🚀 Instalação Tradicional (sem Docker)

### Pré-requisitos
- Python 3.8+
- pip

### Passos de Instalação

1. **Clone o repositório**
```bash
git clone <url-do-repositorio>
cd sistema-gerenciamento-eventos
```

2. **Crie um ambiente virtual**
```bash
python -m venv venv
source venv/bin/activate  # No Windows: venv\Scripts\activate
```

3. **Instale as dependências**
```bash
pip install -r requirements.txt
```

4. **Execute as migrações**
```bash
python manage.py migrate
```

5. **Crie um superusuário**
```bash
python manage.py createsuperuser
```

6. **Execute o servidor**
```bash
python manage.py runserver
```

## 🧪 Testes

Para executar os testes do sistema:

```bash
# Com Docker
docker exec -it django-docker python manage.py test

# Sem Docker
python manage.py test
```

## 📱 Uso do Sistema

1. Acesse `http://localhost:8000` (ou a porta configurada)
2. Faça login ou crie uma conta
3. Navegue pelos eventos disponíveis no calendário
4. Use os filtros para encontrar eventos específicos
5. Cadastre novos eventos (apenas usuários autenticados)
6. Participe do sistema de FAQ para tirar dúvidas

## 🛠️ Tecnologias Utilizadas

- **Backend**: Django
- **Frontend**: Flutter
- **Banco de Dados**: PostgreSQL (via Docker) ou SQLite (desenvolvimento)
- **Containerização**: Docker & Docker Compose
- **Outras**: Consulte `requirements.txt` para lista completa
