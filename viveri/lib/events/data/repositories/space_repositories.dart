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
}
