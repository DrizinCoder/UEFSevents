//==============================EVENT SEARCH================================

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:viveri/bottom_nav_bar.dart';
import 'package:viveri/events/telas_criar_evento/real_create.dart';
import 'package:viveri/home_page.dart';

import '../data/http/http_client.dart';
import '../data/model/event_model.dart';
import '../data/model/image_model.dart';
import '../data/repositories/event_repositories.dart';
import '../data/repositories/image_repositories.dart';
import '../evento_unico/evento_unico.dart';
//import 'package:viveri/events/data/http/http_client.dart';
//import 'package:viveri/events/data/repositories/event_repositories.dart';
//import 'package:viveri/events/pages/home/stores/event_store.dart';

//   ATENÇÃO! O TRECHO DE CÓDIGO COMENTADO ABAIXO TORNA ESTA TELA INDEPENDENTE DE TODOS OS OUTROS ARQUIVOS PARA FINS DE TESTE.
//   SE TIVER INTERESSADO EM TESTAR, BASTA RETIRAR DE COMENTÁRIO E RODAR NO TERMINAL "flutter run lib/event_search.dart"

String create = 'faki';

void main() {
  runApp(const Testando());
}

class Testando extends StatelessWidget {
  const Testando({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 1) Delegates para tradução de Material, Widgets e Cupertino
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // 2) Definição dos idiomas que o app vai suportar
      supportedLocales: [
        const Locale('pt', 'BR'),
        // você pode adicionar outros, ex: const Locale('en', 'US')
      ],

      // 3) (Opcional) força o uso do português brasileiro sempre
      // locale: const Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const CreateFavorite(
        userData: {'bruno': 'bruno'},
        accessToken:  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUzOTg0Njc1LCJpYXQiOjE3NTEzOTI2NzUsImp0aSI6IjE2NjRiYjdlOGVlZTQ1ODg5MzlmYWQzZjRlOTM4MjI5IiwidXNlcl9pZCI6MX0.KXaCfHzjRrpp9yP5aP059ySKSe7_kypxrFCZ3JxZ5Xk',
      ),
    );
  }
}

//============================FIM DO CÓDIGO DE INDEPENÊNCIA==================================================================
bool limit = false;

class CreateFavorite extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String accessToken;
  final int initialTab;
  const CreateFavorite({super.key,
    required this.accessToken,
    required this.userData,
    this.initialTab = 0,
  });

  @override
  State<CreateFavorite> createState() => _CreateFavorite();
}

class _CreateFavorite extends State<CreateFavorite>
    with SingleTickerProviderStateMixin {
  late final TabController _tc;

  //final CreateFavorite store = CreateFavorite(
  //repository: EventRepository(client: HttpClient()),
  //);
  List<dynamic> itns = [];
  String mensagem1 = 'Você não está inscrito em nenhum evento!';
  String mensagem2 = 'Mas nada o proibe de se inscrever em um evento, vamos, se inscreva!';
  //String next = '';
  // final ScrollController _scrollController = ScrollController();
  String result_tabs = '';
  List<String> items = ["1", "2", "3", "4", "5", '6', '7', '8', '9', '10'];
  late List<bool> selected;
  List<bool> idxctg = List.filled(8, false);
  List<bool> idxcmdd = List.filled(6, false);
  String Mensagem = "sexrta feira";
  bool preco = false;
  int page = 1;
var images = [];
// final EventModel event;

  Future<void> _loadData() async {
    final IHttpClient httpClient = HttpClient();
    final imageRepo = ImageRepository(client: httpClient);
    images = await imageRepo.searchImagesByEvent(
      itns.map((e) => e.id.toString()).toList(),
    );
    setState(() {
      //store.isLoading =true;
    });

  }
  void _verificaaba() async {
    if (!_tc.indexIsChanging) {
      if (_tc.index == 0) {
        //itns.clear();
        mensagem1 = 'Você não está inscrito em nenhum evento!';
        mensagem2 = 'Mas nada o proibe de se inscrever em um evento,\n vamos, se inscreva!';
        create = 'favorito';

        final IHttpClient client = HttpClient();
        final repo = EventRepository(client: client);
        try {
          final resultados = await repo.searchEventsByName(
            'participant_id=${widget.userData['id']}',
            page: 1,
          );
          // trate a lista de objetos EventModel...
          itns = resultados;
          await _loadData(); // carrega as imagens depois dos eventos
          setState(() {}); // atualiza a UI quando tudo estiver pronto
          // carrega as imagens depois dos eventos
          //print(itns);

          setState(() {});
          //print(' resultados sao $resultados');
        } catch (e) {
          print(e);
        }
      }
      setState(() {});

      if (_tc.index == 1) {
        mensagem1 = 'Não existem eventos criados!';
        mensagem2 = 'Mas nada o proibe de criar um evento agora,\n vamos, crie um evento!';
        create = 'criado';
        final IHttpClient client = HttpClient();
        final repo = EventRepository(client: client);
        try {
          final resultados = await repo.searchEventsByName(
            'creator=${widget.userData['id']}',
            page: 1,
          );
          // trate a lista de objetos EventModel...
          itns = resultados;
            await _loadData(); // carrega as imagens depois dos eventos
            setState(() {}); // atualiza a UI quando tudo estiver pronto
          // carrega as imagens depois dos eventos
          //print(itns);

          setState(() {});
          //print(' resultados sao $resultados');
        } catch (e) {
          print(e);
        }
      }
      setState(() {});
    }
}


  @override
  void initState() {
    super.initState();
    final IHttpClient client = HttpClient();
    final repo = EventRepository(client: client);

    repo
        .searchEventsByName('participant_id=${widget.userData['id']}', page: 1)
        .then((resultados) {
      itns = resultados;

      _loadData().then((_) {
        setState(() {}); // atualiza a UI quando tudo estiver pronto
      });
    }).catchError((e) {
      print(e);
    });
    // page = 1;
    _tc = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    _tc.addListener(() {_verificaaba();});

    selected = List.generate(10, (index) => false);

    // store.getEvents();
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  //MÉTODO TABBAR TELA INDIVIDUAL----------------------------------------------------------------------------------------------
  Widget conteudoDasAbas(bool fav) {
    //print("aaaaaa");
    //  print(create);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return itns.isEmpty
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                mensagem1,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                mensagem2,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            Image.asset('assets/icons_bruno/x_vermelho.png'),
          ],
        )
        : StatefulBuilder(
          builder: (context, sa) {
            return Container(
              color: Color.fromRGBO(212, 224, 212, 1),
              height: height,
              width: width,
              child: ListView.separated(
                // controller: _scrollController,
                separatorBuilder:
                    (context, index) => Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                      indent: 90,
                      endIndent: 90,
                    ),
                itemCount: itns.length,
                itemBuilder: (_, index) {
                  final item = itns[index];
                  final Map<int, ImageModel> thumbByEvent = {};

// Preenche o map: para cada imagem, guarda a primeira ocorrência por eventId
                  for (var img in images) {
                    thumbByEvent.putIfAbsent(img.events, () => img);
                  }
                  final ImageModel? img = thumbByEvent[item.id];

                  return ListTile(
                    title: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) =>  EventoUnico(
                                url: img?.url??'https://th.bing.com/th/id/R.65678b185f17e849fe120e31c0ce1652?rik=xJ9WYKXiy3k1gQ&pid=ImgRaw&r=0',
                                event: item,
                                accessToken: widget.accessToken,
                                userData: widget.userData,
                              )),
                            );
                          },
                          child: Row(
                            children: [
                              img==null?Container(
                             //   padding: EdgeInsets.only(left: 6, right: 6),
                                height: 70,
                                width: 80,
                                color: Color.fromRGBO(47, 69, 56, 0.3),
                              ):Container(
                             //       padding: EdgeInsets.only(left: 6, right: 6),
                                height: 70,
                                width: 80,
                                color: Color.fromRGBO(47, 69, 56, 0.3),
                                child: Image.network(
                                  img.url,
                                  width: 80,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // Flexible(
                              //   child: Image.asset(
                              //      items[index]["foto"],
                              //      width: 43,
                              //      height: 50,
                              //    ),
                              //    ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(item.title),
                                        Text(
                                          '${item.start_date.substring(8, 10)}/${item.start_date.substring(5, 7)}/${item.start_date.substring(0, 4)}'
                                              ' - '
                                              '${item.end_date.substring(8, 10)}/${item.end_date.substring(5, 7)}/${item.end_date.substring(0, 4)}',
                                        ),
                                      Text('${item.start_time.substring(0,5)}-${item.endtime.substring(0,5)}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      selected[index] = !selected[index];
                                      sa(() {});
                                    },
                                    child: Icon(
                                      size: 30,
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Text('hello world'),
                  );
                },
              ),
            );
          },
        );
  }

  //FIM DO MÉTODO DE TABBAR----------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final int currentTab = _tc.index;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(212, 224, 212, 1),
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            // radius: 20,
            backgroundColor: Color.fromRGBO(47, 69, 56, 1),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.chevron_left,
                color: Color.fromRGBO(244, 177, 52, 1),
                size: 32,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Eventos',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              width: 120,
              color: Color.fromRGBO(0, 0, 0, 0.9),
              height: 0.5,
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tc,
          padding: EdgeInsets.only(top: 0),
          // indicatorColor: Color.fromRGBO(244, 177, 52, 1),
          //   indicatorWeight: 3,
          labelColor: Color.fromRGBO(244, 177, 52, 1),
          dividerColor: Color(0xFF284017),
          indicatorColor: Color.fromRGBO(244, 177, 52, 1),
          unselectedLabelColor: Color.fromRGBO(40, 64, 23, 1),
          tabs: [Tab(child: Text('Inscritos')), Tab(child: Text('Criados'))],
        ),

        backgroundColor: Color.fromRGBO(88, 108, 97, 1), // FF = opacidade 100%
        toolbarHeight: 60,
      ),
      //=================================== BODY =====================================================================
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
              child:
              //=================================== TELAS TABBAR=====================================================================
              TabBarView(
                controller: _tc,
                children: [
                  conteudoDasAbas(true),
                  conteudoDasAbas(false),
                  //============================================FIM DE EVENTOS=================================================================

                  //Text('hello world'),
                ],
              ),
            ),
            if (_tc.index == 1)
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateEvent(
                        userData: widget.userData,
                        accessToken: widget.accessToken,
                      ),
                    ),
                  );
                  /* criar evento */
                },
                child: Container(
                  color: Color.fromRGBO(88, 108, 97, 1),
                  width: width,
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'Criar evento',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFF4B134),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar:
          _tc.index != 1 ? CustomBottomNavBar(
            currentIndex: 1, userData: widget.userData,
            accessToken: widget.accessToken,) : null,
    );
  }
}

//==========================================================================
