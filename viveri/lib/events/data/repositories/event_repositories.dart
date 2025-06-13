import 'dart:convert';

import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/event_model.dart';

abstract class IEventReposity {
  Future<List<EventModel>> getEvent();
}
int page = 1;
class EventRepository implements IEventReposity {
  final IHttpClient client;

  EventRepository({required this.client});
  @override
  Future<List<EventModel>> getEvent() async {
    final response = await client.get(
      url: 'http://localhost:8000/api/eventsapi/?page=$page',
    );
    if (response.statusCode == 200) {
      //print("resposta 200");
      final List<EventModel> events = [];

      final body = jsonDecode(response.body);
      print('asddads');
      print(body);
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
}
