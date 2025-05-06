# -Sistema-de-Gerenciamento-de-Eventos
 Sistema de Gerenciamento de  Eventos

-> Requisitos do sistema

    1-Autenticação e Segurança 
        ○ Apenas usuários registrados podem cadastrar,editar e excluir os próprios eventos; 
        ○ Outros usuários precisarão estar logados para acessarem as informações dos eventos já cadastrados; 
        ○ Usuários podem ser do tipo Consumidor e Organizador;
        ○ Usuários do tipo organizadores de eventos podem ser do tipo pessoa física ou jurídica:
            -Se jurídica, deve receber um selo azul caso tenha enviado à  plataforma documentação comprovando que é o organizador do evento ou dono do espaço; 

    2-Sistema de denúncia;  
        ○ Em caso de muitas denúncias o local ou organização devem ser banidas do aplicativo 

    3-Gestão de Eventos  
        ○ Usuários comuns devem ser capazes de visualizar todos os eventos cadastrados em um “calendário”;
        ○ Eventos devem ser categorizados e os usuários devem poder filtrá-los por categoria; 
        ○ Opção para visualização de eventos próximos; 
        ○ Detalhes para cada evento, exibindo informações como data, hora, localização, descrição e hiperlinks para mais detalhes;  
        ○ Apenas usuários autenticados podem cadastrar novos eventos 

    4-Sistema de notificação : 
        ○ Criação/Atualização de evento de interesse do usuário naquela região; 
        ○ Quando o evento estiver próximo (1 dia antes, 2h antes);

    5- FAQ e Interatividade 
        ○ Sistema de perguntas e respostas; 
        ○ Upvotes/downvotes para destacar perguntas relevantes; 
        ○ Notificações para os usuários quando suas perguntas forem respondidas; 

    6- Configurações do APP: 
        ○ Modo escuro/claro ;
        ○ Notificação on/off;

-> Detalhamento do software(Módulos e funções)

    -migrations:
        ○ Migrações do banco de dados;
    
    -serializers:
        ○ Users:
           Conversão com validação de tipo de usuário;
        ○ Events:
            Conversão de eventos,espaços,endereços e imagens;
        ○ FAQ:
            Conversão com verificação se a pergunta existe,e com predefinição de data;

    -apps:
        ○ apps do módulo;

    -admin:
        ○ visão do admin do site;

    -views:
        ○ Users:
            CRUD,setar filtros,autenticação,verificação se é ativo;
        ○ Events:
            CRUD,setar filtros;
        ○ FAQ:
            CRUD,setar filtros;

    -forms:
        ○ Events:
            Formulário html para imagens,eventos,endereços e espaços;

    -filters:
        ○ Events:
            Filtros em cima dos atributos de imagens,eventos,endereços e espaços existentes (ex: categoria,rua,acessibilidade);
        ○ FAQ:
            Filtros em cima dos atributos de perguntas,respostas e reclamações (ex: data);

    -models:
        ○ Users:    
            Usuário,tipos de usuário,cadastros,imagem,documentação;
        ○ Events:
            Evento,endereço,espaço e imagem;
        ○ FAQ:
            Perguntas,respostas,reclamações;

    -templates:
        ○ Events:
            Telas do CRUD
    
    - UEFSevents:
        ○ urls- Contém links do site,paths;
        ○ settings- Contém templates,frameworks,apps;

->Instalação,uso e testes

    -manage.py
        ○ Criar aplicativo
        ○ Rodar o servidor

    -requirements.txt: 
        ○ Bibliotecas utilizadas

 <!--
 contendo, no mínimo:  

○ Requisitos FEITO
 
○ Detalhamento dos software usados no trabalho, incluindo softwares 
básicos;  /Explicando os módulos e as funções  FEITO

○ Explicação das escolhas de decisão de projeto;  ? n sei se precisa

○ Descrição de instalação e uso do aplicativo;   FEITO +-
○ Descrição dos testes de funcionamento do sistema, bem como, análise 
dos resultados alcançados./como rodar o servidor de teste  -○  FEITO +-