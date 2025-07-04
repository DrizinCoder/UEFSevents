//==============================EVENT SEARCH================================

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:viveri/bottom_nav_bar.dart';
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

    );
  }
}

//============================FIM DO CÓDIGO DE INDEPENÊNCIA==================================================================
bool limit = false;

class CreateFavorite extends StatefulWidget {
  const CreateFavorite({super.key});

  @override
  State<CreateFavorite> createState() => _CreateFavorite();
}

class _CreateFavorite extends State<CreateFavorite>  with SingleTickerProviderStateMixin {
  late final TabController _tc;

  //final CreateFavorite store = CreateFavorite(
  //repository: EventRepository(client: HttpClient()),
  //);
  List<dynamic> evnts = [];
  List<dynamic> space = [];


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

  @override
  void initState() {
    super.initState();
    // page = 1;
    _tc = TabController(length: 2, vsync: this);
    _tc.addListener(() {
      if (!_tc.indexIsChanging) {
       if(_tc.index == 0){
         create = 'favorito';
       }
       if(_tc.index == 1){
         create = 'criado';
       }
        setState(() {});
      }
    });

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
    return StatefulBuilder(
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
              itemCount: items.length,
              //store.state.value.length,
              itemBuilder: (_, index) {
                // print(next);
                final item = items[index];
                return ListTile(
                  title: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print(item);
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 6, right: 6),
                              height: 70,
                              width: 80,
                              color: Color.fromRGBO(47, 69, 56, 0.3),
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
                                  child: Column(children: [
                                    Text('festa da salsicha $item'),
                                    Text('01/04 - 02/04'),
                                    Text('15:30 - 00:00'),
                                  ]
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
                  create = '$create + $create';
                 // create = !create;
                  print(create);
                  //  print(create);
                 setState(() {});
                 print(create);
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
            tabs: [
              Tab(child: Text('Favoritados')),
              Tab(child: Text('Criados')),
            ],
          ),

          backgroundColor: Color.fromRGBO(
            88,
            108,
            97,
            1,
          ), // FF = opacidade 100%
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
            if(_tc.index == 1)
              InkWell(
                onTap: () { /* criar evento */ },
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
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _tc.index != 1 ? const CustomBottomNavBar(currentIndex: 1) : null,
    );
  }
}

//==========================================================================
