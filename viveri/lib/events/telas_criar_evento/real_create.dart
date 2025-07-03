//==============================EVENT SEARCH================================

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../data/http/http_client.dart';
import '../data/model/adress_model.dart';
import '../data/model/event_model.dart';
import '../data/model/space_model.dart';
import '../data/repositories/adress_repositories.dart';
import '../data/repositories/event_repositories.dart';
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
  // final ScrollController _scrollController = ScrollController();
  String result_tabs = '';
  int tela = 1;
  //late List<bool> selected;
//  int page = 1;

//===================EVENTOS====================================================
  String?
      nomeEvento,
      dataInicio,
      dataFinal,
      horaInicio,
      horaFinal,
      tipoEvento,
      frequencia,
      descriEvento,
      categoriaSelecionada;
  // vamos montar a lista de rótulos com base nas suas choices
  final Map<String, dynamic> _labels = {

  'FST': 'Festival',
  'PRT': 'Festa',
    'CLB': 'Celebração',
    'CRT': 'Concerto',
    'TTR': 'Teatro',
    'ART': 'Exposição de Arte',
    'SPT': 'Esportes',
    'COP': 'Competição',
    'LCT': 'Palestra',
    'CFE': 'Conferência',
    'FAR': 'Feira',
    'GST': 'Gastronomia',
    'SUP': 'Stand-up Comedy',
    'TRS': 'Tour / Atração',
    'WRK': 'Curso / Workshop',
    'KID': 'Infantil / Família',
    'PRD': 'Pride / LGBTQIA+',
    'ONL': 'Evento Online',
    'REL': 'Religião / Espiritualidade',
  'TEC': 'Tecnologia',
    'OTH': 'Outros',
  };
bool? eventoPrivado, eventoGratuito;

int? faixaEtaria;
//===================FIM DE EVENTOS=============================================

//===================LOCAIS=====================================================
  String? nomeLocal, cep,bairro,cidade, rua, estado, numero,capaciMaxima,
      telefone, celular, tipoEndereco;
  bool? acessibilidade, enderecoPrivado;
//===================FIM DE LOCAIS==============================================

//===================OPERACIONAL================================================
  String? nomeIngresso;
  num? valor, taxa;
  bool? gratuito;
//===================FIM DE OPERACIONAL=========================================

//=======================IMAGENS================================================
  String? linkLocal, linkEstabelecimento;
//=======================FIM DE IMAGENS=========================================


  @override
  void initState() {
    super.initState();
    // page = 1;
    //  _scrollController.addListener(_verificaScroll);
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
                            controller: TextEditingController(text: nomeEvento),
                            onChanged:(value){
                              nomeEvento=value;
                            },
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
                                        controller: TextEditingController(text: dataInicio),
                                        onChanged:(value){
                                          dataInicio=value;
                                        },
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
                                        controller: TextEditingController(text: dataFinal),
                                        onChanged:(value){
                                          dataFinal=value;
                                        },
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
                                        controller: TextEditingController(text: horaInicio),
                                        onChanged:(value){
                                          horaInicio=value;
                                        },
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
                                        controller: TextEditingController(text: horaFinal),
                                        onChanged:(value){
                                          horaFinal=value;
                                        },
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
                                      'Evento gratuito',
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
                                          onTap: () {eventoGratuito=true;
                                          sa(() {});

                                          },
                                          child: CircleAvatar(
                                            backgroundColor: !(eventoGratuito??false)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),

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
                                          onTap: () {eventoGratuito=false;
                                          sa(() {});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: (eventoGratuito??true)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),
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
                                      'Evento privado',
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
                                          onTap: () {eventoPrivado=true;
                                            sa(() {});

                                            },
                                          child: CircleAvatar(
                                            backgroundColor: !(eventoPrivado??false)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),

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
                                          onTap: () {eventoPrivado=false;
                                          sa(() {});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: (eventoPrivado??true)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),
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
                            bottom: 20,
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
                                  controller: TextEditingController(text: frequencia),
                                  onChanged:(value){
                                    frequencia=value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                   //   bottom: 20,
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
                            //top: 10,
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
                                  controller: TextEditingController(text: descriEvento),
                                  onChanged:(value){
                                    descriEvento=value;
                                  },
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
                            controller: TextEditingController(text: nomeLocal),
                            onChanged:(value){
                              nomeLocal=value;
                            },
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
                           // spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex:1,
                                child: Text(
                                  'Telefone:',
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

                                  controller: TextEditingController(text: telefone),
                                  onChanged:(value){
                                    telefone=value;
                                  },
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
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            // spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex:1,
                                child: Text(
                                  'Celular:',
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
                                  controller: TextEditingController(text: celular),
                                  onChanged:(value){
                                    celular=value;
                                  },
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
                                      'Acessibilidade',
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
                                          onTap: () {acessibilidade=true;
                                          sa(() {});

                                          },
                                          child: CircleAvatar(
                                            backgroundColor: !(acessibilidade??false)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),

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
                                          onTap: () {acessibilidade =false;
                                          sa(() {});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: (acessibilidade??true)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),
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
                                      'Endereço privado',
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
                                          onTap: () {enderecoPrivado=true;
                                          sa(() {});

                                          },
                                          child: CircleAvatar(
                                            backgroundColor: !(enderecoPrivado??false)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),

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
                                          onTap: () {enderecoPrivado=false;
                                          sa(() {});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: (enderecoPrivado??true)?Color.fromRGBO(
                                              191,
                                              205,
                                              189,
                                              1,
                                            ):Color.fromRGBO(244, 177, 52, 1),
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
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                //flex: 1,
                                child: Text(
                                  'CEP:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:3,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  controller: TextEditingController(text: cep),
                                  onChanged:(value){
                                    cep=value;
                                  },
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
                                //flex: 1,
                                child: Text(
                                  'Estado:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:3,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  controller: TextEditingController(text: estado),
                                  onChanged:(value){
                                    estado=value;
                                  },
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
                                //flex: 1,
                                child: Text(
                                  'Cidade:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:3,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  controller: TextEditingController(text: cidade),
                                  onChanged:(value){
                                    cidade=value;
                                  },
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
                                //flex: 1,
                                child: Text(
                                  'Bairro:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:3,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  controller: TextEditingController(text: bairro),
                                  onChanged:(value){
                                    bairro=value;
                                  },
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
                                //flex: 1,
                                child: Text(
                                  'Rua:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:3,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  controller: TextEditingController(text: rua),
                                  onChanged:(value){
                                    rua=value;
                                  },
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
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            spacing:10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                //flex: 1,
                                child: Text(
                                  'Número:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:1,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  controller: TextEditingController(text: numero),
                                  onChanged:(value){
                                    numero=value;
                                  },
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
                                //flex: 1,
                                child: Text(
                                  'Capacidade máxima:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 1,),
                              Expanded(
                                flex:1,
                                //  child: Padding(
                                //padding: const EdgeInsets.only(left:50),
                                child: TextField(
                                  controller: TextEditingController(text: capaciMaxima),
                                  onChanged:(value){
                                    capaciMaxima=value;
                                  },
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
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 20,
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            //spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Categoria:',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              Flexible(
                                child:
                                DropdownButtonFormField<String>(
                                  isExpanded: true,               // ← permite usar toda a largura do pai
                                  dropdownColor: Color.fromRGBO(191, 205, 189, 1), // cor de fundo do menu
                                  value: categoriaSelecionada,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10, bottom: 1),
                                      filled: true,
                                      fillColor: Color.fromRGBO(191, 205, 189, 1),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    hint: Text('Selecione uma categoria'),
                                  items: _labels.entries.map((entry) {
                                    return DropdownMenuItem<String>(
                                      value: entry.key,         // A CHAVE (ex: 'FST')
                                      child: Text(entry.value), // O RÓTULO (ex: 'Festival')
                                    );
                                  }).toList(),
                                    onChanged: (novo) {
                                    print(novo);
                                      setState(() {
                                        categoriaSelecionada = novo;
                                      });
                                    },
                                  ),
                                )
                                //   ),
                            ],
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
                                    controller: TextEditingController(text: linkLocal),
                                    onChanged:(value){
                                      linkLocal=value;
                                    },
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
                                    controller: TextEditingController(text: linkEstabelecimento),
                                    onChanged:(value){
                                      linkEstabelecimento=value;
                                    },
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
                  onPressed: () async {
                    if(tela<3){
                    tela++;
                    setState(() {});
                    }
                    //Navigator.of(context).pop();
                    // aplicar filtro…
                    else{


Map<String, dynamic> adressCriado = {
'adress_zip_code':cep,
'adress_city':cidade,
'adress_state':estado,
'adress_street':rua,
'adress_neighborhood':bairro,
};
print(adressCriado);


//adresses.add(adress);
//print(adress.toJson());
//print(adresses);

if(enderecoPrivado??false){
  tipoEndereco='Privado';
}
else{
  tipoEndereco='Público';
}
print('criou adress');
Map<String, dynamic> spaceCriado = {
  'max_capacity':capaciMaxima,
  'name':nomeLocal,
  'acessibility':acessibilidade,
  'phone':telefone,
  'mobile':celular,
  'type_adress':tipoEndereco,
  'adress':linkLocal,
};
final List<SpaceModel> spaces = [];




                      final List<EventModel> events = [];

                      if((eventoGratuito??false) && (eventoPrivado??false)){
                        tipoEvento='Público Privado';
                        print(tipoEvento);
                      }
                      else {
                        if(eventoPrivado??false)tipoEvento='Privado';
                        if(eventoGratuito??false)tipoEvento='Público';
                      }
                      Map<String,dynamic> evtCriado ={
                        'title':nomeEvento,
                        'description':descriEvento,
                        'start_date':dataInicio?.split('/').reversed.join('-'),
                        'end_date':dataFinal?.split('/').reversed.join('-'),
                        'start_time':horaInicio,
                        'endtime':horaFinal,
                        'status':true,
                        'category':categoriaSelecionada,
                        'space': 1,
                        'type_event':tipoEvento,
                        'age_range':faixaEtaria,
                      };
                      final SpaceModel space = SpaceModel.fromMap(spaceCriado);
                      final EventModel event = EventModel.fromMap(evtCriado);
                      final AdressModel adress = AdressModel.fromMap(adressCriado);
                 //     events.add(event);
                  //    print(event.toJson());
                      print(events);

                      print(adress.adress_zip_code);


                //      spaces.add(space);
                 //     print(space.toJson());
                 //     print(space);


//final AdressRepository adressRepository = AdressRepository();
                      final httpClient = HttpClient();
                      final repo = EventRepository(client: httpClient);
                     // print('JSON enviado: ${(adress.toJson())}');
                    //  final EventModel event = EventModel.fromMap(evtCriado);
                    //  final SpaceModel space = SpaceModel.fromMap(spaceCriado);


                      var create = await repo.createEvent(evtCriado, spaceCriado, adressCriado);


//print(spaceCriado);
  /*
    class SpaceModel {
    final String max_capacity;
    final String name;
    final String acessibility;
    final String phone;
    final String mobile;
    final String type_adress;
    final String adress;
    final String created_at;


   */


                      /*
                      event = evtCriado.;
                      factory EventModel.fromMap(Map<String, dynamic> map) {
                        return EventModel(
                          id: map['id']??0,
                          title: map['title']??'',
                          description: map['description']??'',
                          start_date: map['start_date']??'',
                          end_date: map['end_date']??'',
                          start_time: map['start_time']??'',
                          endtime: map['endtime']??'',
                          status: map['status']??false,
                          category: map['category']??'',
                          space: map['space']??0,
                          type_event: map['type_event']??'',
                          age_range: map['age_range']??0,
                          crated_at: map['crated_at']??'',
                          documentations: map['documentations']??'',
                          participants: map['participants']??[],
                        );
                      }
                    //required this.id,
                    required this.title,
                    required this.description,
                    required this.start_date,
                    required this.end_date,
                    required this.start_time,
                    required this.endtime,
                    required this.status,
                    required this.category,
                    required this.space,
                    required this.type_event,
                    required this.age_range,
                    required this.crated_at,
                    required this.documentations,
                    required this.participants,


                       */
                    }
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
