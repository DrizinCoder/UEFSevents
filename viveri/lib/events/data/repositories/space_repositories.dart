import 'dart:convert';

import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/space_model.dart';

abstract class ISpaceReposity {
  Future<List<SpaceModel>> getSpace();
}

class SpaceRepository implements ISpaceReposity {
  final IHttpClient client;

  SpaceRepository({required this.client});
  @override
  Future<List<SpaceModel>> getSpace() async {
    final response = await client.get(
      url: 'http://localhost:8000/api/eventsapi/',
    );
    if (response.statusCode == 200) {
      final List<SpaceModel> events = [];

      final body = jsonDecode(response.body);

      body['events'].map((item) {
        final SpaceModel event = SpaceModel.fromMap(item);
        events.add(event);
      }).toList();
      return events;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'A url informada não é válida');
    } else {
      throw Exception('Não foi possível encontrar os eventos');
    }
  }



  Future createSpace(SpaceModel space) async {
    final url = 'http://localhost:8000/api/space/';

    final response = await client.post(
      url: url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUzOTg0Njc1LCJpYXQiOjE3NTEzOTI2NzUsImp0aSI6IjE2NjRiYjdlOGVlZTQ1ODg5MzlmYWQzZjRlOTM4MjI5IiwidXNlcl9pZCI6MX0.KXaCfHzjRrpp9yP5aP059ySKSe7_kypxrFCZ3JxZ5Xk' // se necessário
      },
      body: jsonEncode(space.toJson()), // ou event.toJson() se você tiver esse método
    );
    print('Status createSpace: ${response.statusCode}');
    print('Corpo createSpace: ${response.body}');
    //final body = jsonDecode(response.body);
  //  print('Corpo do erro: ${response.body}');

    if (response.statusCode == 201) {
      print('Evento criado com sucesso');
      final spaceid = jsonDecode(response.body)['id'];
      return spaceid;
    } else {
      //return 'Erro ao criar evento: ${response.statusCode}';
      throw Exception('Erro ao criar space');
    }
  }

}
