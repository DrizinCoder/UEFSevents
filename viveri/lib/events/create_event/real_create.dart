//==============================EVENT SEARCH================================

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:viveri/events/data/http/http_client.dart';
//import 'package:viveri/events/data/repositories/event_repositories.dart';
//import 'package:viveri/events/pages/home/stores/event_store.dart';

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
      home: const CreateEvent(title: 'testando preferencias'),
    );
  }
}

//============================FIM DO CÓDIGO DE INDEPENÊNCIA==================================================================
bool limit = false;

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key, required this.title});

  final String title;

  @override
  State<CreateEvent> createState() => _CreateEvent();
}

class _CreateEvent extends State<CreateEvent> {
  //final CreateEvent store = CreateEvent(
  //repository: EventRepository(client: HttpClient()),
  //);
  //String next = '';
  // final ScrollController _scrollController = ScrollController();
  String result_tabs = '';
  int tela = 1;
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
    //  _scrollController.addListener(_verificaScroll);
    selected = List.generate(10, (index) => false);
    // store.getEvents();
  }

  Widget PrimeiraTela(String texto) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StatefulBuilder(
      builder: (context, sa) {
        return Expanded(
          // flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              //  height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(191, 205, 189, 0.6),
                borderRadius: BorderRadius.circular(6),
              ),
              //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10 ),
              child: SizedBox(
                width: width,
                height: height,
                child: ListView(
                  //shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Nome do evento:',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 29,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: 1,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(191, 205, 189, 1),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 40,
                                    children: [
                                      SizedBox(),
                                      Text(
                                        'Início:',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25,
                                        ),
                                      ),
                                      Text(
                                        'Fim:',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 7,
                                  children: [
                                    Text(
                                      'Data',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        //  right: 15
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            bottom: 1,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                            191,
                                            205,
                                            189,
                                            1,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        // right: 8
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            bottom: 1,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                            191,
                                            205,
                                            189,
                                            1,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 7,

                                  children: [
                                    Text(
                                      'Horário',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),

                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            bottom: 1,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                            191,
                                            205,
                                            189,
                                            1,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 10,
                                            bottom: 1,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                            191,
                                            205,
                                            189,
                                            1,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),

                            child: Row(
                              children: [
                                Expanded(
                                  //  flex:1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 28,
                                      right: 5,
                                    ),
                                    child: Text(
                                      'Evento Privado',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            'Sim',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          left: 20,
                                        ),
                                        child: Text(
                                          'Não',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            //spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                //flex: 1,
                                child: Text(
                                  'Tipo de Evento:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        bottom: 1,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Color.fromRGBO(
                                        191,
                                        205,
                                        189,
                                        1,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                //flex: 1,
                                child: Text(
                                  'Frequência:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Flexible(
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 1,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(191, 205, 189, 1),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                //flex: 1,
                                child: Text(
                                  'Faixa Etária:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Flexible(
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 1,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(191, 205, 189, 1),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Descrição evento:',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 20,
                            right: 20,
                          ),
                          child: TextField(
                            maxLength: 250, // limite de 10 caracteres
                            minLines: 5, // número mínimo de linhas
                            maxLines: 6,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                top: 10,
                                bottom: 1,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(191, 205, 189, 1),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget SegundaTela(String texto) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StatefulBuilder(
      builder: (context, sa) {
        return Expanded(
          // flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: width,
              height: height,
              child: ListView(
                //shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Sobre o local:',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 29,
                      ),
                    ),
                  ),
                  Container(
                    //  height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(191, 205, 189, 0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10 ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Nome do local:',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: 1,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(191, 205, 189, 1),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                //flex: 1,
                                child: Text(
                                  'CEP:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:3,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 1,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(191, 205, 189, 1),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                //   ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Endereço completo:',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: 1,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(191, 205, 189, 1),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Capacidade Máxima:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                // flex:2,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 1,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(191, 205, 189, 1),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                //   ),
                              ),
                            ],
                          ),
                        ),


                          Align(alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:5,left: 20, right: 5),
                              child: Text(
                                'Comodidades',
                                maxLines: 2,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),


                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left:30),

                            child: Row(
                           //   mainAxisAlignment: MainAxisAlignment.center,
                            //  spacing: 20,
                              children: [
                                Expanded(
                                    flex:3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                     // left: 10,
                                      top: 28,
                                      right: 5,
                                    ),
                                    child: Text(
                                      'Estacionamento',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Column(
                                   //   mainAxisAlignment:
                                     //     MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            'Sim',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          left: 20,
                                        ),
                                        child: Text(
                                          'Não',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left:30),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      // left: 10,
                                      top: 28,
                                      right: 5,
                                    ),
                                    child: Text(
                                      'Bufê',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Column(
                                      //   mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            'Sim',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          left: 20,
                                        ),
                                        child: Text(
                                          'Não',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left:30, bottom: 10),

                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //  spacing: 20,
                              children: [
                                Expanded(
                                  flex:3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      // left: 10,
                                      top: 28,
                                      right: 5,
                                    ),
                                    child: Text(
                                      'Quarto',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Column(
                                      //   mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            'Sim',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          left: 20,
                                        ),
                                        child: Text(
                                          'Não',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget TerceiraTela(String texto) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StatefulBuilder(
      builder: (context, sa) {
        return Expanded(
          // flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: width,
              height: height,
              child: ListView(
                //shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Operacional:',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 29,
                      ),
                    ),
                  ),
                  Container(
                    //  height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(191, 205, 189, 0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10 ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal:20),

                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //  spacing: 20,
                              children: [
                                Expanded(
                                  flex:3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      // left: 10,
                                      top: 28,
                                      right: 5,
                                    ),
                                    child: Text(
                                      'Evento gratuito',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Column(
                                      //   mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            'Sim',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 8.0,
                                          left: 20,
                                        ),
                                        child: Text(
                                          'Não',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ),
                                            radius: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Nome do ingresso:',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: 1,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(191, 205, 189, 1),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                //flex: 1,
                                child: Text(
                                  'Valor:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:1,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 1,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(191, 205, 189, 1),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                //   ),
                              ),
                              Flexible(
                                //flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text(
                                    'Taxa:',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:1,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 1,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color.fromRGBO(191, 205, 189, 1),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                //   ),
                              ),
                            ],
                          ),
                        ),
                        Align(alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                             top: 8,
                             // left: 20,
                             right: 20,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                //Navigator.of(context).pop();
                                // aplicar filtro…
                              },
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                //minimumSize: Size(50, 50), // largura mínima 150, altura 50
                                // ou:
                                minimumSize: Size(60, 48),      // botão largaço, altura 48

                              //  fixedSize: Size(80, 50), // força exatamente 150×50
                                foregroundColor: Color(0xFFF4B134),
                                backgroundColor: Color(0xFF3B4A3F), // amarelo do texto
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                            //    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,              // conteúdo só ocupa o espaço que precisa

                                mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Adicionar',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                    Icon(Icons.add),
                                  ],
                                ),
                              ),
                            ),
                          ),




                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 4.0,top:50.0),
                    child: Text(
                      'Imagens:',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 29,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(191, 205, 189, 0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              spacing: 5,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  //flex: 1,
                                  child: Text(
                                    'Local:',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 1,),
                                Expanded(
                                  flex:1,
                                  //  child: Padding(
                                  //padding: const EdgeInsets.only(left:50),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'adicionar link',
                                      //hintText: 'adicionar link',
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        bottom: 1,
                                      ),

                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Color.fromRGBO(191, 205, 189, 1),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),

                                  ),
                                  //   ),
                                ),
                              ],
                            ),
                          ),Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: Row(
                              spacing: 5,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  //flex: 1,
                                  child: Text(
                                    'Estabelecimento:',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 1,),
                                Expanded(
                                  flex:1,
                                  //  child: Padding(
                                  //padding: const EdgeInsets.only(left:50),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'adicionar link',
                                      //hintText: 'adicionar link',
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        bottom: 1,
                                      ),

                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Color.fromRGBO(191, 205, 189, 1),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),

                                  ),
                                  //   ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        );
      },
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
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(12),
            child: CircleAvatar(
              // radius: 20,
              backgroundColor: Color.fromRGBO(47, 69, 56, 1),
              child: IconButton(
                onPressed: () {
                  if(tela>1){
                    tela--;
                    setState((){});
                  }

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
          title: Text(
            'Criar Evento',
            style: TextStyle(
              color: Color.fromRGBO(244, 177, 52, 1),
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Color.fromRGBO(
            88,
            108,
            97,
            1,
          ), // FF = opacidade 100%
          toolbarHeight: 90,
        ),
        //=================================== BODY =====================================================================
        body: Container(
          color: Color.fromRGBO(212, 224, 212, 1),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 12,
                color: Color.fromRGBO(191, 205, 189, 1),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(color: Color.fromRGBO(244, 177, 52, 1)),
                    ),
                    Flexible(
                      child: Container(
                        color:tela<2?
                            Colors
                                .transparent:Color.fromRGBO(244, 177, 52, 1), //Color.fromRGBO(244, 177, 52, 1),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color:tela<2?
                        Colors
                            .transparent:Color.fromRGBO(244, 177, 52, 1), //Color.fromRGBO(244, 177, 52, 1),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color:tela<3?
                        Colors
                            .transparent:Color.fromRGBO(244, 177, 52, 1), //Color.fromRGBO(244, 177, 52, 1),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color:tela<3?
                        Colors
                            .transparent:Color.fromRGBO(244, 177, 52, 1), //Color.fromRGBO(244, 177, 52, 1),
                      ),
                    ),
                  ],
                ),
              ),
              if(tela == 1) PrimeiraTela('texto'),
              if(tela == 2) SegundaTela('texto'),
              if(tela == 3) TerceiraTela('texto'),


    Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if(tela<3){
                    tela++;
                    setState(() {});
                    }
                    //Navigator.of(context).pop();
                    // aplicar filtro…
                  },
                  style: ElevatedButton.styleFrom(
                    //minimumSize: Size(50, 50), // largura mínima 150, altura 50
                    // ou:
                    fixedSize: Size(150, 50), // força exatamente 150×50
                    foregroundColor: Color(0xFFF4B134),
                    backgroundColor: Color(0xFF3B4A3F), // amarelo do texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    tela!=3?'Próximo':'Criar',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
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
