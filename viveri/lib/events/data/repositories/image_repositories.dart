import 'dart:convert';

import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/image_model.dart';

import '../model/event_model.dart';

abstract class IImageReposity {
  Future<List<ImageModel>> getImage();
}

class ImageRepository implements IImageReposity {
  final IHttpClient client;

  ImageRepository({required this.client});
  @override
  Future<List<ImageModel>> getImage() async {
    final response = await client.get(
      url: 'http://localhost:8000/api/eventsapi/',
    );
    if (response.statusCode == 200) {
      final List<ImageModel> events = [];

      final body = jsonDecode(response.body);

      body['events'].map((item) {
        final ImageModel event = ImageModel.fromMap(item);
        events.add(event);
      }).toList();
      return events;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'A url informada não é válida');
    } else {
      throw Exception('Não foi possível encontrar os eventos');
    }
  }



  Future createImage(accessToken, ImageModel image) async {
    final url = 'http://localhost:8000/api/eventsimage/';

    final response = await client.post(
      url: url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(image.toJson()), // ou event.toJson() se você tiver esse método
    );
  //  print('Status createImage: ${response.statusCode}');
   // print('Corpo createImage: ${response.body}');
    //final body = jsonDecode(response.body);
    //  print('Corpo do erro: ${response.body}');

    if (response.statusCode == 201) {
    //  print('Evento criado com sucesso');
      final imageid = jsonDecode(response.body)['id'];
      return imageid;
    } else {
      //return 'Erro ao criar evento: ${response.statusCode}';
      throw Exception('Erro ao criar image');
    }
  }

  Future<List<ImageModel>> searchImagesByEvent(List<String> events, {int page = 1}) async {
   // final encodedName = name;
    if (events.isEmpty) return [];

    final csv = events.map((e) => e.toString()).join(',');
    final url =
        'http://localhost:8000/api/eventsimage/?event_ids=$csv&page=$page';
   // final url = 'http://localhost:8000/api/eventsimage/?event_ids=$events&page=$page';

    final response = await client.get(url: url);

    //print('Status createSpace: ${response.statusCode}');
    //print('Corpo createSpace: ${response.body}');

    if (response.statusCode == 200) {
      final List<ImageModel> images = [];
      final body = jsonDecode(response.body);

      for (var item in body['results']) {
        images.add(ImageModel.fromMap(item));
      }

      if (body['next'] == null) {
       // return;
      }

      return images;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'URL inválida para busca de eventos');
    } else {
      throw Exception('Falha ao buscar eventos por nome');
    }
  }


}