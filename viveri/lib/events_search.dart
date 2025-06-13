//==============================EVENT SEARCH================================

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/repositories/event_repositories.dart';
import 'package:viveri/events/pages/home/stores/event_store.dart';

//   ATENÇÃO! O TRECHO DE CÓDIGO COMENTADO ABAIXO TORNA ESTA TELA INDEPENDENTE DE TODOS OS OUTROS ARQUIVOS PARA FINS DE TESTE.
//   SE TIVER INTERESSADO EM TESTAR, BASTA RETIRAR DE COMENTÁRIO E RODAR NO TERMINAL "flutter run lib/event_search.dart"

void main() {
  runApp(const Testando());
}

class Testando extends StatelessWidget {
  const Testando({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const EventSearch(title: 'testando preferencias'),
    );
  }
}

//============================FIM DO CÓDIGO DE INDEPENÊNCIA==================================================================

class EventSearch extends StatefulWidget {
  const EventSearch({super.key, required this.title});

  final String title;

  @override
  State<EventSearch> createState() => _EventSearch();
}

class _EventSearch extends State<EventSearch> {
  final EventStore store = EventStore(
    repository: EventRepository(client: HttpClient()),
  );
  List<dynamic> evnts = [];
  List<dynamic> space = [];
  bool pesquisando = false;
  // ignore: non_constant_identifier_names
  String result_tabs = '';
  List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59",
    "60",
    "61",
    "62",
    "63",
    "64",
    "65",
    "66",
    "67",
    "68",
    "69",
    "70",
    "71",
    "72",
    "73",
    "74",
    "75",
    "76",
    "77",
    "78",
    "79",
    "80",
  ];
  late List<bool> selected;

  void _openBottomSheet(BuildContext context) {
    int counter = 0;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(88, 108, 97, 0.8),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              //decoration: BoxDecoration(
              //color: Color.fromRGBO(88, 108, 97, 0.8),
              // ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: width,
              height: height * 0.7,
              //padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 10,
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Categorias: $counter',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(244, 177, 52, 1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ver mais >",
                          style: TextStyle(
                            color: Color.fromRGBO(191, 205, 189, 1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Comodidades:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(244, 177, 52, 1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Text('comorbidade'),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(191, 205, 189, 1),
                        ),
                        height: 32,
                        width: 40,
                        child: InkWell(onTap: () {}),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromRGBO(191, 205, 189, 1),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Hello world"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    selected = List.generate(items.length, (index) => false);
    // store.getEvents();
  }

  //MÉTODO TABBAR TELA INDIVIDUAL----------------------------------------------------------------------------------------------
  Widget conteudoDasAbas(String tipoAba) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<dynamic> listaTela = [];
    if (tipoAba == 'evnts') {
      store.getEvents();

      listaTela = items;
      result_tabs = 'eventos';
    } else {
      listaTela = [];
      result_tabs = 'space';
    }
    return SizedBox(
      height: height,
      width: width,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(212, 224, 212, 1),
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 3, right: 3),
                  child: Container(
                    color: Color.fromRGBO(40, 64, 23, 0.14),
                    height: 35,
                    child: TextField(
                      onTap: () {
                        setState(() {
                          pesquisando = true;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(1),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons_bruno/search.png',
                            height: 15,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Padding(
              //padding: EdgeInsets.only(right: 2),
              // child:
              !pesquisando
                  ? InkWell(
                    onTap: () {
                      _openBottomSheet(context);
                    },
                    child: Image.asset(
                      'assets/icons_bruno/filtros.png',
                      width: 35,
                      height: 35,
                    ),
                  )
                  : TextButton(
                    onPressed: () {
                      setState(() {
                        pesquisando = !pesquisando;
                      });
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Color.fromRGBO(244, 177, 52, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),

              //)
            ],
          ),
          backgroundColor: Color.fromRGBO(88, 108, 97, 1),
        ),

        //=============================        LIST VIEW      ===================================================
        body: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const CircularProgressIndicator();
            }
            if (store.erro.value.isNotEmpty) {
              return Center(child: Text(store.erro.value));
            }
            if (store.state.value.isEmpty) {
              return const Center(child: Text('Nenhum evento na lista'));
            } else {
              return
              //SingleChildScrollView(
              //  scrollDirection: Axis.vertical,
              //child:
              listaTela.isEmpty
                  ? // Align(
                  //alignment: Alignment.bottomLeft,
                  //child:
                  SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sem resultados!',
                          style: TextStyle(
                            color: Color.fromRGBO(40, 64, 23, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),

                        Flexible(child: SizedBox(height: 20)),

                        Text(
                          'Não encontramos eventos ',
                          style: TextStyle(
                            color: Color.fromRGBO(40, 64, 23, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),

                        Text(
                          'com filtros aplicados!',
                          style: TextStyle(
                            color: Color.fromRGBO(40, 64, 23, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Flexible(child: SizedBox(height: 40)),
                        Material(
                          color: Color.fromRGBO(
                            47,
                            69,
                            56,
                            1,
                          ), // cor de fundo fixa
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            // autofocus: true,
                            hoverColor: Color.fromRGBO(74, 109, 88, 1),
                            // focusColor: Color.fromRGBO(47, 69, 56, 1),
                            borderRadius: BorderRadius.circular(8),
                            splashColor: Color.fromRGBO(
                              105,
                              154,
                              126,
                              1,
                            ), // cor do “ripple”
                            //  highlightColor: Color.fromRGBO(195, 130, 10, 1),    // cor de destaque quando pressionado
                            onTap: () {
                              print('hecho');
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              child: Text(
                                'Limpar Filtros',
                                style: TextStyle(
                                  color: Color.fromRGBO(244, 177, 52, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      // ),
                    ),
                  )
                  : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            result_tabs,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder:
                              (context, index) => Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                                indent: 90,
                                endIndent: 90,
                              ),
                          itemCount: store.state.value.length,
                          itemBuilder: (_, index) {
                            final item = store.state.value[index];
                            return ListTile(
                              //leading: Center(child: Icon(Icons.star)),
                              title: Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                          ),
                                          height: 70,
                                          width: 80,
                                          color: Color.fromRGBO(
                                            47,
                                            69,
                                            56,
                                            0.3,
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
                                            padding: EdgeInsets.only(
                                              left: 3,
                                              right: 3,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [Text(item.title)],
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
                                                selected[index] =
                                                    !selected[index];
                                                //int count = selected.where((element) => element).length;
                                                //if (count > 2) {
                                                //  selected[index] = false;
                                                // }
                                                setState(() {});
                                                //   print('Container clicado!');
                                              },
                                              child: Image.asset(
                                                selected[index]
                                                    ? 'assets/icons_bruno/heart_shine.png'
                                                    : 'assets/icons_bruno/heart.png',
                                                height: 50,
                                                width: 50,
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
                      ),
                    ],
                  );
            }
          },
        ),
        //  ),
      ),
    );
  }

  //FIM DO MÉTODO DE TABBAR----------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2, // número de abas
      child: Scaffold(
        backgroundColor: Color.fromRGBO(212, 224, 212, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Color.fromRGBO(47, 69, 56, 1),
                child: IconButton(
                  onPressed: () {},
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
            backgroundColor: Color.fromRGBO(
              88,
              108,
              97,
              1,
            ), // FF = opacidade 100%
            toolbarHeight: 100,

            bottom: TabBar(
              labelColor: Color.fromRGBO(244, 177, 52, 1),
              dividerColor: Color(0xFF284017),
              indicatorColor: Color.fromRGBO(244, 177, 52, 1),
              unselectedLabelColor: Color.fromRGBO(40, 64, 23, 1),
              tabs: [Tab(child: Text('Eventos')), Tab(child: Text('Locais'))],
            ),
          ),
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
                  children: [
                    conteudoDasAbas("evnts"),
                    conteudoDasAbas("space"),

                    //============================================FIM DE EVENTOS=================================================================

                    //Text('hello world'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//==========================================================================
