import 'dart:convert';

import 'package:viveri/events/data/http/exceptions.dart';
import 'package:viveri/events/data/http/http_client.dart';
import 'package:viveri/events/data/model/adress_model.dart';

abstract class IAdressReposity {
  Future<List<AdressModel>> getAdress();
}

class AdressRepository implements IAdressReposity {
  final IHttpClient client;

  AdressRepository({required this.client});
  @override
  Future<List<AdressModel>> getAdress() async {
    final response = await client.get(
      url: 'http://localhost:8000/api/eventsapi/',
    );
    if (response.statusCode == 200) {
      final List<AdressModel> adress = [];

      final body = jsonDecode(response.body);

      body['adress'].map((item) {
        final AdressModel event = AdressModel.fromMap(item);
        adress.add(event);
      }).toList();
      return adress;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'A url informada não é válida');
    } else {
      throw Exception('Não foi possível encontrar os eventos');
    }
  }
}
