import 'dart:convert';

import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/events_search.dart'show limit;

//late String next;
abstract class IEventReposity {
  Future<List<EventModel>> getEvent(page);
 // Future<List<EventModel>> getNextEvent(page);

  //getNextEvents(next) {}
}
//int page = 1;
class EventRepository implements IEventReposity {
 // String url =next.isEmpty? 'http://localhost:8000/api/eventsapi/?':next.toString();
  final IHttpClient client;

  EventRepository({required this.client});
  @override
  Future<List<EventModel>> getEvent(page ) async {
    print(page);
    //print('repositooy : $next');

    final response = await client.get(
     // url: 'http://localhost:8000/api/eventsapi/?',
       url:'http://localhost:8000/api/eventsapi/?page=$page',
    );
  //  print('http://localhost:8000/api/eventsapi/?page=$page');
    //next='';
    if (response.statusCode == 200) {
      //print("resposta 200");
      final List<EventModel> events = [];

      final body = jsonDecode(response.body);
    //  print(body['next']);
     // print('printou bodsada');
    //  next = body['next'];
      body['results'].map((item) {
        final EventModel event = EventModel.fromMap(item);
        events.add(event);
      }).toList();
      if(body['next']==null){
       limit=true;
      print('acabou');
     }
      return events;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'A url informada não é válida');
    } else {
      throw Exception('Não foi possível encontrar os eventos');
    }
  }
/*
  Future<List<EventModel>> getNextEvent(next) async {
    final response = await client.get(
      url: '$next',
    );
    if (response.statusCode == 200) {
      final List<EventModel> events = [];
      final body = jsonDecode(response.body);
      body['results'].map((item) {
        final EventModel event = EventModel.fromMap(item);
        events.add(event);
      }).toList();
      return events;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'A url informada não é válida');
    } else {
      throw Exception('Não foi possível encontrar os eventos');
    }


}
 */



}





/*
Future<void> createEvent(EventModel event) async {
  final url = 'http://localhost:8000/api/eventsapi/';

  final response = await client.post(
    url: url,
    headers: {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer SEU_TOKEN' // se necessário
    },
    body: jsonEncode(event.toMap()), // ou event.toJson() se você tiver esse método
  );

  if (response.statusCode == 201) {
    print('Evento criado com sucesso');
  } else {
    print('Erro ao criar evento: ${response.statusCode}');
    throw Exception('Erro ao criar evento');
  }
}


 */