import 'dart:convert';

import 'package:http/http.dart';
import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/event_model.dart';
import 'package:viveri/events/data/repositories/adress_repositories.dart';
import 'package:viveri/events/data/repositories/space_repositories.dart';
import 'package:viveri/events_search.dart'show limit;

import 'package:viveri/events/data/model/adress_model.dart';
import 'package:viveri/events/data/model/space_model.dart';

//late String next;
abstract class IEventReposity {
  Future<List<EventModel>> getEvent(page);
 // Future<List<EventModel>> createEvent(EventModel event);

// Future<List<EventModel>> getNextEvent(page);

  //getNextEvents(next) {}
}

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


  Future<void> createEvent(Map<String,dynamic> evtCriado, Map<String,dynamic> spaceCriado, Map<String,dynamic> adressCriado) async {
    final url = 'http://localhost:8000/api/eventsapi/';
//print(evtCriado);
//print(adressCriado);
//print(spaceCriado);
//print('printou os coiso');
    final AdressModel adress = AdressModel.fromMap(adressCriado);
//print(adress.adress_city);

    //final AdressModel adress = AdressModel.fromMap(adressCriado);
    final AdressRepository adressRepo = AdressRepository(client: client);
    var id_adress = await adressRepo.createAdress(adress);
    spaceCriado['adress'] = id_adress.toString();
//print(spaceCriado);
//print('printou space');
    final SpaceModel space = SpaceModel.fromMap(spaceCriado);
    //print(space.adress);
    //print("printou space.adress");
    final SpaceRepository spaceRepo = SpaceRepository(client: client);
    //print('spaceRepo');
    var id_space = await spaceRepo.createSpace(space);
    //print('id $id_space');

    evtCriado['space'] = id_space;

    final EventRepository repo = EventRepository(client: client);



    final EventModel event = EventModel.fromMap(evtCriado);


    final response = await client.post(
      url: url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUzOTg0Njc1LCJpYXQiOjE3NTEzOTI2NzUsImp0aSI6IjE2NjRiYjdlOGVlZTQ1ODg5MzlmYWQzZjRlOTM4MjI5IiwidXNlcl9pZCI6MX0.KXaCfHzjRrpp9yP5aP059ySKSe7_kypxrFCZ3JxZ5Xk' // se necessário
      },
      body: jsonEncode(event.toJson()), // ou event.toJson() se você tiver esse método
    );
   print('Status createSpace: ${response.statusCode}');
    print('Corpo createSpace: ${response.body}');
    if (response.statusCode == 201) {
      print('Evento criado com sucesso');
    } else {
      print('Erro ao criar evento: ${response.statusCode}');
      throw Exception('Erro ao criar evento');
    }
  }

// event_repositories.dart
  Future<SpaceModel> getSpaceById(int id) async {
    final response = await client.get(
      url: 'http://localhost:8000/api/spaces/$id/' // URL da API para espaços
    );

    if (response.statusCode == 200) {
      return SpaceModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar espaço');
    }
  }

     Future<EventModel> getEventById(int id) async {
    final response = await client.get(
      url: 'http://localhost:8000/api/spaces/$id/' // URL da API para espaços
    );

    if (response.statusCode == 200) {
      return EventModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar espaço');
    }
  }







Future<List<EventModel>> searchEventsByName(String name, {int page = 1}) async {
  final encodedName = Uri.encodeQueryComponent(name);
  final url = 'http://localhost:8000/api/eventsapi/?search=$encodedName&page=$page';

  final response = await client.get(url: url);

  print('Status createSpace: ${response.statusCode}');
  print('Corpo createSpace: ${response.body}');

  if (response.statusCode == 200) {
    final List<EventModel> events = [];
    final body = jsonDecode(response.body);

    for (var item in body['results']) {
      events.add(EventModel.fromMap(item));
    }

    // Se não houver próxima página, você pode usar o mesmo flag que no getEvent
    if (body['next'] == null) {
      limit = true;
    }

    return events;
  } else if (response.statusCode == 404) {
    throw NotFoundException(message: 'URL inválida para busca de eventos');
  } else {
    throw Exception('Falha ao buscar eventos por nome');
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