//==============================EVENT SEARCH================================

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      home: const EventSearch(title: 'testando preferencias'),
    );
  }
}

//============================FIM DO CÓDIGO DE INDEPENÊNCIA==================================================================
bool limit = false;

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
  bool setedias = false;
  bool gratuitos = false;
  //String next = '';
  final ScrollController _scrollController = ScrollController();
  String result_tabs = '';
  List<String> items = ["1", "2", "3", "4", "5"];
  late List<bool> selected;
  List<bool> idxctg = List.filled(8, false);
  List<bool> idxcmdd = List.filled(6, false);
  String Mensagem = "sexrta feira";
  bool preco = false;
  int page = 1;

  void _verificaScroll() async {
    print(_scrollController);
    //  print('entrou em verifica scroll');
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (limit) {
        return;
      }
      page++;
      await store.getEvents(page);
      evnts += store.state.value;
      selected += List.generate(10, (index) => false);
     // setState(() {});
      print(_scrollController);
    }
  }

  @override
  void initState() {
    super.initState();
    // page = 1;
    _scrollController.addListener(_verificaScroll);
    selected = List.generate(10, (index) => false);

    // store.getEvents();
  }

  void _abrirpreco(BuildContext context) async {
    showDialog(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder: (context, setModalState) {
              return Dialog(
                backgroundColor: Color(0xFFD7E3D9), // Verde claro do mock
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 340, // largura fixa do seu mock
                  height: 479, // altura fixa do seu mock
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // 1) TÍTULO
                      Text(
                        'Preço',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 205, 189, 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          preco = false;
                                          setModalState(() {});
                                        },
                                        child: Text(
                                          'Gratuito',
                                          style: TextStyle(
                                            color:
                                                !preco
                                                    ? Color.fromRGBO(
                                                      10,
                                                      10,
                                                      58,
                                                      1,
                                                    )
                                                    : Color.fromRGBO(
                                                      10,
                                                      10,
                                                      58,
                                                      0.5,
                                                    ),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: Divider(height: 32.0)),
                                  ],
                                ),

                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          preco = true;
                                          setModalState(() {});
                                        },
                                        child: Text(
                                          'Pago',
                                          style: TextStyle(
                                            color:
                                                preco
                                                    ? Color.fromRGBO(
                                                      10,
                                                      10,
                                                      58,
                                                      1,
                                                    )
                                                    : Color.fromRGBO(
                                                      10,
                                                      10,
                                                      58,
                                                      0.5,
                                                    ),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: Divider(height: 32.0)),
                                  ],
                                ),

                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(1),
                                            border: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            labelText: preco ? 'Até:' : null,
                                          ),
                                          enabled: preco,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Expanded(child: Divider(height: 6.0)),
                                Visibility(
                                  visible: preco,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: Divider(height: 5.0)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 6) BOTÃO FILTRAR
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // aplicar filtro…
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFFF4B134),
                            backgroundColor: Color(
                              0xFF3B4A3F,
                            ), // amarelo do texto
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            'FILTRAR',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  void _abrirCalendario(BuildContext context) async {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: Color(0xFFD7E3D9), // Verde claro do mock
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: 340,
              height: 479,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // 1) TÍTULO
                  Text(
                    'Calendário',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(191, 205, 189, 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          currentDate: DateTime.now(),
                          onDateChanged: (d) {},
                          initialCalendarMode: DatePickerMode.day,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // aplicar filtro…
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFFF4B134),
                        backgroundColor: Color(0xFF3B4A3F), // amarelo do texto
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'FILTRAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    int counter = 0;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.95,
              expand: false,
              builder: (_, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(88, 108, 97, 0.8),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: ListView(
                    //padding: EdgeInsets.symmetric(vertical: 5),
                    controller: scrollController,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 60, // comprimento fixo
                          height: 6, // espessura
                          decoration: BoxDecoration(
                            color: Color(0xFF314026),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      Text(
                        'Categorias: $counter',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(244, 177, 52, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true, // <- importante
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 130,
                          //crossAxisCount: 4, // 2 colunas
                          childAspectRatio: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color:
                                  !idxctg[index]
                                      ? Color.fromRGBO(191, 205, 189, 1)
                                      : Color.fromRGBO(249, 208, 90, 1),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setModalState(() {
                                  Mensagem = "FOdase";
                                  idxctg[index] = !idxctg[index];
                                });
                              },
                              child: Text("Hello, $Mensagem"),
                            ),
                          );
                        },
                      ),

                      Align(
                        alignment: Alignment.topCenter,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Ver mais >",
                            style: TextStyle(
                              color: Color.fromRGBO(191, 205, 189, 1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Comodidades:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(244, 177, 52, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),

                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true, // <- importante
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 160,
                                //crossAxisCount: 3, // 2 colunas
                                childAspectRatio: 3,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                              ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Row(
                              spacing: 2,
                              mainAxisSize: MainAxisSize.max,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //spacing: 5,
                              children: [
                                //Spacer(flex: 1,),
                                Expanded(
                                  child: Text(
                                    'dsadsada',
                                    style: TextStyle(
                                      color: Color.fromRGBO(252, 239, 237, 1),
                                    ),
                                  ),
                                ),
                                //  Spacer(flex: 1,),
                                Flexible(
                                  child: Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          !idxcmdd[index]
                                              ? Color.fromRGBO(191, 205, 189, 1)
                                              : Color.fromRGBO(249, 208, 90, 1),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setModalState(() {
                                          idxcmdd[index] = !idxcmdd[index];
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                //Spacer(flex: 1,),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // spacing: 10,
                        children: [
                          Spacer(flex: 3),
                          Text(
                            "Filtrar por:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(252, 239, 237, 1),
                            ),
                          ),
                          Spacer(flex: 1),
                          ElevatedButton(
                            onPressed: () {
                              _abrirCalendario(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Color.fromRGBO(191, 205, 189, 1),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Data",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color.fromRGBO(40, 64, 23, 1),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromRGBO(40, 64, 23, 1),
                                ),
                              ],
                            ),
                          ),
                          Spacer(flex: 1),

                          ElevatedButton(
                            onPressed: () {
                              _abrirpreco(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Color.fromRGBO(191, 205, 189, 1),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Preço",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color.fromRGBO(40, 64, 23, 1),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromRGBO(40, 64, 23, 1),
                                ),
                              ],
                            ),
                          ),
                          Spacer(flex: 3),
                        ],
                      ),
                      Text(
                        'Endereço:',
                        style: TextStyle(
                          color: Color.fromRGBO(244, 177, 52, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 40,
                          width: 250,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fillColor: Color.fromRGBO(191, 205, 189, 1),
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        spacing: 30,
                        children: [
                          Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Eventos nos proximos 7 dias',
                                style: TextStyle(
                                  color: Color.fromRGBO(233, 245, 221, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Apenas eventos gratuitos:',
                                style: TextStyle(
                                  color: Color.fromRGBO(233, 245, 221, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            spacing: 10,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    setModalState(() {
                                      setedias = !setedias;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Color.fromRGBO(
                                            47,
                                            69,
                                            56,
                                            0.5,
                                          ),
                                        ),
                                        width: 80,
                                        height: 32,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  !setedias
                                                      ? Color.fromRGBO(
                                                        249,
                                                        208,
                                                        90,
                                                        1,
                                                      )
                                                      : Colors.transparent,
                                            ),
                                            width: 40,
                                            height: 32,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  setedias
                                                      ? Color.fromRGBO(
                                                        249,
                                                        208,
                                                        90,
                                                        1,
                                                      )
                                                      : Colors.transparent,
                                            ),
                                            width: 40,
                                            height: 32,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    setModalState(() {
                                      gratuitos = !gratuitos;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Color.fromRGBO(
                                            47,
                                            69,
                                            56,
                                            0.5,
                                          ),
                                        ),
                                        width: 80,
                                        height: 32,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  !gratuitos
                                                      ? Color.fromRGBO(
                                                        249,
                                                        208,
                                                        90,
                                                        1,
                                                      )
                                                      : Colors.transparent,
                                            ),
                                            width: 40,
                                            height: 32,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  gratuitos
                                                      ? Color.fromRGBO(
                                                        249,
                                                        208,
                                                        90,
                                                        1,
                                                      )
                                                      : Colors.transparent,
                                            ),
                                            width: 40,
                                            height: 32,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(
                                Size(150, 50),
                              ), // largura, altura
                              backgroundColor: WidgetStateProperty.all(
                                Color.fromRGBO(47, 69, 56, 1),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Limpar filtros',
                              style: TextStyle(
                                color: Color.fromRGBO(244, 177, 52, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Color.fromRGBO(47, 69, 56, 1),
                              ),
                              minimumSize: WidgetStateProperty.all(
                                Size(150, 50),
                              ), // largura, altura
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Aplicar',
                              style: TextStyle(
                                color: Color.fromRGBO(244, 177, 52, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
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
      },
    );
  }

  //MÉTODO TABBAR TELA INDIVIDUAL----------------------------------------------------------------------------------------------
  Widget conteudoDasAbas(String tipoAba) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<dynamic> listaTela = [];
    if (tipoAba == 'evnts') {
      print(page);
      store.getEvents(page);

      listaTela = items;
      result_tabs = 'eventos';
    } else {
      listaTela = [];
      result_tabs = 'space';
    }
    return StatefulBuilder(
        builder: (context, sa) {
          return
       SizedBox(
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
                          sa(() {
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
                        sa(() {
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
                if (evnts.length < 1) evnts = store.state.value;
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
                                //    print('hecho');
                                store.state.value.clear();
                                evnts.clear();
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
                            controller: _scrollController,
                            separatorBuilder:
                                (context, index) => Divider(
                                  color: Colors.grey.shade400,
                                  thickness: 1,
                                  indent: 90,
                                  endIndent: 90,
                                ),
                            itemCount: evnts.length,
                            //store.state.value.length,
                            itemBuilder: (_, index) {
                              // print(next);
                              final item = evnts[index];
                              return ListTile(
                                title: Center(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        print(item.id);
                                      },
                                      child: Row(
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

                                                  print('favoritado o evento de id ${item.id}');
                                                  selected[index] =
                                                      !selected[index];
                                                  sa(() {});
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
      );}
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
